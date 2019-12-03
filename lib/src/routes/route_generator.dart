import 'package:flutter/material.dart';
import 'package:sistema_transporte/src/pages/CardTransaction/addPayMethod.dart';
import 'package:sistema_transporte/src/pages/CardTransaction/payMenu.dart';
import 'package:sistema_transporte/src/pages/DrawerScreens/chatbot.dart';
import 'package:sistema_transporte/src/pages/DrawerScreens/configScreen.dart';
import 'package:sistema_transporte/src/pages/DrawerScreens/movementScreen.dart';
import 'package:sistema_transporte/src/pages/LogIn/loginScreen.dart';
import 'package:sistema_transporte/src/pages/MainMenu/mainMenu.dart';
import 'package:sistema_transporte/src/pages/Stations/stationsScreen.dart';


class RouteGenerator{
  
  static Route generateRoute(RouteSettings settings){

    switch(settings.name){
      
      case '/':
        return new MaterialPageRoute(builder: (_) => LoginPage());
      
      case '/principal':
        return new MaterialPageRoute(builder: (_) => MainMenu());

      case '/movimientos':
        return new MaterialPageRoute(builder: (_) => Movimientos());

      case '/recargas':
        return new MaterialPageRoute(builder: (_) => Recargar());

      case '/metodoPago':
        return new MaterialPageRoute(builder: (_) => AddPayMethod());

      case '/planeador':
        return new MaterialPageRoute(builder: (_) => ChatBot());

      case '/estaciones':
        return new MaterialPageRoute(builder: (_) => Estaciones());

      case '/configuracion':
        return new MaterialPageRoute(builder: (_) => Configuracion());
    }

  }


}