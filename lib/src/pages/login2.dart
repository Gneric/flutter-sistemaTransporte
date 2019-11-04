import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sistema_transporte/src/pages/main.dart';

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
        body: Container(
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
    );
  }

  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController txtResponse = new TextEditingController();

  signIn(String email, String password) async {
    Map data = {'email': email, 'password': password};
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var jsonData = null;
    var response = await http.post("http://127.0.0.1:8080/login", body: data);
    if (response.statusCode == 200) {
      jsonData = json.decode(response.body);
      setState(() {
        _isLoading = false;
        sharedPreferences.setString("loginToken", jsonData['loginToken']);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => Main()),
            (Route<dynamic> route) => false);
      });
    } else {
      errMessage();
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
          txtEmail("Email", Icons.email),
          SizedBox(height: 30.0),
          txtPassword("Contraseña", Icons.lock)
        ],
      ),
    );
  }

  Widget txtEmail(String title, IconData icon) {
    return TextFormField(
      controller: emailController,
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
    SnackBar snackBar = SnackBar(
      content: Text('Error de credenciales'),
      duration: snackBarDuration,
      backgroundColor:  Colors.red
    );
    scaffoldKey.currentState.showSnackBar(snackBar);
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
              signIn(emailController.text, passwordController.text);
            },
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0))
          ),
          SizedBox(height: 15),
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
