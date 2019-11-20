import 'package:flutter/material.dart';
import 'package:sistema_transporte/src/pages/CardTransaction/payMenu.dart';
import 'package:sistema_transporte/src/pages/DrawerScreens/configuration.dart';
import 'package:sistema_transporte/src/pages/DrawerScreens/movements.dart';
import 'package:sistema_transporte/src/pages/DrawerScreens/planner.dart';
import 'package:sistema_transporte/src/pages/DrawerScreens/register.dart';
import 'package:sistema_transporte/src/pages/DrawerScreens/stations.dart';
import 'package:sistema_transporte/src/pages/LogIn/login.dart';
import 'package:sistema_transporte/src/pages/MainMenu/mainMenu.dart';


class RouteGenerator{
  
  static Route generateRoute(RouteSettings settings){

    switch(settings.name){
      
      case '/':
        return MaterialPageRoute(builder: (_) => LoginPage());

      case '/registrar':
        return MaterialPageRoute(builder: (_) => Register());
      
      case '/principal':
        return MaterialPageRoute(builder: (_) => MainMenu());

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