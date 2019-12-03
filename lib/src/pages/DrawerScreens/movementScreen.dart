import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sistema_transporte/src/models/movimientosTarjeta.dart';
import 'package:sistema_transporte/src/pages/MainMenu/drawerScreen.dart';
import 'package:sistema_transporte/src/pages/Utils/movement_util.dart';
import 'package:sistema_transporte/src/provider/movimientosProvider.dart';


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
        title: Text("Movimientos"),
        centerTitle: true,
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
                itemCount: movimientos == null ? 1 : movimientos.length,
                itemBuilder: (BuildContext context, int index){
                  return movimientos[index] == null ? Container() : movement(movimientos[index], context);
                }),
              ),
            ),
          ),
        ),
      );
  }
}
