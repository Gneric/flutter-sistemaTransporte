import 'package:flutter/material.dart';

class Main extends StatefulWidget {
  Main({Key key}) : super(key: key);

  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  final currencyBalance = Text(
    "S/25.00",
    textAlign: TextAlign.center,
    style: TextStyle(
        color: Colors.green, fontSize: 50, fontWeight: FontWeight.bold),
  );

  final welcome = Text(
    "Bienvenido",
    textAlign: TextAlign.center,
    style: TextStyle(
        color: Colors.black, fontSize: 50, fontWeight: FontWeight.bold),
  );

  final userWelcome = Text(
    "Oscar Biondi",
    textAlign: TextAlign.center,
    style: TextStyle(
        color: Colors.black, fontSize: 50, fontWeight: FontWeight.bold),
  );

  final currencyBox = Container(
      margin: EdgeInsets.all(5.0),
      padding: EdgeInsets.fromLTRB(100.0, 20.0, 100.0, 30.0),
      decoration: BoxDecoration(border: Border.all()),
      child: Column(
        children: <Widget>[
          SizedBox(height: 10.0),
          Text(
            "Saldo",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 35, color: Colors.black),
          ),
          SizedBox(height: 10.0),
          Text(
            "S/25.00",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 35, color: Colors.green),
          )
        ],
      ));

  final movementBox = Container(
      margin: EdgeInsets.all(5.0),
      padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
      decoration: BoxDecoration(border: Border.all()),
      child: Column(
        children: <Widget>[
          movement(10, "positivo", DateTime.now(), "Recarga Aviacion"),
          movement(-2, "negativo", DateTime.now(), "Viaje San Borja"),
          movement(10, "positivo", DateTime.now(), "Recarga Jorge Chavez"),
          movement(-2, "negativo", DateTime.now(), "Viaje La Cultura")
        ],
      ));

  static Widget movement(
      int saldo, String tipo, DateTime fecha, String mensaje) {
    final _icons = <String, IconData>{
      "positivo": Icons.arrow_drop_up,
      "negativo": Icons.arrow_drop_down
    };

    final _colors = <String, Color>{
      "positivo": Colors.green,
      "negativo": Colors.red,
    };

    var subT = fecha.year.toString() +
        '/' +
        fecha.month.toString() +
        '/' +
        fecha.day.toString();

    return ListTile(
      title: Text(mensaje),
      subtitle: Text(subT),
      trailing: Text(saldo.toString(), style: TextStyle(color: _colors[tipo])),
      leading: Icon(
        _icons[tipo],
        color: _colors[tipo],
        size: 25,
        semanticLabel: 'uwu',
      ),
    );
  }

  final mainDrawer = Drawer(
    child: Column(
      children: <Widget>[
        new UserAccountsDrawerHeader(
            currentAccountPicture: Icon(
              Icons.account_circle,
              size: 80,
            ),
            accountName: Text("Oscar Biondi"),
            accountEmail: Text("obiondi99@gmail.com"),
            arrowColor: Colors.white,
            decoration: BoxDecoration(color: Colors.green)),
        Column(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.account_balance_wallet),
              title: Text("Movimientos"),
            ),
            ListTile(
              leading: Icon(Icons.add_shopping_cart),
              title: Text("Recarga"),
            ),
            ListTile(
              leading: Icon(Icons.schedule),
              title: Text("Planea un viaje"),
            )
          ],
        )
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: mainDrawer,
      body: SafeArea(
        child: Center(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.all(36.0),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 30.0),
                  welcome,
                  SizedBox(height: 2.0),
                  userWelcome,
                  SizedBox(height: 50.0),
                  currencyBox,
                  SizedBox(height: 80.0),
                  Text(
                    "Movimientos",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  movementBox,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
