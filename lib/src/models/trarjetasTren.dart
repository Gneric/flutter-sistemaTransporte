class TarjetasTren {
  String codigoTarjeta;
    String get getCodigoTarjeta => codigoTarjeta;
  String perfilTarjeta;
    String get getPerfilTarjeta => perfilTarjeta;
  String fechaEmision;
    String get getFechaEmision => fechaEmision;
  String fechaCaducidad;
   String get getFechaCaducidad => fechaCaducidad;
  double saldoTarjeta;
   String get getSaldoTarjeta => saldoTarjeta.toString();
  String estadoTarjeta;
   String get getEstadoTarjeta => estadoTarjeta;
  String usuarioTarjeta;
   String get getUsuarioTarjeta => usuarioTarjeta;

  TarjetasTren.fromJson(Map<String, dynamic> parsedJson){
      this.codigoTarjeta = parsedJson['cod_TARJETA'];
      this.perfilTarjeta = parsedJson['desc_TIPO_TARJETA'];
      this.fechaEmision = parsedJson['fec_EMISION'];
      this.fechaCaducidad = parsedJson['fec_CADUCIDAD'];
      this.saldoTarjeta = parsedJson['saldo_TARJETA'];
      this.estadoTarjeta = parsedJson['estado_TARJETA'];
      this.usuarioTarjeta = parsedJson['usu_CLIENTE'];
  }

}
