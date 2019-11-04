import 'package:flutter/material.dart';
import 'package:sistema_transporte/src/pages/login.dart';
import 'package:sistema_transporte/src/pages/login2.dart';
import 'package:sistema_transporte/src/pages/main.dart';
import 'package:sistema_transporte/src/routes/route_generator.dart';


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Material App',
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
      routes: <String, WidgetBuilder>{
        '/principal': (context) => Main(),
        '/': (context) => LoginPage(),
      },
    );
  }
}