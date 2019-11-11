import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:sistema_transporte/src/models/user.dart';

class UserProvider extends ChangeNotifier {
  User _usuario;
  User get usuario => _usuario;

  set setUsuario(User value){
    _usuario = value;
    notifyListeners();
  }

  Future<User> getFileUser(String user, String password) async {
      User usu;
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
      usu = User.fromJson(jsonData);
        setUsuario = usu; 
      
      return usu; 
  }

  Future<User> getUser() async {
    User usu;
    usu = usuario;
    return usu;
  }
  




  
}
