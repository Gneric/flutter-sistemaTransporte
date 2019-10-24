import 'package:flutter/material.dart';
import 'package:sistema_transporte/src/pages/drawer.dart';
import 'package:sistema_transporte/src/utils/movements_util.dart';


class Movimientos extends StatefulWidget {
  Movimientos({Key key}) : super(key: key);

  @override
  _MovimientosState createState() => _MovimientosState();
}

class _MovimientosState extends State<Movimientos> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
      ),
      drawer: NavigationDrawer(),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              child: ListView(
                children: <Widget>[
                  movement(15.0, '2019/10/24','08:14', "Recarga Virtual", context),
                  movement(-1.5, '2019/10/24','12:40', "Viaje San Borja", context),
                  movement(-1.5, '2019/10/24','09:53', "Viaje Jorge Chavez", context),
                  movement(-1.5, '2019/10/24','06:15', "Viaje La Cultura", context),
                  movement(-1.5, '2019/10/23', '09:46', 'Viaje San Borja Sur', context),
                  movement(-1.5, '2019/10/23', '08:30', 'Viaje Aviacion', context),
                  movement(-1.5, '2019/10/23', '05:46', 'Viaje Angamos Este', context),
                  movement(-1.5, '2019/10/23', '02:10', 'Viaje Bayobar', context),
                  movement(-1.5, '2019/10/23', '12:30', 'Viaje Jardines', context),
                  movement(-1.5, '2019/10/22', '08:37', 'Viaje Gamarra', context),
                  movement(10, '2019/10/20', '05:15', 'Recarga Villa', context),
                  movement(-1.5, '2019/10/20', '03:40', 'Viaje Parque Industrial', context),
                  movement(-1.5, '2019/10/20', '02:20', 'Viaje Pumacahua', context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}
