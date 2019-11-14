import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sistema_transporte/src/models/user.dart';
import 'package:sistema_transporte/src/pages/login.dart';
import 'package:sistema_transporte/src/provider/userProvider.dart';

class NavigationDrawer extends StatefulWidget {
  @override
  _NavigationDrawerState createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  @override
  Widget build(BuildContext context) {
    User user;

    setState(() {
      user = Provider.of<UserProvider>(context).getUsuario();
    });

    return new Drawer(
      child: Column(
        children: <Widget>[
          new UserAccountsDrawerHeader(
              currentAccountPicture: Icon(
                Icons.account_circle,
                size: 80,
              ),
              accountName: new Text("${user.getUsuario}"),
              accountEmail: new Text("${user.getMail}"),
              arrowColor: Colors.white,
              decoration: new BoxDecoration(color: Colors.blue[400])),
          Expanded(
            child: new Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                new ListTile(
                    leading: Icon(Icons.home, color: Colors.black, size: 30),
                    title: Text("Menu Principal"),
                    onTap: () => {
                          Navigator.of(context).pop(),
                          Navigator.of(context)
                              .pushReplacementNamed('/principal'),
                        }),
                new ListTile(
                    leading: new Icon(Icons.compare_arrows,
                        color: Colors.black, size: 30),
                    title: new Text("Movimientos"),
                    onTap: () => {
                          Navigator.of(context).pop(),
                          Navigator.of(context).pushNamed('/movimientos'),
                        }),
                new ListTile(
                    leading: Icon(Icons.payment, color: Colors.black, size: 30),
                    title: Text("Recarga"),
                    onTap: () => {
                          Navigator.of(context).pop(),
                          Navigator.of(context).pushNamed('/recargas')
                        }),
                new ListTile(
                    leading: Icon(Icons.subway, color: Colors.black, size: 30),
                    title: Text("Estaciones"),
                    onTap: () => {
                          Navigator.of(context).pop(),
                          Navigator.of(context).pushNamed('/estaciones')
                        }),
                new ListTile(
                    leading: Icon(Icons.departure_board,
                        color: Colors.black, size: 30),
                    title: Text("Planea un viaje"),
                    onTap: () => {
                          Navigator.of(context).pop(),
                          Navigator.of(context).pushNamed('/planeador')
                        }),
                new ListTile(
                    leading:
                        Icon(Icons.settings, color: Colors.black, size: 30),
                    title: Text("Configuracion"),
                    onTap: () => {
                          Navigator.of(context).pop(),
                          Navigator.of(context).pushNamed('/configuracion')
                        }),
              ],
            ),
          ),
          Divider(),
          new ListTile(
            leading: Icon(Icons.arrow_back_ios, color: Colors.red, size: 30),
            title: Text(
              "Cerrar Sesion",
              style: TextStyle(color: Colors.red),
            ),
            onTap: () => {
              clearLoginToken(),
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (BuildContext context) => LoginPage()),(Route<dynamic> route) => false
              )
            },
          ),
          SizedBox(
            height: 10.0,
          )
        ],
      ),
    );
  }

  clearLoginToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove('loginToken');
  }
}
