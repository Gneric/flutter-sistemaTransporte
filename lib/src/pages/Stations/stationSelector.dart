import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sistema_transporte/src/models/station.dart';
import 'package:sistema_transporte/src/pages/Stations/stationsScreen.dart';
import 'package:sistema_transporte/src/provider/metropolitanoStationProvider.dart';
import 'package:sistema_transporte/src/provider/trenStationProvider.dart';


void locationSheet(context) {
    final GlobalKey trenKey = new GlobalKey();
    final GlobalKey metroKey = new GlobalKey();
    final GlobalKey corredorKey = new GlobalKey();
    bool _isLoadingTren = true;
    bool _isLoadingMetro = true;
    bool _isLoadingCorredor = true;
    List<Station> lstTrenStation;
    List<Station> lstMetroStation;
    List<Station> lstCorredorStation;

    Future<Null> updatedTrenState(StateSetter updateState) async {
      try {
        print("Entro a getEstacionesTren()");
        _isLoadingTren = true;
        var providerStation = Provider.of<TrenStationProvider>(context, listen: false);
        var estaciones = await providerStation.getListaEstacionesTren();
        updateState(() {
          lstTrenStation = estaciones;
          _isLoadingTren = false;
        });
      } catch(e){
        print("Error: " + e.toString());
        return null;
      }
    }

    Future<Null> updatedMetropolitanoState(StateSetter updateState) async {
      try {
        print("Entro a getEstacionesMetro()");
        _isLoadingMetro = true;
        var providerStation = Provider.of<MetropolitanoStationProvider>(context, listen: false);
        var estaciones = await providerStation.getListaEstacionesMetropolitano();
        updateState(() {
          lstMetroStation = estaciones;
          _isLoadingMetro = false;
        });
      } catch(e){
        print("Error: " + e.toString());
        return null;
      }
    }

    Future<Null> updatedCorredorState(StateSetter updateState) async {
      try {
        print("Entro a getEstacionesCorredor()");
          _isLoadingCorredor = true;
          var providerStation = Provider.of<TrenStationProvider>(context, listen: false);
          var estaciones = await providerStation.getListaEstacionesTren();
        updateState(() {
          lstCorredorStation = estaciones;
          _isLoadingCorredor = false;
        });
      } catch(e){
        print("Error: " + e.toString());
        return null;
      }
    }


    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, state){
            return Padding(
              padding: const EdgeInsets.all(0),
              child: SafeArea(
                  child: Container(
                  color: Colors.transparent,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0) ,
                      child: SingleChildScrollView(
                          child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            /***************** Tren Electrico *****************/                       
                            ExpansionTile(title: Text("Tren Electrico", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold ) ),
                            key: trenKey,
                            onExpansionChanged: ( (bool ask) => { 
                              if(ask){
                                updatedTrenState(state)
                              }
                            }),
                            leading: Container( height: 40, width: 40, decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.black) , child: Icon(Icons.train, color: Colors.green[400] )),
                            backgroundColor: Colors.green[50],
                            children: <Widget>[
                                _isLoadingTren ? Container( child: Center(child: LinearProgressIndicator())) :
                                Container(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height / 3,
                                child: GridView.count(
                                  shrinkWrap: true,
                                  physics: ClampingScrollPhysics(),
                                  crossAxisCount: 4,
                                  children: List.generate(_isLoadingTren ? 0 : lstTrenStation.length, (index) {
                                    return Padding(padding: const EdgeInsets.all(5.0),
                                      child: ClipOval(child: Material(color: Colors.green[100],child: InkWell(splashColor: Colors.green[400],
                                            onTap: (){
                                              print("ESTACION: ${lstTrenStation[index].getNombreEstacion}");
                                              print("LATITUD : ${lstTrenStation[index].getLatitud}");
                                              print("LONGITUD: ${lstTrenStation[index].getLongitud}");
                                              Navigator.pop(context);
                                              Navigator.pushReplacement(context, 
                                                MaterialPageRoute(
                                                  builder: (_) => Estaciones(lat: lstTrenStation[index].getLatitud, long: lstTrenStation[index].getLongitud, name: lstTrenStation[index].getNombreEstacion)
                                                )  
                                              );        
                                            },
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: <Widget>[ 
                                                Icon(Icons.train), 
                                                Padding(
                                                  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                                  child: Center(child: AutoSizeText("Estacion ${lstTrenStation[index].getNombreEstacion}", textAlign: TextAlign.center)),
                                                ) 
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              ),
                            ]),
                            Divider(),
                            /*************** Metropolitano ************/
                            ExpansionTile(title: Text("Metropolitano", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold )),
                            key: metroKey,
                            onExpansionChanged: ( (bool ask) => { 
                              if(ask){
                                updatedMetropolitanoState(state)
                              }
                            }),
                            leading: Container( height: 40, width: 40,  decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.black) , child: Icon(Icons.directions_bus, color: Colors.yellow[400] )),
                            backgroundColor: Colors.yellow[50],
                            children: <Widget>[
                              _isLoadingMetro ? Container( child: Center(child: LinearProgressIndicator()))
                              : Container(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height / 3,
                                child: GridView.count(
                                  shrinkWrap: true,
                                  physics: ClampingScrollPhysics(),
                                  crossAxisCount: 4,
                                  children: List.generate(_isLoadingMetro ? 0 : lstMetroStation.length, (index) {
                                    return Padding(padding: const EdgeInsets.all(5.0),
                                      child: ClipOval(child: Material(color: Colors.yellow[100],child: InkWell(splashColor: Colors.yellow[400],
                                            onTap: (){
                                              print("ESTACION: ${lstMetroStation[index].getNombreEstacion}");
                                              print("LATITUD : ${lstMetroStation[index].getLatitud}");
                                              print("LONGITUD: ${lstMetroStation[index].getLongitud}");
                                              MaterialPageRoute(
                                                  builder: (_) => Estaciones(lat: lstMetroStation[index].getLatitud, long: lstMetroStation[index].getLongitud, name: lstMetroStation[index].getNombreEstacion)
                                              );
                                            },
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: <Widget>[ 
                                                Icon(Icons.directions_bus), 
                                                Padding(
                                                  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                                  child: Center(child: AutoSizeText("Estacion ${lstMetroStation[index].getNombreEstacion}", textAlign: TextAlign.center)),
                                                ) ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              ),
                            ]),
                            Divider(),
                            /**************************************/
                            ExpansionTile(title: Text("Corredor", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold )),
                            leading: Container( height: 40, width: 40,  decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.black) , child: Icon(Icons.directions_bus, color: Colors.blue[400] )),
                            key: corredorKey,
                            onExpansionChanged: ( (bool ask) => { 
                              if(ask){
                                updatedCorredorState(state)
                              }
                            }),
                            backgroundColor: Colors.blue[50],
                            children: <Widget>[
                                _isLoadingCorredor ? Container( child: Center(child: LinearProgressIndicator()))
                                : Container(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height / 3,
                                child: GridView.count(
                                  shrinkWrap: true,
                                  physics: ClampingScrollPhysics(),
                                  crossAxisCount: 4,
                                  children: List.generate(_isLoadingCorredor ? 0 : lstCorredorStation.length, (index) {
                                    return Padding(padding: const EdgeInsets.all(5.0),
                                      child: ClipOval(child: Material(color: Colors.blue[100],child: InkWell(splashColor: Colors.blue[400],
                                            onTap: (){
                                              print("ESTACION: ${lstCorredorStation[index].getNombreEstacion}");
                                              print("LATITUD : ${lstCorredorStation[index].getLatitud}");
                                              print("LONGITUD: ${lstCorredorStation[index].getLongitud}");
                                              MaterialPageRoute(
                                                  builder: (_) => Estaciones(lat: lstCorredorStation[index].getLatitud, long: lstCorredorStation[index].getLongitud, name: lstCorredorStation[index].getNombreEstacion)
                                              );
                                            },
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: <Widget>[ 
                                                Icon(Icons.directions_bus), 
                                                Padding(
                                                  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                                  child: Center(child: AutoSizeText("Estacion ${lstCorredorStation[index].getNombreEstacion}", textAlign: TextAlign.center)),
                                                ) 
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              ),
                            ]),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )
            );
          });
        });
}

  