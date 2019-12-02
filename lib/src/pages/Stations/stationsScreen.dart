import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sistema_transporte/src/pages/MainMenu/drawerScreen.dart';
import 'package:sistema_transporte/src/pages/Stations/stationSelector.dart';




class Estaciones extends StatefulWidget {
  final double lat;
  final double long;
  final String name;
  Estaciones({Key key, this.lat, this.long, this.name}) : super(key: key);

  @override
  _EstacionesState createState() => _EstacionesState();
}

class _EstacionesState extends State<Estaciones> {
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  Completer<GoogleMapController> _controller = Completer();
  List<Marker> markerList = [];

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(-12.066050, -77.036669),
    zoom: 12.0,
  ); 
  
  Marker currentLocationMarker = Marker(
    markerId: MarkerId('currmarker'),
    position: LatLng(-12.066050, -77.036669),
    infoWindow: InfoWindow(title: 'Usted esta aqui'),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed)
  );

  Marker selectedLocationMarker(double lat, double long, String name) {
    return Marker(
      markerId: MarkerId('selectedMarker'),
      position: LatLng(lat, long),
      infoWindow: InfoWindow(title: name),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed)
    );
  }

  Future<void> _goToLocation(double lat, double long) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      //bearing: 192.8334901395799,
      target: LatLng(lat, long),
      zoom: 16.151926040649414
    )));
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      //markerList.add(currentLocationMarker);
      //getLocation();
      print("LATITUD ${widget.lat}");
      print("LINGITUD ${widget.long}");
      if (widget.lat!=null) {
        markerList.add(selectedLocationMarker(widget.lat, widget.long, widget.name));
        _goToLocation(widget.lat, widget.long);
      }
    });
    

    return new Scaffold(
      key: _scaffoldKey,
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
        markers: Set.from(markerList),
      ),
    ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => {
            locationSheet(context)
        } ,
        label: Text('Estaciones'),
        icon: Icon(Icons.ev_station),
      ),
    );  
  } 
}

  

  

