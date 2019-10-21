import 'package:flutter/material.dart';
import 'package:sistema_transporte/src/pages/main.dart';
import 'package:sistema_transporte/src/pages/movements.dart';

class NavigationDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Drawer(
      child: new Column(
        children: <Widget>[
          new UserAccountsDrawerHeader(
              currentAccountPicture: Icon(
                Icons.account_circle,
                size: 80,
              ),
              accountName: new Text("Oscar Biondi"),
              accountEmail: new Text("obiondi99@gmail.com"),
              arrowColor: Colors.white,
              decoration: new BoxDecoration(color: Colors.green)),
          new Column(
            children: <Widget>[
              new ListTile(
                leading: Icon(Icons.home, color: Colors.black, size: 30),
                title: Text("Menu Principal"),
                onTap: () => {
                        Navigator.pop(context),
                        Navigator.push(context,MaterialPageRoute(builder: (context) => Main())),
                      }),
              new ListTile(
                  leading: new Icon(Icons.compare_arrows, color: Colors.black, size: 30),
                  title: new Text("Movimientos"),
                  onTap: () => {
                        Navigator.pop(context),
                        Navigator.push(context,MaterialPageRoute(builder: (context) => Movimientos())),
                      }),
              new ListTile(
                leading: Icon(Icons.payment, color: Colors.black, size: 30),
                title: Text("Recarga"),
              ),
              new ListTile(
                leading: Icon(Icons.subway, color: Colors.black, size: 30),
                title: Text("Estaciones"),
              ),
              new ListTile(
                leading: Icon(Icons.departure_board, color: Colors.black, size: 30),
                title: Text("Planea un viaje"),
              ),
              new ListTile(
                leading: Icon(Icons.settings, color: Colors.black, size: 30),
                title: Text("Configuracion"),
              ),
            ],
          )
        ],
      ),
    );
  }
}