import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sistema_transporte/src/models/station.dart';
import 'package:sistema_transporte/src/pages/MainMenu/drawerScreen.dart';
import 'package:sistema_transporte/src/pages/Stations/stationChooser.dart';




class Estaciones extends StatefulWidget {
  Estaciones({Key key, double lat, double long}) : super(key: key);

  @override
  _EstacionesState createState() => _EstacionesState();
}

class _EstacionesState extends State<Estaciones> {
  List<Station> estacionesTren;
  List<Station> estacionesMetro;
  List<Station> estacionesCorredor;
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(-12.066050, -77.036669),
    zoom: 12.0,
  );



  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      drawer: NavigationDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.blue[400],
        title: Text("Estaciones"),
        centerTitle: true,
      ),
      body: SafeArea(
          child: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: _kGooglePlex,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showStationsModal,
        label: Text('Estaciones'),
        icon: Icon(Icons.ev_station),
      ),
    );
  }

  _showStationsModal() {
    chooseStation(context, estacionesTren, estacionesMetro, estacionesCorredor);
  }
}