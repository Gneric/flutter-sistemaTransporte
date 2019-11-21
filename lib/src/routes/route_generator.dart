import 'package:flutter/material.dart';
import 'package:sistema_transporte/src/pages/CardTransaction/payMenu.dart';
import 'package:sistema_transporte/src/pages/DrawerScreens/configScreen.dart';
import 'package:sistema_transporte/src/pages/DrawerScreens/movementScreen.dart';
import 'package:sistema_transporte/src/pages/DrawerScreens/plannerScreen.dart';
import 'package:sistema_transporte/src/pages/DrawerScreens/stationsScreen.dart';
import 'package:sistema_transporte/src/pages/LogIn/loginScreen.dart';
import 'package:sistema_transporte/src/pages/MainMenu/mainMenu.dart';


class RouteGenerator{
  
  static Route generateRoute(RouteSettings settings){

    switch(settings.name){
      
      case '/':
        return MaterialPageRoute(builder: (_) => LoginPage());
      
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