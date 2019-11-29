import 'package:flutter/material.dart';

chooseStation(context) {

  showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(0),
          child: Container(
            color: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10))),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0) ,
                child: SingleChildScrollView(
                    child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      /* TREN ELECTRICO */
                      Container(
                          height: 40,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.green[100]
                          ),
                          child: Center(child: Text("Tren Electrico", textAlign: TextAlign.center, style: TextStyle( fontSize: 16, fontWeight: FontWeight.bold ), ))
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 3,
                        child: GridView.count(
                          crossAxisCount: 4,
                          children: List.generate(12, (index) {
                            return Padding(padding: const EdgeInsets.all(5.0),
                              child: ClipOval(child: Material(color: Colors.green[100],child: InkWell(splashColor: Colors.green[400],
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
                      Container(
                          height: 40,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.green[100]
                          ),
                          child: Center(child: Text("Metropolitano", textAlign: TextAlign.center, style: TextStyle( fontSize: 16, fontWeight: FontWeight.bold ), ))
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 3,
                        child: GridView.count(
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
                    ],
                  ),
                ),
              ),
            ),
          )
        );
      }
  );
}
