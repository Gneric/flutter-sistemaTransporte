
import 'dart:io';
import 'dart:convert';

import 'package:sistema_transporte/src/models/user.dart';

class RegisterProvider {

  Future<User> registrarUser(String nombre, String apellidoP, String apellidoM, String dni, String telefono, String email, String usuario, String contrasena ) async {
    try{
        User usu;
        DateTime now = new DateTime.now();
        DateTime dateUTC = new DateTime(now.year, now.month, now.day).toUtc();
        String fecha = dateUTC.year.toString() + "/" + dateUTC.month.toString() + "/" + dateUTC.day.toString();
    
        Map userRegMap = {
          "usu_CLIENTE": usuario,
          "pass_CLIENTE": contrasena,
          "nom_CLIENTE": nombre,
          "apep_CLIENTE": apellidoP,
          "apem_CLIENTE": apellidoM,
          "dni_CLIENTE": dni,
          "telef_CLIENTE": telefono,
          "mail_CLIENTE": email,
          "fech_REGISTRO_CLIENTE": fecha,
          "estado": 0
        };

        String url = 'https://webapi-sit.azurewebsites.net/clientesPost/registro';

        HttpClient httpClient = new HttpClient();
        HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
              request.headers.set('content-type', 'application/json');
              //request.headers.add(HttpHeaders.contentTypeHeader, 'application/json'); 
              request.add(utf8.encode(json.encode(userRegMap)));    

          HttpClientResponse response = await request.close();
          var jsonData; 
          String reply = await response.transform(utf8.decoder).join();
          jsonData = json.decode(reply);
          print("jsonData registrarUser: $jsonData");
          usu = User.fromJson(jsonData);
          return usu;
    } catch(e){
          print("Error gil $e");
          return null;
    }

     
  }

}