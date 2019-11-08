import 'dart:convert';
import 'dart:io';
import 'package:sistema_transporte/src/models/movimientosTarjeta.dart';
import 'package:sistema_transporte/src/models/user.dart';

class ApiCall {

  Future<User> getFileUser(String user, String password) async {
    
      //print("Mapeando data de User [ user: $user and password: $password ]");
      Map data = {"user": user, "password": password};
      //print(data);
      String url = 'http://192.168.0.16:8080/SIT-api/clientesPost/Login';
      HttpClient httpClient = new HttpClient();
      //print("Entrando a HttpClientRequest con el url: $url");
      HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
          request.headers.set('content-type', 'application/json');
          //request.headers.add(HttpHeaders.contentTypeHeader, 'application/json'); 
          request.add(utf8.encode(json.encode(data)));     
      HttpClientResponse response = await request.close();
      var jsonData; 
      String reply = await response.transform(utf8.decoder).join();
      jsonData = json.decode(reply);
      //print("Reply $reply");
      //print("response status code: ${response.statusCode.toString()}");

    
      return User.fromJson(jsonData);     
  }

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
