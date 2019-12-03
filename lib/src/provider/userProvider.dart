import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:sistema_transporte/src/models/user.dart';

class UserProvider extends ChangeNotifier {
  User usuario;


  User getUsuario(){
    return usuario;
  }

  void setUsuario(User value){
    usuario = value;
    notifyListeners();
  }

  void deleteTarjeta(int index){
    usuario.deleteTarjeta(index);
    notifyListeners();
  }

  Future<User> getFileUser(String user, String password) async {
    try{
      User usu;
      //print("Mapeando data de User [ user: $user and password: $password ]"); 
      Map data = {"user": user, "password": password};
      //print(data);
      String url = 'https://webapi-sit.azurewebsites.net/clientesPost/Login';
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
      
      return usu;

    } catch(e){
      print("Error getFileUser $e");
      return null;
    } 
       
  }
  
}
