import 'package:flutter/material.dart';
import 'package:sistema_transporte/src/models/station.dart';

class StationChargin extends StatefulWidget {
  StationChargin({Key key}) : super(key: key);

  @override
  _StationCharginState createState() => _StationCharginState();
}

class _StationCharginState extends State<StationChargin> {

  List<Station> lstTrenStation;
  List<Station> lstMetroStation;
  List<Station> lstCorredorStation;



  @override
  Widget build(BuildContext context) {

    setState(() {
      
    });

    return Scaffold(
      body: SafeArea(
        child: Container( child: Center(child: LinearProgressIndicator() ))
      ),
    );
  }
}
