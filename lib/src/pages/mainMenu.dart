import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sistema_transporte/src/models/movimientosTarjeta.dart';
import 'package:sistema_transporte/src/models/user.dart';
import 'package:sistema_transporte/src/pages/drawer.dart';
import 'package:sistema_transporte/src/pages/login.dart';
import 'package:sistema_transporte/src/provider/movimientosProvider.dart';
import 'package:sistema_transporte/src/provider/userProvider.dart';
import 'package:sistema_transporte/src/utils/ui_size.dart';
import 'package:sistema_transporte/src/utils/movement_util.dart';

class MainMenu extends StatefulWidget {
  final String user;
  final String password;

  MainMenu({Key key, this.user, this.password}) : super(key: key);

  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  UserProvider userProvider = UserProvider();
  MovimientosProvider movimientosProvider = MovimientosProvider();

  Future<User> getUser() async {
    try {
      var usuario =
          await userProvider.getFileUser(widget.user, widget.password);
      Provider.of<UserProvider>(context).setUsuario(usuario);
      //print("Current Tarjeta: "+Provider.of<UserProvider>(context).getUsuario().getCurrentTarjeta.getCodigoTarjeta);
      return usuario;
    } catch (e) {
      print("Error: " + e.toString());
      var routeToLogin =
          new MaterialPageRoute(builder: (BuildContext context) => LoginPage());
      Navigator.of(context).pushReplacement(routeToLogin);
      return null;
    }
  }

  Future<List<MovimientosTarjeta>> getMovimientos() async {
    try {
      var movimientos = await movimientosProvider.getListaMovimientos(Provider.of<UserProvider>(context).getUsuario().getCurrentTarjeta.getCodigoTarjeta);
      Provider.of<MovimientosProvider>(context).setMovimientos(movimientos);
      //print("Movimientos: ${movimientos.length}");
      return movimientos;
    } catch (e) {
      print("Error: " + e.toString());
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context); // UI SCALING
    return FutureBuilder(
        future: getUser(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return !snapshot.hasData
              ? Scaffold(body: Center(child: CircularProgressIndicator()))
              : Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  backgroundColor: Colors.blue[300],
                ),
                drawer: NavigationDrawer(),
                key: scaffoldKey,
                body: WillPopScope(
                  onWillPop: onWillPop,
                  child: SafeArea(
                    child: Center(
                      child: Container(
                        color: Colors.white,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(0, SizeConfig.blockSizeHorizontal * 4, 0, 0),
                          child: Column(
                            children: <Widget>[
                              SizedBox(height: SizeConfig.blockSizeVertical * 2),
                              Container(
                                child: Column(
                                  children: <Widget>[
                                    Text("Bienvenido",textAlign: TextAlign.center,style: TextStyle(color: Colors.black,fontSize: 50, fontWeight: FontWeight.bold)),
                                    SizedBox(height: SizeConfig.blockSizeVertical / 2),
                                    Text("${snapshot.data.getNombre}", textAlign: TextAlign.center, style: TextStyle( color: Colors.black, fontSize: 50, fontWeight: FontWeight.bold))
                                  ],
                                ),
                              ),
                              SizedBox(height: SizeConfig.blockSizeVertical * 4),
                              Container(
                                  //height: SizeConfig.blockSizeVertical * 25,
                                  margin: EdgeInsets.all(5.0),
                                  padding: EdgeInsets.fromLTRB(100.0, 20.0, 100.0, 30.0),
                                  decoration: BoxDecoration(
                                      border: Border.all(),
                                      borderRadius: new BorderRadius.all(Radius.circular(20.0))),
                                  child: Column(
                                    children: <Widget>[
                                      SizedBox(height: 10.0),
                                      Text("Tarjeta ${snapshot.data.getCurrentTarjeta.perfilTarjeta}",textAlign: TextAlign.center,
                                      style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 35,
                                            color: Colors.black),
                                      ),
                                      SizedBox(height: 10.0),
                                      Text("S/ ${snapshot.data.getCurrentTarjeta.saldoTarjeta.toString()}",textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 50,
                                            color: Colors.blue[400]),
                                      ),
                                      SizedBox(height: 5.0),
                                      Text("Codigo Tarjeta: ${snapshot.data.getTarjetas[1].codigoTarjeta}",textAlign: TextAlign.end,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                            color: Colors.black),
                                      )
                                    ],
                                  )),
                              SizedBox(
                                  height: SizeConfig.blockSizeVertical * 5),
                              Expanded(
                                child: FutureBuilder(
                                    future: getMovimientos(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot snapshot) {
                                      return !snapshot.hasData
                                          ? Container(
                                              child: Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                            )
                                          : Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  10, 10, 10, 15),
                                              decoration: BoxDecoration(
                                                  border: Border(
                                                      top: BorderSide(
                                                          color: Colors.black,
                                                          width: 1.5))),
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  children: <Widget>[
                                                    Column(
                                                      children: <Widget>[
                                                        Container(
                                                          margin: EdgeInsets.only(
                                                              top: SizeConfig
                                                                      .blockSizeVertical /
                                                                  2.5,
                                                              bottom: SizeConfig
                                                                      .blockSizeVertical /
                                                                  2.5),
                                                          child: Text(
                                                            "Ultimos Movimientos",
                                                            textAlign:
                                                                TextAlign
                                                                    .center,
                                                            style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                        movement(snapshot.data[0], context),
                                                        movement(snapshot.data[1], context),
                                                        movement(snapshot.data[2], context),
                                                        movement(snapshot.data[3], context),
                                                        movement(snapshot.data[4], context)
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                    }),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
        });
  }

  /* Warning de Salida */
  static const snackBarDuration = Duration(seconds: 2);
  final snackBar = SnackBar(
    content: Text('Presione nuevamente para salir de la aplicacion'),
    duration: snackBarDuration,
    backgroundColor: Colors.red,
  );
  final scaffoldKey = GlobalKey<ScaffoldState>();
  DateTime backButtonPressTime;
  Future<bool> onWillPop() async {
    DateTime currentTime = DateTime.now();

    bool backButtonHasNotBeenPressedOrSnackBarHasBeenClosed =
        backButtonPressTime == null ||
            currentTime.difference(backButtonPressTime) > snackBarDuration;

    if (backButtonHasNotBeenPressedOrSnackBarHasBeenClosed) {
      backButtonPressTime = currentTime;
      scaffoldKey.currentState.showSnackBar(snackBar);
      return false;
    }

    return true;
  }
  /* ---------------------------------*/
}
