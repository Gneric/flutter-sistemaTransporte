import 'package:flutter/material.dart';
import 'package:sistema_transporte/src/models/trarjetasTren.dart';

class User extends ChangeNotifier {

  String _nombre;
    String get getNombre => _nombre;
  String _apep;
    String get getApellidoP => _apep;
  String _apem;
    String get getAppelidoM => _apem;
  String _dni;
    String get getDNI => _dni;
  String _telefono;
    String get getTelefono => _telefono;
  String _mail;
    String get getMail => _mail;
  String _usuario;
    String get getUsuario => _usuario;
  List<TarjetasTren> _tarjetas;
    List<TarjetasTren> get getTarjetas => _tarjetas;
  
  User(){}

  User.fromJson(Map<String, dynamic> parsedJson) {
    _nombre = parsedJson['nom_CLIENTE'];
    _apep = parsedJson['apep_CLIENTE'];
    _apem = parsedJson['apem_CLIENTE'];
    _dni = parsedJson['dni_CLIENTE'];
    _mail = parsedJson['mail_CLIENTE'];
    _telefono = parsedJson['telef_CLIENTE'];
    _usuario = parsedJson['usu_CLIENTE'];
    _tarjetas = _toObjectList(parsedJson['tarjetas'], (e) => TarjetasTren.fromJson(e));
    print("Notificar Listeners");
    notifyListeners();
  }

  List<T> _toObjectList<T>(data, T Function(Map<String, dynamic>) fromJson) {
    if (data == null) {
      return null;
    }
    var result = <T>[];
    for (var element in data) {
      T value;
      if (element != null) {
        value = fromJson(element as Map<String, dynamic>);
      }
      result.add(value);
    }
    return result;
  }

}
