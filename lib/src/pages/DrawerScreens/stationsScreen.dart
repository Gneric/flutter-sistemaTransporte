import 'package:flutter/material.dart';

class Estaciones extends StatefulWidget {
  Estaciones({Key key}) : super(key: key);

  @override
  _EstacionesState createState() => _EstacionesState();
}

class _EstacionesState extends State<Estaciones> {
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