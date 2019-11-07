import 'package:flutter/material.dart';
import 'package:sistema_transporte/src/models/movimientosTarjeta.dart';
import 'package:sistema_transporte/src/models/trarjetasTren.dart';

class User extends ChangeNotifier {
  String _nombre;
  String get nombre => _nombre;

  String _apep;
  String get apep => _apep;

  String _apem;
  String get apem => _apem;

  String _dni;
  String get dni => _dni;

  String _telefono;
  String get telefono => _telefono;

  String _mail;
  String get mail => _mail;

  String _usuario;
  String get usuario => _usuario;

  List<TarjetasTren> _tarjetas;
  List<TarjetasTren> get tarjetas => _tarjetas;
  /*
  List<MovimientosTarjeta> _movimientos;
  List<MovimientosTarjeta> get movimientos => _movimientos;
  */
  User() {}

  void printUser() {
    print("nombre " + _nombre);
    print("apep " + _apep);
    print("apm " + _apem);
    print("dni " + _dni);
    print("telef " + _telefono);
    print("mail " + _mail);
    print("usu " + _usuario);
    print(_tarjetas);
  }

  User.storeUser( Map<String, dynamic> json, List<TarjetasTren> lista ) {
    _nombre = json['nom_CLIENTE'];
    _apep = json['apep_CLIENTE'];
    _apem = json['apem_CLIENTE'];
    _dni = json['dni_CLIENTE'];
    _telefono = json['telef_CLIENTE'];
    _mail = json['mail_CLIENTE'];
    _usuario = json['usu_CLIENTE'];
    _tarjetas = lista;
    notifyListeners();
  }



  /*
  void storeTarjetas( Map<String, dynamic> json ){
    _tarjetas.add(fromJsonToTarjeta(json));
  }*/
  /*
  TarjetasTren fromJsonToTarjeta(Map<String, dynamic> json){
    TarjetasTren tarjetas = TarjetasTren(json);
    return tarjetas;
  }*/

  /*
  void addMovimientos(Map<String, dynamic> json) {
    MovimientosTarjeta movimiento = new MovimientosTarjeta(
        json['cod_OPERACION'],
        json['cod_TARJETA'],
        json['fecha_OPERACION'],
        json['hora_OPERACION'],
        json['cod_EQUIPO'],
        json['cod_PARADERO'],
        json['nombre_PARADERO'],
        json['nom_ESTACION'],
        json['tipo_OPERACION'],
        json['fecha_HORA_CONFIRMACION'],
        json['medio_PAGO_OPERACION'],
        json['importe'],
        json['estado']);
    _movimientos.add(movimiento);
    notifyListeners();
  }*/
}
