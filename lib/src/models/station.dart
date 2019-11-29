class Station {

  String codigoEstacion;
    String get getCodigoEstacion => codigoEstacion;
  int codigoServicio;
    int get getCodigoServicio => codigoServicio;
  String codigoTipoEstacion;
    String get getCodigoTipoEstacion => codigoTipoEstacion;
  double latitud;
    double get getLatitud => latitud;
  double longitud;
    double get getLongitud => longitud;
  String nombreEstacion;
    String get getNombreEstacion => nombreEstacion;


  Station();

  
  Station.fromJson(Map<String, dynamic> parsedJson){
    this.codigoEstacion= parsedJson["cod_ESTACION"];
    this.codigoServicio = parsedJson["cod_SERV"];
    this.codigoTipoEstacion = parsedJson["cod_TIPO_ESTACION"];
    this.latitud = parsedJson["latitud"];
    this.longitud = parsedJson["longitud"];
    this.nombreEstacion = parsedJson["nom_ESTACION"];
  }

}
