import 'package:flutter/material.dart';
import 'package:sistema_transporte/src/pages/configuration.dart';
import 'package:sistema_transporte/src/pages/login.dart';
import 'package:sistema_transporte/src/pages/main.dart';
import 'package:sistema_transporte/src/pages/movements.dart';
import 'package:sistema_transporte/src/pages/planner.dart';
import 'package:sistema_transporte/src/pages/recharge.dart';
import 'package:sistema_transporte/src/pages/stations.dart';

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
          Expanded(
            child: new Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                new ListTile(
                    leading: Icon(Icons.home, color: Colors.black, size: 30),
                    title: Text("Menu Principal"),
                    onTap: () => {
                          Navigator.pop(context),
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Main())),
                        }),
                new ListTile(
                    leading: new Icon(Icons.compare_arrows,
                        color: Colors.black, size: 30),
                    title: new Text("Movimientos"),
                    onTap: () => {
                          Navigator.pop(context),
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Movimientos())),
                        }),
                new ListTile(
                  leading: Icon(Icons.payment, color: Colors.black, size: 30),
                  title: Text("Recarga"),
                  onTap: () => {
                          Navigator.pop(context),
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Recargar())),
                        }),
                new ListTile(
                  leading: Icon(Icons.subway, color: Colors.black, size: 30),
                  title: Text("Estaciones"),
                  onTap: () => {
                          Navigator.pop(context),
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Estaciones())),
                        }),
                new ListTile(
                  leading: Icon(Icons.departure_board,
                      color: Colors.black, size: 30),
                  title: Text("Planea un viaje"),
                  onTap: () => {
                          Navigator.pop(context),
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Planeador())),
                        }),
                new ListTile(
                  leading: Icon(Icons.settings, color: Colors.black, size: 30),
                  title: Text("Configuracion"),
                  onTap: () => {
                          Navigator.pop(context),
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Configuracion())),
                        }),
              ],
            ),
          ),
          Divider(),
          new ListTile(
            leading: Icon(Icons.arrow_back_ios, color: Colors.red, size: 30),
            title: Text("Cerrar Sesion", style: TextStyle(color: Colors.red ), ),
            onTap: () => {
              Navigator.pop(context),
              Navigator.push(context, MaterialPageRoute(builder: (context) => Login() ) ),
            },
          ),
          SizedBox(height: 10.0,)
        ],
      ),
    );
  }
}
