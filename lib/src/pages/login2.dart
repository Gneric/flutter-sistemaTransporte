import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sistema_transporte/src/models/trarjetasTren.dart';
import 'package:sistema_transporte/src/models/user.dart';
import 'package:sistema_transporte/src/pages/mainMenu.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;
  static const snackBarDuration = Duration(seconds: 2);

  final snackBar = SnackBar(
    content: Text('Presione nuevamente para salir de la aplicacion'),
    duration: snackBarDuration,
    backgroundColor:  Colors.red,
  );

  final scaffoldKey = GlobalKey<ScaffoldState>();

  DateTime backButtonPressTime;

  Future<bool> onWillPop() async {
    DateTime currentTime = DateTime.now();
    bool backButtonHasNotBeenPressedOrSnackBarHasBeenClosed =
         backButtonPressTime == null ||
         currentTime.difference(backButtonPressTime) > snackBarDuration;

    if (backButtonHasNotBeenPressedOrSnackBarHasBeenClosed) {
      backButtonPressTime = currentTime;
      scaffoldKey.currentState.showSnackBar(snackBar);
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        body: WillPopScope(
            onWillPop: onWillPop,
            child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.white, Colors.green[100]],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter)),
            child: _isLoading ? Center(child: CircularProgressIndicator()) : ListView(
              children: <Widget>[
                header(),
                body(),
                buttons(),
              ],
            ),
          ),
        ),
    );
  }

  TextEditingController userController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController txtResponse = new TextEditingController();
  /*
  recopilarDatosTarjeta(TarjetasTren tarjeta) async {
      print("Recopilando datos de tarjeta "+tarjeta.codigo);
      HttpClient httpClient = new HttpClient();
      String endPoint = "http://192.168.0.16:8080/SIT-api/operacionesGet/operaciones/${tarjeta.codigo}";
      HttpClientRequest request = await httpClient.getUrl(Uri.parse(endPoint));
        request.headers.set('content-type', 'application/json');
      HttpClientResponse response = await request.close();
      String reply = await response.transform(utf8.decoder).join();
      var jsonMovimientos = null;
      if(response.statusCode<400 && response.statusCode>200){
          jsonMovimientos = json.decode(reply);
          final user = Provider.of<User>(context);
          user.addMovimientos(jsonMovimientos);
      }
      else {
        setState(() {
              _isLoading = false;
              scaffoldKey.currentState.showSnackBar(SnackBar(
                content: Text('Error de carga de Movimientos'),
                duration: Duration(seconds: 2),
                backgroundColor:  Colors.red
              ));
          }); 
      }
  }*/

  Future signIn(String user, String password) async {
    try{  
        Map data = {'user': user, 'password': password};
        HttpClient httpClient = new HttpClient();
        HttpClientRequest request = await httpClient.postUrl(Uri.parse('http://192.168.0.16:8080/SIT-api/clientesPost/Login'));
          request.headers.set('content-type', 'application/json'); //Se vuelve JSON
          request.add(utf8.encode(json.encode(data)));  // Se hace el enconde    
        HttpClientResponse response = await request.close();
        //SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
        String reply = await response.transform(utf8.decoder).join();
        var jsonData;
        print("response Code: " + response.statusCode.toString());
        
        if (response.statusCode<400 && response.statusCode>200) {     
          jsonData = json.decode(reply);
          setState(() {      
            //sharedPreferences.setString("loginToken", jsonData['dni_CLIENTE']);
            //print(sharedPreferences.get("loginToken"));
            List<TarjetasTren> lista;
            /*
            for (var i = 0; i < jsonData['tarjetas'].length; i++) {
                Map<String, dynamic> tarjetaMap = jsonData['tarjetas'][i];
                TarjetasTren tarjeta = new TarjetasTren.fromJson(tarjetaMap);
                  print(tarjetaMap);
                  print(tarjeta.fechaCaducidad);
                  print(tarjeta.fechaEmision);
                  print(tarjeta.saldoTarjeta);
                  print(tarjeta.codigoTarjeta);
                  print(tarjeta.estadoTarjeta);
                  print(tarjeta.perfilTarjeta);
                  print(tarjeta.usuarioTarjeta);
                  print("This this doesnt work");
                  lista.add(tarjeta);

                  if(i == jsonData['tarjetas'] ){
                    print(lista);
                  }                  
            } */
            jsonData['tarjetas'].map( (row) => {
                lista.add(new TarjetasTren.fromJson(row))
            });
            print("Lista");
            print(lista);
            print("-----------");
            
            User.storeUser(jsonData, lista);
            httpClient.close();
            print("Cerro httpClient");
            _isLoading = false;
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (BuildContext context) => MainMenu()),
              (Route<dynamic> route) => false); 
          });
        } else {
          setState(() {
              _isLoading = false;
              scaffoldKey.currentState.showSnackBar(SnackBar(
                content: Text('Error de statusCode de respuesta'),
                duration: Duration(seconds: 2),
                backgroundColor:  Colors.red
              ));
          }); 
        }
        httpClient.close();
        print(jsonData);
    }
    catch(Exception){
      setState(() {
              _isLoading = false;
              scaffoldKey.currentState.showSnackBar(SnackBar(
                content: Text('Error al tratar de conectarse'),
                duration: Duration(seconds: 2),
                backgroundColor:  Colors.red
              ));
              
      });     
    }   
  }

  Widget header() {
    return Container(
      height: 155.0,
      margin: EdgeInsets.symmetric(vertical: 50.0),
      child: Image.asset("assets/LogoSIT.png", fit: BoxFit.contain),
    );
  }

  Widget body() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
      margin: EdgeInsets.only(top: 30.0),
      child: Column(
        children: <Widget>[
          txtUser("Usuario", Icons.person),
          SizedBox(height: 30.0),
          txtPassword("Contraseña", Icons.lock)
        ],
      ),
    );
  }

  Widget txtUser(String title, IconData icon) {
    return TextFormField(
      controller: userController,
      obscureText: false,
      decoration: InputDecoration(hintText: title, icon: Icon(icon)),
    );
  }

  Widget txtPassword(String title, IconData icon) {
    return TextFormField(
      controller: passwordController,
      obscureText: true,
      decoration: InputDecoration(hintText: title, icon: Icon(icon)),
    );
  }

  errMessage() {
    
  }

  Widget buttons() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 200.0,
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
      margin: EdgeInsets.only(top: 30.0),
      child: Column(
        children: <Widget>[
          RawMaterialButton(
            constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width, minHeight: 50),
            fillColor: Colors.green[300],
            child: Text("Ingresar", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            onPressed: () {
              setState(() {_isLoading = true;});
              signIn(userController.text, passwordController.text);
            },
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0))
          ),
          SizedBox(height: 35),
          RawMaterialButton(
            constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width, minHeight: 50),
            fillColor: Colors.green[300],
            child: Text("Registrarse", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            onPressed: () {
              
            },
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0))
          )
        ],
      ),
    );
  }


}
