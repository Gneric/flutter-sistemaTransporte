import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sistema_transporte/src/models/movimientosTarjeta.dart';
import 'package:sistema_transporte/src/models/trarjetasTren.dart';
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
  bool _isLoadingMovements = true;
  String mensaje;
  UserProvider userProvider = UserProvider();
  MovimientosProvider movimientosProvider = MovimientosProvider();
  List<TarjetasTren> listTarjeta;
  int indexTarjeta = 0;
  int countMovimientos = 0;

  Future<List<MovimientosTarjeta>> getMovimientos() async {
    //print("Entrando a getMovimientos()");
    try {
      _isLoadingMovements = true;
      var providerMovimientos = Provider.of<MovimientosProvider>(context, listen: false);
        //print("DATOS DE LA TARJETA");
        //print("Conteo de Tarjetas: ${listTarjeta.length}");
        // print("codigoTarjeta en index $indexTarjeta: ${listTarjeta[indexTarjeta].codigoTarjeta}");
      var movimientos = await movimientosProvider.getListaMovimientos(listTarjeta[indexTarjeta].codigoTarjeta);
      providerMovimientos.setMovimientos(movimientos);
      countMovimientos = movimientos.length;
        print("Conteo de Movimientos: ${movimientos.length}");
      _isLoadingMovements = false;
      return providerMovimientos.getMovimientos();
    } catch (e) {
      print("Error: " + e.toString());
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    
    var providerUsuario = Provider.of<UserProvider>(context, listen: false);
    listTarjeta = providerUsuario.getUsuario().getTarjetas;

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
                              padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 30.0),
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
                                  child: Row(                                 
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                        GestureDetector(
                                          onTap: () => { chooseTarjetaMenos() },
                                          child: Icon(Icons.arrow_back_ios, color: Colors.blue[300])
                                        ),
                                        Column(
                                        children: <Widget>[
                                          SizedBox(height: 10.0),
                                          Text("Tarjeta ${listTarjeta[indexTarjeta].perfilTarjeta}",textAlign: TextAlign.center,
                                          style: TextStyle( fontWeight: FontWeight.bold, fontSize: 35, color: Colors.black ),
                                          ),
                                          SizedBox(height: 10.0),
                                          Text("S/ ${listTarjeta[indexTarjeta].saldoTarjeta.toString()}",textAlign: TextAlign.center,
                                            style: TextStyle( fontWeight: FontWeight.bold, fontSize: 50, color: Colors.blue[400] ),
                                          ),
                                          SizedBox(height: 5.0),
                                          Text("Codigo Tarjeta: ${listTarjeta[indexTarjeta].codigoTarjeta}",textAlign: TextAlign.end,
                                            style: TextStyle( fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black ),
                                          )],
                                      ),
                                      GestureDetector(
                                        onTap: () => { chooseTarjetaMas() },
                                        child: Icon(Icons.arrow_forward_ios, color: Colors.blue[300])
                                      ),
                                    ],
                                  ),
                              )),
                          SizedBox(height: SizeConfig.blockSizeVertical * 3),
                          FutureBuilder(
                                future: getMovimientos(),
                                builder: (BuildContext context,AsyncSnapshot snapshot) {
                                  return !snapshot.hasData ? 
                                        Container(child: Center(child:CircularProgressIndicator()))
                                      : _isLoadingMovements ? Container(child: Center(child:CircularProgressIndicator()))
                                      : Container(padding: EdgeInsets.fromLTRB(10, 10, 10, 15),
                                          decoration: BoxDecoration(
                                              border: Border(top: BorderSide(color: Colors.black,width: 1.5))),
                                            child: Column(
                                              children: <Widget>[
                                                Column(
                                                  children: <Widget>[
                                                    Container(
                                                      margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical /2.5, bottom: SizeConfig.blockSizeVertical / 2.5),
                                                      child: Text("Ultimos Movimientos",textAlign:TextAlign.center,
                                                            style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight: FontWeight.bold,
                                                            ),
                                                      ),
                                                    ),
                                                    Container(
                                                      constraints: BoxConstraints(
                                                      maxHeight: 330,
                                                    ),
                                                    child: ListView.builder(
                                                      itemCount: 5,
                                                      itemBuilder: (BuildContext context, int index){
                                                        return movement(snapshot.data[index], context);
                                                      }),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                        );
                                }),
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

  /* ChooseTarjeta */
  chooseTarjetaMas(){ 
    setState(() {
      if(indexTarjeta >= listTarjeta.length - 1 ){
        indexTarjeta = 0;
      }
      else {
        indexTarjeta = indexTarjeta + 1;
      }
      getMovimientos();
    });
  }

  chooseTarjetaMenos(){
    setState(() {
      if(indexTarjeta <= 0 ){
        indexTarjeta = listTarjeta.length - 1;
      }
      else {
        indexTarjeta = indexTarjeta - 1;
      }
      getMovimientos();
    });
  
  }
  
  


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
