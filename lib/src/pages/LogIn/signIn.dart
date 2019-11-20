import 'package:flutter/material.dart';
import 'package:sistema_transporte/src/provider/registerProvider.dart';

class SignIn extends StatefulWidget {
  SignIn({Key key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.white, Colors.blue[100]],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)),
        child: ListView(
          children: <Widget>[
            header(),
            body(),
            buttons(),
          ],
        ),
      ),
    );
  }

  TextEditingController nombreController = new TextEditingController();
  TextEditingController userController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController apellidoPaternoController = new TextEditingController();
  TextEditingController apellidoMaternoController = new TextEditingController();
  TextEditingController dniController = new TextEditingController();
  TextEditingController mailController = new TextEditingController();
  TextEditingController telefonoController = new TextEditingController();

  Widget header() {
    return Container(
      height: 155.0,
      margin: EdgeInsets.fromLTRB(25, 40, 25, 10),
      child: Image.asset("assets/LogoSIT.png", fit: BoxFit.contain),
    );
  }

  Widget body() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 25.0),
      margin: EdgeInsets.only(top: 30.0),
      child: Column(
        children: <Widget>[
          txtNombre("Nombre", Icons.person),
          SizedBox(height: 20.0),
          txtApellidoPaterno("Apellido Paterno"),
          SizedBox(height: 20.0),
          txtApellidoMaterno("Apellido Materno"),
          SizedBox(height: 20.0),
          txtTelefono("Telefono"),
          SizedBox(height: 20.0),
          txtDNI("DNI"),
          SizedBox(height: 20.0),
          txtMail("E-mail"),
          SizedBox(height: 20.0),
          txtUser("Usuario"),
          SizedBox(height: 20.0),
          txtPassword("Contraseña")
        ],
      ),
    );
  }

  Widget txtUser(String title) {
    return TextFormField(
      controller: userController,
      obscureText: false,
      decoration: InputDecoration(hintText: title),
    );
  }

  Widget txtNombre(String title, IconData icon) {
    return TextFormField(
      controller: userController,
      obscureText: false,
      decoration: InputDecoration(hintText: title, icon: Icon(icon)),
    );
  }

  Widget txtApellidoPaterno(String title) {
    return TextFormField(
      controller: apellidoPaternoController,
      obscureText: false,
      decoration: InputDecoration(hintText: title),
    );
  }

  Widget txtApellidoMaterno(String title) {
    return TextFormField(
      controller: apellidoMaternoController,
      obscureText: false,
      decoration: InputDecoration(hintText: title),
    );
  }

  Widget txtDNI(String title) {
    return TextFormField(
      controller: dniController,
      obscureText: false,
      decoration: InputDecoration(hintText: title),
    );
  }

  Widget txtMail(String title) {
    return TextFormField(
      controller: mailController,
      obscureText: false,
      decoration: InputDecoration(hintText: title),
    );
  }

  Widget txtTelefono(String title) {
    return TextFormField(
      controller: telefonoController,
      obscureText: false,
      decoration: InputDecoration(hintText: title),
    );
  }

  Widget txtPassword(String title) {
    return TextFormField(
      controller: passwordController,
      obscureText: true,
      decoration: InputDecoration(hintText: title),
    );
  }

  Widget buttons() {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 1.0),
      margin: EdgeInsets.only(top: 30.0),
      child: Column(
        children: <Widget>[
          RawMaterialButton(
              constraints: BoxConstraints(
                  minWidth: MediaQuery.of(context).size.width, minHeight: 50),
              fillColor: Colors.blue[300],
              child: Text("Sign In",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              onPressed: () {
                RegisterProvider().registrarUser(
                    nombreController.text,
                    apellidoPaternoController.text,
                    apellidoMaternoController.text,
                    dniController.text,
                    telefonoController.text,
                    mailController.text,
                    userController.text,
                    passwordController.text);
                
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0))),
        ],
      ),
    );
  }
}