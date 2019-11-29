import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sistema_transporte/src/models/station.dart';
import 'package:sistema_transporte/src/provider/metropolitanoStationProvider.dart';
import 'package:sistema_transporte/src/provider/trenStationProvider.dart';

chooseStation( BuildContext context, List<Station> estacionesTren, List<Station> estacionesMetro, List<Station> estacionesCorredor ) {
  final GlobalKey trenKey = new GlobalKey();
  final GlobalKey metroKey = new GlobalKey();
  final GlobalKey corredorKey = new GlobalKey();
  bool _isLoadingTren = true;
  bool _isLoadingMetro = true;
  bool _isLoadingCorredor = true;
  List<Station> lstTrenStation;
  List<Station> lstMetroStation;
  List<Station> lstCorredorStation;


  getEstacionesTren() async {
    try {
      print("Entro a getEstacionesTren()");
      _isLoadingTren = true;
      var providerStation = Provider.of<TrenStationProvider>(context, listen: false);
      var estaciones = await providerStation.getListaEstacionesTren();
      lstTrenStation = estaciones;
      _isLoadingTren = false;
    } catch (e) {
      print("Error: " + e.toString());
      return null;
    }
  }

  getEstacionesMetro() async {
    try {
      print("Entro a getEstacionesMetro()");
      _isLoadingMetro = true;
      var providerStation = Provider.of<MetropolitanoStationProvider>(context, listen: false);
      var estaciones = await providerStation.getListaEstacionesMetropolitano();
      lstMetroStation = estaciones;
      _isLoadingMetro = false;
    } catch (e) {
      print("Error: " + e.toString());
      return null;
    }
  }

  getEstacionesCorredor() async {
    try {
      print("Entro a getEstacionesCorredor()");
      _isLoadingCorredor = true;
      var providerStation = Provider.of<TrenStationProvider>(context, listen: false);
      var estaciones = await providerStation.getListaEstacionesTren();
      lstCorredorStation = estaciones;
      _isLoadingCorredor = false;

    } catch (e) {
      print("Error: " + e.toString());
      return null;
    }
  }


  showModalBottomSheet(
      context: context,
      builder: (context) {
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
                            getEstacionesTren()
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
                                          print("ESTACION: ${index}");
                                          print("LATITUD : ${index}");
                                          print("LONGITUD: ${index}");
                                        },
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[ Icon(Icons.directions_bus), Text("Estacion $index") ],
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
                            getEstacionesMetro()
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
                                          print("ESTACION: $index");
                                          print("LATITUD : $index");
                                          print("LONGITUD: $index");
                                        },
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[ Icon(Icons.directions_bus), Text("Estacion $index") ],
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
                            getEstacionesCorredor()
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
                                          print("ESTACION: $index");
                                          print("LATITUD : $index");
                                          print("LONGITUD: $index");
                                        },
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[ Icon(Icons.directions_bus), Text("Estacion $index") ],
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
      }
  );
}
