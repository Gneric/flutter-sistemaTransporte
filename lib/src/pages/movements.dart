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
    var date = fecha.year.toString() +
        '/' +
        fecha.month.toString() +
        '/' +
        fecha.day.toString();
    var hour = fecha.hour.toString() + ':' + fecha.minute.toString();

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
            padding: const EdgeInsets.all(10.0),
            child: Container(
              child: ListView.builder(
                itemCount: 30,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text('Movimiento ${index + 1}'),
                      subtitle: Text(date),
                      onTap: () => _searchMovement(10.0,'Movimiento ${index + 1}', date, hour),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _searchMovement(
      double saldo, String movimiento, String date, String hora) {
    String tipo = saldo < 0 ? "negativo" : "positivo";

    final _backgroundColors = <String, Color>{
      "positivo": Colors.green[50],
      "negativo": Colors.red[50],
    };

    final _soles = <String, String>{
      "positivo": 'S/ ' + saldo.toString() + '0',
      "negativo": 'S/ ' + (saldo).toString().replaceFirst('-', '- ') + '0',
    };

    final _icons = <String, IconData>{
      "positivo": Icons.arrow_drop_up,
      "negativo": Icons.arrow_drop_down
    };

    final _colors = <String, Color>{
      "positivo": Colors.green,
      "negativo": Colors.red,
    };

    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      child: Text(movimiento, style: TextStyle(fontWeight: FontWeight.bold ),),
                    ),
                  ),
                  ListTile(
                    title: Text('Date'),
                    subtitle: Text(date),
                  ),
                  ListTile(
                    title: Text('Hora'),
                    subtitle: Text(hora),
                  )
                ],
              ),
            ),
          );
        });
  }
}
