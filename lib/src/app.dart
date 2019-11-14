import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sistema_transporte/src/pages/login.dart';
import 'package:sistema_transporte/src/pages/mainMenu.dart';
import 'package:sistema_transporte/src/provider/movimientosProvider.dart';
import 'package:sistema_transporte/src/provider/userProvider.dart';
import 'package:sistema_transporte/src/routes/route_generator.dart';



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {    

    return MultiProvider(
        providers: [
          ChangeNotifierProvider( builder: (_) => UserProvider() ),
          ChangeNotifierProvider( builder: (_) => MovimientosProvider()) 
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

