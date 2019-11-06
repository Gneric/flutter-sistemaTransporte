import 'dart:ffi';

import 'package:sistema_transporte/src/models/movimientosTarjeta.dart';

class TarjetasTren {

  String _codigoTarjeta;
      String get codigo => _codigoTarjeta;

  String _perfil;
      String get perfil => _perfil;

  DateTime _emision;
      DateTime get emision => _emision;

  DateTime _caducidad;
    DateTime get caducidad => _caducidad;

  Double _saldo;
    Double get saldo => _saldo;

  String _estado;
    String get estado => _estado;

}