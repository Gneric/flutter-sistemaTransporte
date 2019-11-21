import 'package:flutter/material.dart';

class Planeador extends StatefulWidget {
  Planeador({Key key}) : super(key: key);

  @override
  _PlaneadorState createState() => _PlaneadorState();
}

class _PlaneadorState extends State<Planeador> {
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