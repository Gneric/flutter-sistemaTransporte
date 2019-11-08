class TarjetasTren {
  String codigoTarjeta;
  String perfilTarjeta;
  String fechaEmision;
  String fechaCaducidad;
  double saldoTarjeta;
  String estadoTarjeta;
  String usuarioTarjeta;

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
