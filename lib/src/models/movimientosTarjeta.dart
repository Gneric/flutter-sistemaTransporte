class MovimientosTarjeta {
  
  int codigoOperacion;
  String codigoTarjeta;
  String fechaMovimiento;
  String horaMovimiento;
  String codigoEquipo;
  String codigoParadero;
  String nombreParadero;
  String nombreEstacion;
  String tipoOperacion;
  String fechaConfirmacion;
  String medioPago;
  double importe;
  int estado;

  MovimientosTarjeta.fromJson(Map<String, dynamic> parsedJson){
    this.codigoOperacion = parsedJson['cod_OPERACION'];
    this.codigoTarjeta = parsedJson['cod_TARJETA'];
    this.fechaMovimiento = parsedJson['fecha_OPERACION'];
    this.horaMovimiento = parsedJson['hora_OPERACION'];
    this.codigoEquipo = parsedJson['cod_EQUIPO'];
    this.codigoParadero = parsedJson['cod_PARADERO'];
    this.nombreParadero = parsedJson['nombre_PARADERO'];
    this.nombreEstacion= parsedJson['nom_ESTACION'];
    this.tipoOperacion = parsedJson['tipo_OPERACION'];
    this.fechaConfirmacion = parsedJson['fecha_HORA_CONFIRMACION'];
    this.medioPago = parsedJson['medio_PAGO_OPERACION'];
    this.importe = parsedJson['importe'];
    this.estado = parsedJson['estado'];
  }

}
