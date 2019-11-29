import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:sistema_transporte/src/models/station.dart';

class MetropolitanoStationProvider extends ChangeNotifier {

  List<Station> estaciones;

  void setStations(List<Station> values){
    estaciones = values;
    notifyListeners();
  }

  List<Station> getStations(){
    return estaciones;
  }

  Future<List<Station>> getListaEstacionesMetropolitano() async {
    HttpClient httpClient = new HttpClient();
    String url = "https://webapi-sit.azurewebsites.net/estacionesGet/estaciones/2";
    HttpClientRequest request = await httpClient.getUrl(Uri.parse(url));
      request.headers.set('content-type', 'application/json');
    HttpClientResponse response = await request.close();
    var jsonData;
    String reply = await response.transform(utf8.decoder).join();
    jsonData = json.decode(reply);

    final finalResponse = (jsonData as List ).map( (row) {
      return Station.fromJson(row);
    }).toList();

    //print("final Response Movimientos: $finalResponse");

    return finalResponse;
  }

}