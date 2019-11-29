import 'package:flutter/material.dart';

class StationChargin extends StatefulWidget {
  StationChargin({Key key}) : super(key: key);

  @override
  _StationCharginState createState() => _StationCharginState();
}

class _StationCharginState extends State<StationChargin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(Center(child: LinearProgressIndicator(), ))
      ),
    );
  }
}
