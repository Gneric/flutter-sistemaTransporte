class MovimientosTarjeta {
  
  int codigoOperacion;
    String get getCodigoOperacion => codigoOperacion.toString(); 
  String codigoTarjeta;
    String get getCodigoTarjeta => codigoTarjeta;
  String fechaMovimiento;
    String get getFechaMovimiento  => fechaMovimiento;
  String horaMovimiento;
    String get getHoraMovimiento => horaMovimiento;
  String codigoEquipo;
    String get getCodigoEquipo => codigoEquipo;
  String codigoParadero;
    String get getCodigoParadero => codigoParadero;
  String nombreParadero;
    String get getNombreParadero => nombreParadero;
  String nombreEstacion;
    String get getNombreEstacion => nombreEstacion;
  String tipoOperacion;
    String get getTipoOperacion => tipoOperacion;
  String fechaConfirmacion;
    String get getFechaConfirmacion => fechaConfirmacion;
  String medioPago;
    String get getMedioPago => medioPago;
  double importe;
    double get getImporte => importe;
  int estado;
    String get getEstado => estado.toString();

  MovimientosTarjeta();

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
