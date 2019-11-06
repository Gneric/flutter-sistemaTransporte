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
      List<TarjetasTren> get tarjetasTren => _tarjetas;
    
    List<MovimientosTarjeta> _movimientos;
      List<MovimientosTarjeta> get movimientos => _movimientos;

    User(){}

    void printUser(){
      print("nombre "+_nombre);
      print("apep "+_apep);
      print("apm "+_apem);
      print("dni "+_dni);
      print("telef "+_telefono);
      print("mail "+_mail);
      print("usu "+_usuario);
    }

    void storeUser(Map<String, dynamic> json){
      _nombre = json['nom_CLIENTE'];
      _apep = json['apep_CLIENTE'];
      _apem = json['apem_CLIENTE'];
      _dni = json['dni_CLIENTE'];
      _telefono = json['telef_CLIENTE'];
      _mail = json['mail_CLIENTE'];
      _usuario = json['usu_CLIENTE'];
      _tarjetas = json['tarjetas'];
      notifyListeners();
    }

  /*
    void addMovimientos(Map<String, dynamic> movimientos){
      for( MovimientosTarjeta mov in movimientos ){
        _movimientos.add(mov);
      }
    }
  */

}