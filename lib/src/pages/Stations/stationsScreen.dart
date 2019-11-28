import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sistema_transporte/src/pages/MainMenu/drawerScreen.dart';




class Estaciones extends StatefulWidget {
  Estaciones({Key key}) : super(key: key);

  @override
  _EstacionesState createState() => _EstacionesState();
}

class _EstacionesState extends State<Estaciones> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(-12.2070403, -122.085749655962),
    zoom: 0.0,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

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
        onPressed: _showStations(),
        label: Text('Estaciones'),
        icon: Icon(Icons.ev_station),
      ),
    );
  }

  _showStations() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}