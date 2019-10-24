import 'package:flutter/material.dart';
import 'package:sistema_transporte/src/utils/bottom_modal.dart';

Widget movement(double saldo, String date, String hour, String mensaje, context) {
  
    String tipo = saldo < 0 ? "negativo":"positivo" ;
    
    final _soles = <String, String>{
      "positivo": 'S/ '+saldo.toString()+'0',
      "negativo": 'S/ '+(saldo).toString().replaceFirst('-', '- ') +'0',
    };

    final _icons = <String, IconData>{
      "positivo": Icons.arrow_drop_up,
      "negativo": Icons.arrow_drop_down
    };

    final _colors = <String, Color>{
      "positivo": Colors.green,
      "negativo": Colors.red,
    };

    final _backgroundColors = <String, Color>{
      "positivo": Colors.green[50],
      "negativo": Colors.red[50],
    };

    return Card(
      elevation: 0.5,
      color: _backgroundColors[tipo],
      child: ListTile(
        onTap: () {
          searchMovement(saldo, date, hour, mensaje, context);
        },
        title: Text(mensaje),
        subtitle: Text(date),
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(_soles[tipo], style: TextStyle(color: _colors[tipo])),
            Icon(
              _icons[tipo],
              color: _colors[tipo],
              size: 25,
            ),
          ],
        ),
      ),
    );
  }