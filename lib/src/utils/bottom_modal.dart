import 'package:flutter/material.dart';
import 'package:sistema_transporte/src/models/movimientosTarjeta.dart';

void searchMovement(MovimientosTarjeta movimiento, context) {
  String tipo = movimiento.getImporte == 0 ? "venta" : movimiento.getImporte < 0 ? "negativo" : "positivo";

  final _backgroundColors = <String, Color>{
    "venta" : Colors.yellow[100],
    "positivo": Colors.green[50],
    "negativo": Colors.red[50],
  };

  final _soles = <String, String>{
    "venta": '',
    "positivo": 'S/ ' + movimiento.getImporte.toString() + '0',
    "negativo": 'S/ ' + (movimiento.getImporte).toString().replaceFirst('-', '- ') + '0',
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

  final _mensaje = <String, String>{
    "venta": 'Bienvenido',
    "negativo": movimiento.getTipoOperacion,
    "positivo" : movimiento.getTipoOperacion
  };

  String _medioPago = movimiento.medioPago != null ? "XXXX - XXXX - XXXX - ${movimiento.medioPago}" : "Medio Pago no registrado";
  String _estacionParadero = movimiento.getNombreParadero != null ? movimiento.getNombreParadero : movimiento.getNombreEstacion != null ? movimiento.getNombreEstacion : "Recarga Virtual";
  String _fechaMovimiento = movimiento.getFechaMovimiento != null ? movimiento.getFechaMovimiento.replaceAll('-', '/') : "Fecha no registrada";
  String _horaMovimiento = movimiento.getHoraMovimiento ==null ? "Hora no registrada" : 
   int.parse(movimiento.getHoraMovimiento.substring(0,5).split(':')[0]) > 12 ? 
      "0${(int.parse(movimiento.getHoraMovimiento.substring(0,5).split(':')[0])-12).toString()}:${movimiento.getHoraMovimiento.substring(0,5).split(':')[1]} PM." :
      "${(movimiento.getHoraMovimiento.substring(0,5).split(':')[0]).toString()}:${movimiento.getHoraMovimiento.substring(0,5).split(':')[1]} AM.";

  showModalBottomSheet(
    context: context,
    builder: (context) {
      return Padding(padding: const EdgeInsets.all(0),
        child: Container(color: Colors.transparent,
          child: Container(
          decoration: BoxDecoration(
            color: movimiento.getCodigoEquipo==null ? Colors.grey[100] : _backgroundColors[tipo],
            borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))
          ),
          child: Column(
            children: <Widget>[
              Padding(padding: EdgeInsets.all(10),
                child: Container(
                  decoration: BoxDecoration(color: Colors.grey,borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Divider(color: Colors.grey),
                  height: 5,
                  width: 20,
                )),
              Padding(
                padding: EdgeInsets.all(20),
                child: SingleChildScrollView(scrollDirection: Axis.horizontal,
                  child: Row(
                    children: <Widget>[
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(_soles[tipo],style: TextStyle(color: _colors[tipo],fontWeight: FontWeight.bold,fontSize: 20)),
                          Icon(_icons[tipo],color: _colors[tipo],size: 30),
                          SizedBox(width: 10),
                          Text(_mensaje[tipo],style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Divider(),
              ListTile(title: Text('Estacion / Paradero',style:TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
                subtitle: Text(_estacionParadero),
              ),
              Divider(),
              ListTile(title: Text('Fecha',style:TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
                subtitle: Text(_fechaMovimiento),
              ),
              Divider(),
              ListTile(title: Text('Hora',style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
                subtitle: Text(_horaMovimiento),
              ),
              Divider(),
              ListTile(title: Text('Medio Pago',style:TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
                subtitle: Text(_medioPago),
              ),
            ],
          ),
        ),
        ),
      );
    });
}
