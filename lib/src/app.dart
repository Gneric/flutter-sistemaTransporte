import 'package:flutter/material.dart';
//import 'package:sit/src/pages/home.dart';
import 'package:sistema_transporte/src/pages/login.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Material App',
      home: Login()
    );
  }
}