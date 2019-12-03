import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sistema_transporte/src/models/user.dart';
import 'package:sistema_transporte/src/pages/MainMenu/mainMenu.dart';
import 'package:sistema_transporte/src/provider/registerProvider.dart';
import 'package:sistema_transporte/src/provider/userProvider.dart';

class SignIn extends StatefulWidget {
  SignIn({Key key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool _isLoading = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return _isLoading ?
    Container(
      decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.white, Colors.blue[100]],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)),
        child: Center(
          child: CircularProgressIndicator()
        )
    ) : 
    Scaffold(
      key: scaffoldKey,
      body: SafeArea(
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
              buttons(),
            ],
          ),
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
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Container(
          //height: MediaQuery.of(context).size.height / 7,
          margin: EdgeInsets.fromLTRB(15, 5, 10, 0),
          child: Text("Crea tu cuenta",
          textAlign: TextAlign.center,
               style: TextStyle(color: Colors.blue, 
                                fontStyle: FontStyle.italic, 
                                fontWeight: FontWeight.bold, 
                                fontSize: 30 )
                      )
                  ),
        Container(
          height: MediaQuery.of(context).size.height / 7,
          margin: EdgeInsets.fromLTRB(15, 5, 10, 0),
          child: Image.asset("assets/LogoSIT.png", fit: BoxFit.contain),
        ),
      ],
    );
  }

  Widget body() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 25.0),
      margin: EdgeInsets.only(top: 15.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            txtNombre("Nombre", Icons.person),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                txtApellidoPaterno("Apellido Paterno"),
                //SizedBox(width: MediaQuery.of(context).size.width /  ),
                txtApellidoMaterno("Apellido Materno"),
              ],
            ),
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
      ),
    );
  }

  Widget txtUser(String title) {
    return TextFormField(
      controller: userController,
      obscureText: false,
      decoration: InputDecoration(hintText: title),
      validator: (value){
        if(value.isEmpty){
          return "El campo usuario es requerido";
        }
        if(value.length < 5){
          return "El usuario debe tener mas de 5 caracteres";
        }
        return null;
      },
    );
  }

  Widget txtNombre(String title, IconData icon) {
    return TextFormField(
      controller: nombreController,
      obscureText: false,
      decoration: InputDecoration(hintText: title, icon: Icon(icon)),
      validator: (value){
        if(value.isEmpty){
          return "Por favor ingrese su nombre";
        }
        return null;
      },
    );
  }

  Widget txtApellidoPaterno(String title) {
    return Container(
      width: MediaQuery.of(context).size.width / 2.5,
      child: TextFormField(
        controller: apellidoPaternoController,
        obscureText: false,
        decoration: InputDecoration(hintText: title),
        validator: (value){
          if(value.isEmpty){
            return "Por favor ingrese su apellido";
          }
          return null;
        },
      ),
    );
  }

  Widget txtApellidoMaterno(String title) {
    return Container(
      width: MediaQuery.of(context).size.width / 2.5,
      child: TextFormField(
        controller: apellidoMaternoController,
        obscureText: false,
        decoration: InputDecoration(hintText: title),
        validator: (value){
          if(value.isEmpty){
            return "Por favor ingrese su apellido";
          }
          return null;
        },
      ),
    );
  }

  Widget txtDNI(String title) {
    return TextFormField(
      controller: dniController,
      obscureText: false,
      decoration: InputDecoration(hintText: title),
      validator: (value){
        if(value.length!=8){
          return "Por favor ingrese un DNI Valido";
        }
        return null;
      },
    );
  }

  Widget txtMail(String title) {
    return TextFormField(
      controller: mailController,
      obscureText: false,
      decoration: InputDecoration(hintText: title),
      validator: (value){
        if(value.isEmpty){
          return "Por favor ingrese su mail";
        }
        
        return null;
      },
    );
  }

  Widget txtTelefono(String title) {
    return TextFormField(
      controller: telefonoController,
      obscureText: false,
      decoration: InputDecoration(hintText: title),
      validator: (value){
        if(value.isEmpty){
          return "Por favor ingrese su telefono";
        }
        
        return null;
      }, 
    );
  }

  Widget txtPassword(String title) {
    return TextFormField(
      controller: passwordController,
      obscureText: true,
      decoration: InputDecoration(hintText: title),
      validator: (value){
        if(value.isEmpty){
          return "La contraseña es requerida";
        }
        else if (value.length < 5){
          return "La contraseña debe tener  mas de5 caracteres";
        }
        return null;
      },
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
                  minWidth: MediaQuery.of(context).size.width / 1.5, minHeight: 50),
              fillColor: Colors.blue[300],
              child: Text("Registrarse",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              onPressed: () async {
                setState(() {
                  _isLoading = true;
                });
                  if(_formKey.currentState.validate()){
                      RegisterProvider registerProvider = new RegisterProvider();
                      //UserProvider providerUser = new UserProvider();
                      User usuario = await registerProvider.registrarUser(
                                                nombreController.text,
                                                apellidoPaternoController.text,
                                                apellidoMaternoController.text,
                                                dniController.text,
                                                telefonoController.text,
                                                mailController.text,
                                                userController.text,
                                                passwordController.text );
                      Provider.of<UserProvider>(context, listen: false).setUsuario(usuario);
                      var providerUsuario = Provider.of<UserProvider>(context, listen: false).getUsuario();
                      if(providerUsuario!=null){        
                      var route = new MaterialPageRoute(builder: (BuildContext context) => MainMenu());
                      Navigator.of(context).pushReplacement(route);
                  }
                }
                else {
                  setState(() {
                      _isLoading = false;
                  });
                  scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("Error al registrar"), backgroundColor: Colors.red[100], duration: Duration(seconds: 2)));
                }
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0))),
        ],
      ),
    );
  }
}
