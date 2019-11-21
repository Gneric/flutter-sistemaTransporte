import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sistema_transporte/src/models/movimientosTarjeta.dart';
import 'package:sistema_transporte/src/models/user.dart';
import 'package:sistema_transporte/src/provider/movimientosProvider.dart';
import 'package:sistema_transporte/src/provider/userProvider.dart';
import 'package:sistema_transporte/src/utils/ui_size.dart';
import 'package:sistema_transporte/src/utils/movement_util.dart';

import 'drawerScreen.dart';

class MainMenu extends StatefulWidget {
  final String message;

  MainMenu({Key key, this.message}) : super(key: key);

  @override
  _MainMenuState createState() => _MainMenuState();

}

class _MainMenuState extends State<MainMenu> {
  bool _isLoading = false;
  String mensaje;
  UserProvider userProvider = UserProvider();
  MovimientosProvider movimientosProvider = MovimientosProvider();

  Future<List<MovimientosTarjeta>> getMovimientos() async {
    //print("Entrando a getMovimientos()");
    try {
      var providerUsuario = Provider.of<UserProvider>(context, listen: false);
      var providerMovimientos = Provider.of<MovimientosProvider>(context, listen: false);

      var movimientos = await movimientosProvider.getListaMovimientos(providerUsuario.getUsuario().getCurrentTarjeta.getCodigoTarjeta);
      providerMovimientos.setMovimientos(movimientos);
      print("Conteo de Movimientos: ${movimientos.length}");
      return providerMovimientos.getMovimientos();
    } catch (e) {
      print("Error: " + e.toString());
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    if(mensaje!=null){
      print("MAINMENU - Message: $mensaje");
      //P r o c e s a d a // 8
      if(mensaje.substring(8,17)=="Procesada"){
        scaffoldKey.currentState.showSnackBar(
          SnackBar(duration: Duration(seconds: 2), content: Text("$mensaje"), backgroundColor: Colors.green[100],)
        );
      }
        
      //F a l l i d a // 6
      if(mensaje.substring(8,17)=="Fallida  "){
        scaffoldKey.currentState.showSnackBar(
          SnackBar(duration: Duration(seconds: 2), content: Text("$mensaje"), backgroundColor: Colors.red[100],)
        );
      }
    }


    var usuario = Provider.of<UserProvider>(context, listen: false);

    SizeConfig().init(context); // UI SCALING
    return _isLoading ? 
    Container(
      decoration: BoxDecoration(
        color: Colors.white
      ),
      child: Center(
        child: CircularProgressIndicator()
      )
    ) 
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
                                Text("${usuario.getUsuario().getNombre}", textAlign: TextAlign.center, style: TextStyle( color: Colors.black, fontSize: 50, fontWeight: FontWeight.bold))
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
                              child: GestureDetector(
                                  onDoubleTap: () async {
                                      // Setting the Loading on True for the CircularProgress
                                        setState(() {
                                          _isLoading = true;                                     
                                        });
                                      // Getting the values of userProvider instance
                                        User actualUser = Provider.of<UserProvider>(context, listen: false).getUsuario();
                                        UserProvider userProvider = new UserProvider();
                                        var newUser = await userProvider.getFileUser(actualUser.getUsername, actualUser.getPassword); 
                                        userProvider.setUsuario(newUser);                                 
                                      // Taking out the Circular when the progress is done
                                        setState(() {
                                          _isLoading = false;      
                                        });
                                  },
                                  child: Column(
                                  children: <Widget>[
                                    SizedBox(height: 10.0),
                                    Text("Tarjeta ${usuario.getUsuario().getCurrentTarjeta.perfilTarjeta}",textAlign: TextAlign.center,
                                    style: TextStyle( fontWeight: FontWeight.bold, fontSize: 35, color: Colors.black ),
                                    ),
                                    SizedBox(height: 10.0),
                                    Text("S/ ${usuario.getUsuario().getCurrentTarjeta.saldoTarjeta.toString()}",textAlign: TextAlign.center,
                                      style: TextStyle( fontWeight: FontWeight.bold, fontSize: 50, color: Colors.blue[400] ),
                                    ),
                                    SizedBox(height: 5.0),
                                    Text("Codigo Tarjeta: ${usuario.getUsuario().getCurrentTarjeta.codigoTarjeta}",textAlign: TextAlign.end,
                                      style: TextStyle( fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black ),
                                    )
                                  ],
                                ),
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
  }
  final scaffoldKey = GlobalKey<ScaffoldState>();
  static const snackBarDuration = Duration(seconds: 2);

  /* Mensaje de Confirmacion o no de recarga  */
  
  


  /* Warning de Salida */
  
  final snackBar = SnackBar(
    content: Text('Presione nuevamente para salir de la aplicacion'),
    duration: snackBarDuration,
    backgroundColor: Colors.red,
  );
  
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
