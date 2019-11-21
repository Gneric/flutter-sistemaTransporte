import 'package:flutter/material.dart';

class Configuracion extends StatefulWidget {
  Configuracion({Key key}) : super(key: key);

  @override
  _ConfiguracionState createState() => _ConfiguracionState();
}

class _ConfiguracionState extends State<Configuracion> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[400],
        title: Text("Configuracion"),
        centerTitle: true,
      ),
      body: Container(
        child: Center(
          child: Text("En construccion"),
        ),
      ),
    );
  }
}