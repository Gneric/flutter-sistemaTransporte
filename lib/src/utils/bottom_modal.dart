import 'package:flutter/material.dart';

Widget searchMovement(double saldo, String date, String hora, String mensaje, context) {
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
          padding: const EdgeInsets.all(0),
          child: Container(
              color: Colors.transparent,
              child: Container(
              decoration: BoxDecoration(
                  color: _backgroundColors[tipo],
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10))),
              child: Column(
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.all(10),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.all(Radius.circular(10))),
                        child: Divider(color: Colors.grey),
                        height: 5,
                        width: 20,
                      )),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: <Widget>[
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(_soles[tipo],
                                  style: TextStyle(
                                      color: _colors[tipo],
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20)),
                              Icon(
                                _icons[tipo],
                                color: _colors[tipo],
                                size: 30,
                              ),
                              SizedBox(width: 10),
                              Text(
                                mensaje,
                                style: TextStyle(
                                    fontSize: 20.0, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(),
                  ListTile(
                    title: Text(
                      'Fecha',
                      style:
                          TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(date),
                  ),
                  Divider(),
                  ListTile(
                    title: Text('Hora',
                        style: TextStyle(
                            fontSize: 15.0, fontWeight: FontWeight.bold)),
                    subtitle: Text(hora),
                  ),
                ],
              ),
            ),
          ),
        );
      });
}
