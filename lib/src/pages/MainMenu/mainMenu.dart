import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sistema_transporte/src/models/movimientosTarjeta.dart';
import 'package:sistema_transporte/src/models/trarjetasTren.dart';
import 'package:sistema_transporte/src/models/user.dart';
import 'package:sistema_transporte/src/pages/MainMenu/linkCard.dart';
import 'package:sistema_transporte/src/pages/Utils/movement_util.dart';
import 'package:sistema_transporte/src/pages/Utils/ui_size.dart';
import 'package:sistema_transporte/src/provider/movimientosProvider.dart';
import 'package:sistema_transporte/src/provider/userProvider.dart';

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
  UserProvider userProvider = UserProvider();
  MovimientosProvider movimientosProvider = MovimientosProvider();
  List<TarjetasTren> listTarjeta;
  int indexTarjeta = 0;
  int countMovimientos = 0;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  static const snackBarDuration = Duration(seconds: 2);

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

  Future<bool> showConfirmSnackBar() async {
    if(widget.message!=null){
      print("MAINMENU - Message: ${widget.message}");
      final confirmSnackBard =  SnackBar(
        content: Text('Mensaje: ${widget.message}', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
        duration: snackBarDuration,
        backgroundColor: Colors.green[100]
      );
      //P r o c e s a d a // 8
      if(widget.message.substring(8,17)=="Procesada"){
        scaffoldKey.currentState.showSnackBar(confirmSnackBard);
        return true;
      }
        
      //F a l l i d a // 6
      if(widget.message.substring(8,17)=="Fallida  "){
      final deniedSnackBard =  SnackBar(
        content: Text('${widget.message}', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
        duration: snackBarDuration,
        backgroundColor: Colors.red[100]
      );
        scaffoldKey.currentState.showSnackBar(deniedSnackBard);
        return true;
      }
    }
    else {
      print("Message is NULL bruh");
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {

    setState(() {
      if(scaffoldKey!=null){
        Future<bool> idk = showConfirmSnackBar();
      }    
    });
    
    var providerUsuario = Provider.of<UserProvider>(context, listen: false);
    listTarjeta = providerUsuario.getUsuario().getTarjetas;
    var usuario = Provider.of<UserProvider>(context, listen: false);

    SizeConfig().init(context); // UI SCALING
    return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.blue[300],
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.refresh),
                  onPressed: (){
                    actualizarMainMenu();
                  },
                ),
                IconButton(
                  icon: Icon(Icons.subtitles),
                  onPressed: (){
                    vincularTarjeta(context);
                  },
                )
              ],
            ),
            drawer: NavigationDrawer(),
            key: scaffoldKey,
            body: WillPopScope(
              onWillPop: onWillPop,
              child: _isLoading ? 
                Container(
                  decoration: BoxDecoration(
                   color: Colors.white
                  ),
                  child: Center(
                    child: CircularProgressIndicator()
                   )
                ) 
            : SafeArea(
                child: Center(
                  child: Container(
                    color: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: SizeConfig.blockSizeVertical * 2),
                          Container(
                            child: Column(
                              children: <Widget>[
                                Text("Bienvenido",textAlign: TextAlign.center,style: TextStyle(color: Colors.black,fontSize: 50, fontWeight: FontWeight.bold)),
                                SizedBox(height: SizeConfig.blockSizeVertical / 2),
                                Text("${usuario.getUsuario().getNombre[0].toUpperCase()}${usuario.getUsuario().getNombre.substring(1)}", textAlign: TextAlign.center, style: TextStyle( color: Colors.black, fontSize: 50, fontWeight: FontWeight.bold))
                              ],
                            ),
                          ),
                          SizedBox(height: SizeConfig.blockSizeVertical * 4),
                          Container(
                              //height: SizeConfig.blockSizeVertical * 25,
                              margin: EdgeInsets.all(15.0),
                              padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 30.0),
                              decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: new BorderRadius.all(Radius.circular(20.0))),
                              child: GestureDetector(
                                  onDoubleTap: () async {
                                      
                                  },                                
                                  child: listTarjeta.length < 1 ?
                                  Container(
                                    height: MediaQuery.of(context).size.height/9,
                                    width: MediaQuery.of(context).size.width,
                                    child: Center(child: AutoSizeText("Usted no cuenta con tarjetas",textAlign: TextAlign.center, style: TextStyle( fontWeight: FontWeight.bold, fontSize: 25, color: Colors.black ))),
                                  ) 
                                  : Row(                                 
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
                                  return listTarjeta.length < 1 ? 
                                        Container(
                                          height: MediaQuery.of(context).size.height / 2.12,
                                          child: Center(
                                            child: 
                                              RawMaterialButton(
                                                constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width / 1.5, minHeight: 50),
                                                fillColor: Colors.blue[200],
                                                child: Text("Vincula tu tarjeta", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                                                onPressed: () {
                                                  vincularTarjeta(context);
                                                },
                                                 shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(5.0) ))                                         
                                          ),
                                        )
                                      : !snapshot.hasData ? 
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
                                                        return index >= snapshot.data.length ? Container() : movement(snapshot.data[index], context);
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
  

  actualizarMainMenu() async {
    setState(() {
      _isLoading = true;                                     
    });
    User actualUser = Provider.of<UserProvider>(context, listen: false).getUsuario();
    UserProvider userProvider = new UserProvider();
       var newUser = await userProvider.getFileUser(actualUser.getUsername, actualUser.getPassword); 
    userProvider.setUsuario(newUser);                                 
    setState(() {
       _isLoading = false;      
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
