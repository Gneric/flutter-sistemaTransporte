import 'package:flutter/material.dart';
import 'package:sistema_transporte/src/models/station.dart';

chooseStation(BuildContext context, List<Station> estacionesTren, List<Station> estacionesMetro, List<Station> estacionesCorredor ) {

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
                        leading: Container( height: 40, width: 40, decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.black) , child: Icon(Icons.train, color: Colors.green[400] )),
                        backgroundColor: Colors.green[50],
                        children: <Widget>[
                            Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height / 3,
                            child: GridView.count(
                              shrinkWrap: true,
                              physics: ClampingScrollPhysics(),
                              crossAxisCount: 4,
                              children: List.generate(12, (index) {
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
                        leading: Container( height: 40, width: 40,  decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.black) , child: Icon(Icons.directions_bus, color: Colors.yellow[400] )),
                        backgroundColor: Colors.yellow[50],
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height / 3,
                            child: GridView.count(
                              shrinkWrap: true,
                              physics: ClampingScrollPhysics(),
                              crossAxisCount: 4,
                              children: List.generate(12, (index) {
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
                        backgroundColor: Colors.blue[50],
                        children: <Widget>[
                            Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height / 3,
                            child: GridView.count(
                              shrinkWrap: true,
                              physics: ClampingScrollPhysics(),
                              crossAxisCount: 4,
                              children: List.generate(12, (index) {
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
