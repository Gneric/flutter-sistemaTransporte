import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sistema_transporte/src/pages/LogIn/loginScreen.dart';
import 'package:sistema_transporte/src/pages/MainMenu/mainMenu.dart';
import 'package:sistema_transporte/src/provider/corredorStationProvider.dart';
import 'package:sistema_transporte/src/provider/metropolitanoStationProvider.dart';
import 'package:sistema_transporte/src/provider/movimientosProvider.dart';
import 'package:sistema_transporte/src/provider/trenStationProvider.dart';
import 'package:sistema_transporte/src/provider/userProvider.dart';
import 'package:sistema_transporte/src/routes/route_generator.dart';



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {    

    return MultiProvider(
        providers: [
          ChangeNotifierProvider( builder: (_) => UserProvider() ),
          ChangeNotifierProvider( builder: (_) => MovimientosProvider() ),
          ChangeNotifierProvider( builder: (_) => TrenStationProvider() ),
          ChangeNotifierProvider( builder: (_) => MetropolitanoStationProvider() ),
          ChangeNotifierProvider( builder: (_) => CorredorStationProvider() )
        ],
        child: MaterialApp(
        title: 'Material App',
        initialRoute: '/',
        onGenerateRoute: RouteGenerator.generateRoute,
        routes: <String, WidgetBuilder>{
          '/principal': (context) => MainMenu(),
          '/': (context) => LoginPage(),
        },
      ),
    );
  }
}

