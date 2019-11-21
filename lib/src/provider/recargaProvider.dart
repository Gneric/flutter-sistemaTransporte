import 'dart:io';
import 'dart:convert';

class RecargaProvider {

  Future<int> registrarRecarga( String codigoTarjeta, String medioPago, double importe ) async {
    try{
      DateTime now = new DateTime.now();
      DateTime hoy = new DateTime(now.year, now.month, now.day);
      DateTime hora = new DateTime(0,0,0,now.hour, now.minute);
      print("Hoy: ${hoy.toString().substring(0,10).replaceAll('-', '/')}");
      print("Hora : ${hora.toString().substring(12, 17)}");
      print("Importe: $importe");
      print("CodigoTarjeta: $codigoTarjeta");

      Map mapData = {
        "cod_TARJETA" : codigoTarjeta,
        "fecha_OPERACION" : hoy.toString().substring(0,10).replaceAll('-', '/'),
        "hora_OPERACION" : hora.toString().substring(12, 17),
        "medio_PAGO_OPERACION" : medioPago,
        "importe" : importe
      };

      String url = "https://webapi-sit.azurewebsites.net/operacionesPost/realizarRecarga";

      HttpClient httpClient = new HttpClient();
      HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
            request.headers.set('content-type', 'application/json');
            //request.headers.add(HttpHeaders.contentTypeHeader, 'application/json'); 
            request.add(utf8.encode(json.encode(mapData)));    

        HttpClientResponse response = await request.close();
        var jsonData; 
        String reply = await response.transform(utf8.decoder).join();
        jsonData = json.decode(reply);
        print("Done registrarRecarga: $jsonData");
        return 1;
    }
    on Exception catch(e) {
      print("Error Registrar Tarjeta ${e.toString()}");
      return 0;
    }
    
  }


}