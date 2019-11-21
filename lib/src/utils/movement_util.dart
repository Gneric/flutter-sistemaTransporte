import 'package:flutter/material.dart';
import 'package:sistema_transporte/src/models/movimientosTarjeta.dart';
import 'package:sistema_transporte/src/utils/bottom_modal.dart';

Widget movement(MovimientosTarjeta movimiento, context) {

    String tipo = movimiento.getImporte==0 ? "venta" : movimiento.getImporte < 0 ? "negativo":"positivo" ;
    
    final _soles = <String, String>{
      "venta": '',
      "positivo": 'S/ '+ movimiento.getImporte.toString()+'0',
      "negativo": 'S/ '+ (movimiento.getImporte).toString().replaceFirst('-', '- ') +'0',
    };

    final _icons = <String, IconData>{
      "venta": Icons.star,
      "positivo": Icons.arrow_drop_up,
      "negativo": Icons.arrow_drop_down
    };

    final _colors = <String, Color>{
      "venta": Colors.yellow,
      "positivo": Colors.green,
      "negativo": Colors.red,
    };

    final _backgroundColors = <String, Color>{
      "venta": Colors.yellow[100],
      "positivo": Colors.green[50],
      "negativo": Colors.red[50],
    };

    String titulo = movimiento.getTipoOperacion=="Venta" ? "Bienvenido" : movimiento.getTipoOperacion;

    return Card(
      elevation: 0.5,
      color: movimiento.getCodigoEquipo==null ? Colors.grey[100] : _backgroundColors[tipo],
      child: ListTile(
        onTap: () {
          searchMovement(movimiento, context);
        },
        title: Text("$titulo"),
        subtitle: Text("${movimiento.fechaMovimiento.replaceAll('-', '/')}"),
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