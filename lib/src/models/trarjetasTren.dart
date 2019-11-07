
class TarjetasTren {

  String _codigoTarjeta;
    String get codigoTarjeta => _codigoTarjeta;
  String _perfilTarjeta;
    String get perfilTarjeta => _perfilTarjeta;
  String _fechaEmision;
    String get fechaEmision => _fechaEmision;
  String _fechaCaducidad;
    String get fechaCaducidad => _fechaCaducidad;
  double _saldoTarjeta;
    double get saldoTarjeta => _saldoTarjeta;
  String _estadoTarjeta;
    String get estadoTarjeta => _estadoTarjeta;
  String _usuarioTarjeta;
    String get usuarioTarjeta => _usuarioTarjeta;

  TarjetasTren(){}

  TarjetasTren.fromJson( Map<String, dynamic> json ){
      _codigoTarjeta = json['cod_TARJETA'];
      _perfilTarjeta = json['perfil_TARJETA'];
      _fechaEmision =  json['fec_EMISION'];
      _fechaCaducidad =  json['fec_CADUCIDAD'];
      _saldoTarjeta =  json['saldo_TARJETA'];
      _estadoTarjeta = json['estado_TARJETA'];
      _usuarioTarjeta = json['usu_CLIENTE'];
  }
  /*
  void fromJson(Map<String, dynamic> json){
      _codigoTarjeta = "100000000";//json['cod_TARJETA'];
      _perfilTarjeta = "Activo"; //json['perfil_TARJETA'];
      _fechaEmision =  DateTime.now(); //json['fec_EMISION'];
      _fechaCaducidad =  DateTime.now();//json['fec_CADUCIDAD'];
      _saldoTarjeta = 1.0;//json['saldo_TARJETA'];
      _estadoTarjeta = "Activo"; //json['ESTADO_TARJETA'];
  }*/

}