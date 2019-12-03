import 'dart:convert';
import 'dart:io';

class NuevaTarjetaProvider {

 Future<int> agregarTarjeta( String codigoCliente, String codigoTarjeta ) async {
    try{
      print("CodigoCliente: $codigoCliente");
      print("CodigoTarjeta: $codigoTarjeta");

      Map mapData = {
        "usu_CLIENTE" : codigoCliente,
        "cod_TARJETA" : codigoTarjeta
      };
      String url = "https://webapi-sit.azurewebsites.net/tarjetasPost/vincularTarjeta";

      HttpClient httpClient = new HttpClient();
      HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
            request.headers.set('content-type', 'application/json'); 
            request.add(utf8.encode(json.encode(mapData)));    
        HttpClientResponse response = await request.close();
        var jsonData; 
        String reply = await response.transform(utf8.decoder).join();
        jsonData = json.decode(reply);
        print("Done agregarTarjeta: $jsonData");
        return jsonData;
    }
    on Exception catch(e) {
      print("Error agregar Tarjeta: ${e.toString()}");
      return 0;
    }
    
  }


}