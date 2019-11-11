import 'dart:convert';
import 'dart:io';
import 'package:sistema_transporte/src/models/movimientosTarjeta.dart';

class MovimientosProvider {

  Future<List<MovimientosTarjeta>> getListaMovimientos( String codigoTarjeta ) async {
    HttpClient httpClient = new HttpClient();
    String url = "http://192.168.0.16:8080/SIT-api/operacionesGet/operaciones/$codigoTarjeta";
    HttpClientRequest request = await httpClient.getUrl(Uri.parse(url));
      request.headers.set('content-type', 'application/json');
    HttpClientResponse response = await request.close();
    var jsonData;
    String reply = await response.transform(utf8.decoder).join();
    jsonData = json.decode(reply);

    final finalResponse = (jsonData as List ).map( (row) {
      return MovimientosTarjeta.fromJson(row);
    }).toList();

    print("final Response: $finalResponse");

    return finalResponse;
  }

}