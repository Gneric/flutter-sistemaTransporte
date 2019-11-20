import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:sistema_transporte/src/models/movimientosTarjeta.dart';

class MovimientosProvider extends ChangeNotifier {
  List<MovimientosTarjeta> movimientos;

  void setMovimientos(List<MovimientosTarjeta> values){
    movimientos = values;
    notifyListeners();
  }

  List<MovimientosTarjeta> getMovimientos(){
    return movimientos;
  }

  Future<List<MovimientosTarjeta>> getListaMovimientos(String codigoTarjeta) async {
    HttpClient httpClient = new HttpClient();
    String url = "https://webapi-sit.azurewebsites.net/operacionesGet/operaciones/$codigoTarjeta";
    HttpClientRequest request = await httpClient.getUrl(Uri.parse(url));
      request.headers.set('content-type', 'application/json');
    HttpClientResponse response = await request.close();
    var jsonData;
    String reply = await response.transform(utf8.decoder).join();
    jsonData = json.decode(reply);

    final finalResponse = (jsonData as List ).map( (row) {
      return MovimientosTarjeta.fromJson(row);
    }).toList();

    //print("final Response Movimientos: $finalResponse");

    return finalResponse;
  }

}