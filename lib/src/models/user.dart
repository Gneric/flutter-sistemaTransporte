import 'package:sistema_transporte/src/models/trarjetasTren.dart';

class User {

  String _nombre;
    String get getNombre => _nombre;
  String _apep;
    String get getApep => _apep;
  String _apem;
   String get getApem => _apem;
  String _dni;
   String get getDNI => _dni;
  String _telefono;
   String get getTelefono => _telefono;
  String _mail;
   String get getMail => _mail;
  String _usuario;
   String get getUsername => _usuario;
  String _password;
    String get getPassword => _password;
  List<TarjetasTren> _tarjetas;
   List<TarjetasTren> get getTarjetas => _tarjetas;
  TarjetasTren _currentTarjeta;
    TarjetasTren get getCurrentTarjeta => _currentTarjeta;

  User();

  void deleteTarjeta(int index){
    _tarjetas.removeAt(index);
  }

  void setUser(String nombre, String apep, String apem, String dni, String mail,
      String telefono, String usuario, List<TarjetasTren> tarjetas) {
    _nombre = nombre;
    _apep = apep;
    _apem = apem;
    _dni = dni;
    _mail = mail;
    _telefono = telefono;
    _usuario = usuario;
    _tarjetas = tarjetas;
  }

  User.fromJson(Map<String, dynamic> parsedJson) {
    _nombre = parsedJson['nom_CLIENTE'];
    _apep = parsedJson['apep_CLIENTE'];
    _apem = parsedJson['apem_CLIENTE'];
    _dni = parsedJson['dni_CLIENTE'];
    _mail = parsedJson['mail_CLIENTE'];
    _telefono = parsedJson['telef_CLIENTE'];
    _usuario = parsedJson['usu_CLIENTE'];
    _password = parsedJson['pass_CLIENTE'];
    _tarjetas = parsedJson['tarjetas'].length < 1 ? [] : _toObjectList(parsedJson['tarjetas'], (e) => TarjetasTren.fromJson(e));
    _currentTarjeta = parsedJson['tarjetas'].length < 1 ? new TarjetasTren() : _toObjectList(parsedJson['tarjetas'], (e) => TarjetasTren.fromJson(e))[0];
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
