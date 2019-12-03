import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sistema_transporte/src/models/user.dart';
import 'package:sistema_transporte/src/pages/LogIn/signInScreen.dart';
import 'package:sistema_transporte/src/pages/MainMenu/mainMenu.dart';
import 'package:sistema_transporte/src/provider/userProvider.dart';

class LoginPage extends StatefulWidget {

  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String mensaje;
  bool _isLoading = false;
  DateTime backButtonPressTime;
  static const snackBarDuration = Duration(seconds: 2);
  final GlobalKey<ScaffoldState> scaffoldLoginKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  snackBar(msg){
    return SnackBar(
      content: Text(msg),
      duration: snackBarDuration,
      backgroundColor: Colors.red,
    );
  }

  Future<bool> onErrorSnackBar(GlobalKey<ScaffoldState> key) async {
    try{
      final logError =  SnackBar(
        content: Text('El usuario o contraseña son incorrectos', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold), textAlign: TextAlign.center, ),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red[100]
      );
      print("Error al logear: ${scaffoldLoginKey.currentState}");
      key.currentState.showSnackBar(logError);
      return true;
    }catch(e){
      print("Error onErrorSnackBar: $e");
      return false;
    }
  }

  Future<bool> onWillPop() async {
    DateTime currentTime = DateTime.now();
    bool backButtonHasNotBeenPressedOrSnackBarHasBeenClosed =
        backButtonPressTime == null ||
            currentTime.difference(backButtonPressTime) > snackBarDuration;

    if (backButtonHasNotBeenPressedOrSnackBarHasBeenClosed) {
      backButtonPressTime = currentTime;
      scaffoldLoginKey.currentState.showSnackBar(snackBar("Presione nuevamente para salir de la aplicacion"));
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      key: scaffoldLoginKey,
      body: _isLoading ? 
      Container(
      decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.white, Colors.blue[100]],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)),
        child: Center(
          child: CircularProgressIndicator()
        )
      )
    : WillPopScope(
        onWillPop: onWillPop,
        child: SafeArea(
            child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.white, Colors.blue[100]],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter)),
            child: ListView(
                    children: <Widget>[
                      header(),
                      body(),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 4,
                        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
                        margin: EdgeInsets.only(top: 30.0),
                        child: Column(
                          children: <Widget>[
                            RawMaterialButton(
                                constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width / 1.5, minHeight: 50),
                                fillColor: Colors.blue[300],
                                child: Text("Iniciar Sesion", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold) ),
                                onPressed: () async {
                                  if(_formKey.currentState.validate()){
                                    setState(() {
                                      _isLoading = true;
                                    });
                                     UserProvider providerUser = new UserProvider();
                                     User usuario = await providerUser.getFileUser(userController.text, passwordController.text);
                                     Provider.of<UserProvider>(context, listen: false).setUsuario(usuario);
                                     var providerUsuario = Provider.of<UserProvider>(context, listen: false).getUsuario();
                                     if(providerUsuario!=null){        
                                       var route = new MaterialPageRoute(builder: (BuildContext context) => MainMenu());
                                      Navigator.of(context).pushReplacement(route);
                                     }
                                    else {
                                      setState(() {
                                          _isLoading = false;
                                          if(_isLoading==false){
                                            if(scaffoldLoginKey.currentState!=null){
                                              Future<bool> idk = onErrorSnackBar(scaffoldLoginKey);
                                            }
                                          }
                                      });
                                    }
                                  }            
                                },
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0) )
                            ),
                            SizedBox(height: 35),
                            RawMaterialButton(
                                constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width / 1.5, minHeight: 50),
                                fillColor: Colors.blue[300],
                                child: Text("Crea tu cuenta", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                                onPressed: () {
                                  var route = new MaterialPageRoute(builder: (BuildContext context) => SignIn());
                                  Navigator.of(context).push(route);
                                },
                                shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(5.0) ))
                          ],
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  TextEditingController userController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController txtResponse = new TextEditingController();

  Widget header() {
    return Column(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height / 7,
          margin: EdgeInsets.symmetric(vertical: 30.0),
          child: Image.asset("assets/LogoSIT.png", fit: BoxFit.contain),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(15, 0, 10, 0),
          child: Text("Bienvenido al Sistema de Transporte",
          textAlign: TextAlign.center,
               style: TextStyle(color: Colors.blue, 
                                fontStyle: FontStyle.italic, 
                                fontWeight: FontWeight.bold,
                                fontSize: 30 )
                      )
                  ),
      ],
    );
  }

  Widget body() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
      margin: EdgeInsets.only(top: 30.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            txtUser("Usuario", Icons.person),
            SizedBox(height: 30.0),
            txtPassword("Contraseña", Icons.lock)
          ],
        ),
      ),
    );
  }

  Widget txtUser(String title, IconData icon) {
    return TextFormField(
      controller: userController,
      obscureText: false,
      decoration: InputDecoration(hintText: title, icon: Icon(icon)),
      validator: (value){
        if(value.isEmpty){
          return "Por favor ingrese su usuario";
        }
        return null;
      },
    );
  }

  Widget txtPassword(String title, IconData icon) {
    return TextFormField(
      controller: passwordController,
      obscureText: true,
      decoration: InputDecoration(hintText: title, icon: Icon(icon)),
      validator: (value){
        if(value.isEmpty){
          return "Por favor ingrese su contraseña";
        }
        return null;
      },
    );
  }

  errMessage() {}

}
