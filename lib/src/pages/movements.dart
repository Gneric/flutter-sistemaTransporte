import 'package:flutter/material.dart';
import 'package:sistema_transporte/src/pages/drawer.dart';

class Movimientos extends StatefulWidget {
  Movimientos({Key key}) : super(key: key);

  @override
  _MovimientosState createState() => _MovimientosState();
}

class _MovimientosState extends State<Movimientos> {

  @override
  Widget build(BuildContext context) {
    var fecha = DateTime.now();
    var subT = fecha.year.toString()+'/'+fecha.month.toString()+'/'+fecha.day.toString();


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,       
      ),
      drawer: NavigationDrawer(),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: ListView.builder(
              itemCount: 30,
              itemBuilder: ( context, index ){
                return ListTile(
                  title: Text('Movimiento ${index + 1}'),
                  subtitle: Text(subT),
                );
              },
            ),
          ),
        ),
      ) ,
    );
  }
}