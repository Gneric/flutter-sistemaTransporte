import 'dart:convert';
import 'dart:io';

import 'package:sistema_transporte/src/models/trarjetasTren.dart';
import 'package:sistema_transporte/src/models/user.dart';
import 'package:http/http.dart' as http;

class ApiCall {

  Future<User> getFileUser(String user, String password) async {
    Map data = {'user': user, 'password': password};
    final url = "http://192.168.0.16:8080/SIT-api/clientesPost/Login";
    final response = await http
    .post(url, headers: {HttpHeaders.contentTypeHeader: 'application/json'}, body: data );

    final decodedResponseBody = jsonDecode(response.body);
    if( response.statusCode > 400  &&  response.statusCode < 200 ){
      throw Exception('Error getting data list');
    }   
    print("Final Response $decodedResponseBody");

    final listTarjetas = getListTarjetas(decodedResponseBody['tarjetas']);

    return User.storeUser(decodedResponseBody, listTarjetas);
  }

  List<TarjetasTren> getListTarjetas(Map json) {
    List<TarjetasTren> lista;
    for (var i = 0; i < json.length; i++) {
      Map tarjetaMap = json[i];
      var tarjeta = TarjetasTren.fromJson(tarjetaMap);
      lista.add(tarjeta);
    }
    return lista;
  }

}