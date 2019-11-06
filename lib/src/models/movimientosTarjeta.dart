import 'dart:ffi';

import 'package:flutter/foundation.dart';

class MovimientosTarjeta {

  int _codigoOperacion;
    int get codigoOperacion => _codigoOperacion; 
  
  String _codigoTarjeta;
    String get codigoTarjeta => _codigoTarjeta;

  String _fechaMovimiento;
    String get fechaMovimiento => _fechaMovimiento;

  String _horaMovimiento;
    String get horaMovimiento => _horaMovimiento;

  String _codigoEquipo;
    String get codigoEquipo => _codigoEquipo;

  String _codigoParadero;
    String get codigoParadero => _codigoParadero;

  String _nombreParadero;
    String get nombreParadero => _nombreParadero;

  String _nombreEstacion;
    String get nombreEstacion => _nombreEstacion;

  String _tipoOperacion;
    String get tipoOperacion => _tipoOperacion;

  DateTime _fechaConfirmacion;
    DateTime get fechaConfirmacion => _fechaConfirmacion;

  String _medioPago;
    String get medioPago => _medioPago;
  
  Double _importe;
    Double get importe => _importe;
  
  int _estado;
    int get estado => _estado;

  

}