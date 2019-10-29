import 'package:flutter/material.dart';
import 'package:sistema_transporte/src/pages/drawer.dart';
import 'package:sistema_transporte/src/pages/ui_size.dart';
import 'package:sistema_transporte/src/utils/movement_util.dart';

class Main extends StatefulWidget {
  Main({Key key}) : super(key: key);

  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {

  static const snackBarDuration = Duration(seconds: 2);

  final snackBar = SnackBar(
    content: Text('Presione nuevamente para salir de la aplicacion'),
    duration: snackBarDuration,
    backgroundColor:  Colors.red,
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

  // Data en duro para el menu
  final currencyBalance = Text(
    "S/25.00",
    textAlign: TextAlign.center,
    style: TextStyle(
        color: Colors.green, fontSize: 35, fontWeight: FontWeight.bold),
  );
  final welcome = Text(
    "Bienvenido",
    textAlign: TextAlign.center,
    style: TextStyle(
        color: Colors.black, fontSize: 50, fontWeight: FontWeight.bold ),
  );
  final userWelcome = Text(
    "Oscar Biondi",
    textAlign: TextAlign.center,
    style: TextStyle(
        color: Colors.black, fontSize: 50, fontWeight: FontWeight.bold),
  );
  //


  final currencyBox = Container(
      margin: EdgeInsets.all(5.0),
      padding: EdgeInsets.fromLTRB(100.0, 20.0, 100.0, 30.0),
      decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: new BorderRadius.all(Radius.circular(20.0))),
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
            "S/ 25.00",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 50, color: Colors.green),
          )
        ],
      ));

  Widget movementBox(context) {
    return Expanded(
        child: Container(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 15),
        decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.black, width: 1.5))),
        child: SingleChildScrollView(
            child: Column(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical / 2.5, bottom: SizeConfig.blockSizeVertical / 2.5),
                    child: Text(
                      "Ultimos Movimientos",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  movement(15.0, '2019/10/24','08:14', "Recarga Virtual", context),
                  movement(-1.5, '2019/10/24','12:40', "Viaje San Borja", context),
                  movement(-1.5, '2019/10/24','09:53', "Viaje Jorge Chavez", context),
                  movement(-1.5, '2019/10/24','06:15', "Viaje La Cultura", context),
                  movement(-1.5, '2019/10/23', '09:46', 'Viaje San Borja Sur', context)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  } 

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context); // UI SCALING
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green,
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
                padding: EdgeInsets.fromLTRB(0,SizeConfig.blockSizeHorizontal*4,0,0),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: SizeConfig.blockSizeVertical * 2),
                    welcome,
                    SizedBox(height: SizeConfig.blockSizeVertical / 2),
                    userWelcome,
                    SizedBox(height: SizeConfig.blockSizeVertical * 5),
                    currencyBox,
                    SizedBox(height: SizeConfig.blockSizeVertical * 6),
                    movementBox(context),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
