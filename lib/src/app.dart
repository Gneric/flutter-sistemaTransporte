import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sistema_transporte/src/models/trarjetasTren.dart';
import 'package:sistema_transporte/src/models/user.dart';
import 'package:sistema_transporte/src/pages/login2.dart';
import 'package:sistema_transporte/src/pages/mainMenu.dart';
import 'package:sistema_transporte/src/routes/route_generator.dart';



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {    

    return MultiProvider(
        providers: [
          ChangeNotifierProvider( builder: (_) => User() )
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

