import 'package:flutter/material.dart';
import 'package:sistema_transporte/src/pages/configuration.dart';
import 'package:sistema_transporte/src/pages/login.dart';
import 'package:sistema_transporte/src/pages/login2.dart';
import 'package:sistema_transporte/src/pages/main.dart';
import 'package:sistema_transporte/src/pages/movements.dart';
import 'package:sistema_transporte/src/pages/planner.dart';
import 'package:sistema_transporte/src/pages/recharge.dart';
import 'package:sistema_transporte/src/pages/register.dart';
import 'package:sistema_transporte/src/pages/stations.dart';


class RouteGenerator{
  static Route<dynamic> generateRoute(RouteSettings settings){
    final args = settings.arguments;

    switch(settings.name){
      
      case '/':
        return MaterialPageRoute(builder: (_) => LoginPage());

      case '/registrar':
        return MaterialPageRoute(builder: (_) => Register());
      
      case '/principal':
        return MaterialPageRoute(builder: (_) => Main());

      case '/movimientos':
        return MaterialPageRoute(builder: (_) => Movimientos());

      case '/recargas':
        return MaterialPageRoute(builder: (_) => Recargar());

      case '/planeador':
        return MaterialPageRoute(builder: (_) => Planeador());

      case '/estaciones':
        return MaterialPageRoute(builder: (_) => Estaciones());

      case '/configuracion':
        return MaterialPageRoute(builder: (_) => Configuracion());
    }

  }


}