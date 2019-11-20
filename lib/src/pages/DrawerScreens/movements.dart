import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sistema_transporte/src/models/movimientosTarjeta.dart';
import 'package:sistema_transporte/src/pages/MainMenu/drawer.dart';

import 'package:sistema_transporte/src/provider/movimientosProvider.dart';
import 'package:sistema_transporte/src/utils/movement_util.dart';


class Movimientos extends StatefulWidget {
  Movimientos({Key key}) : super(key: key);

  @override
  _MovimientosState createState() => _MovimientosState();
}

class _MovimientosState extends State<Movimientos> {
  @override
  Widget build(BuildContext context) {
    List<MovimientosTarjeta> movimientos;

    setState(() {
      movimientos = Provider.of<MovimientosProvider>(context).getMovimientos();
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[400],
      ),
      drawer: NavigationDrawer(),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              child: ListView.builder(
                itemCount: movimientos.length,
                itemBuilder: (BuildContext context, int index){
                  return movement(movimientos[index], context);
                }),
              ),
            ),
          ),
        ),
      );
  }
}
