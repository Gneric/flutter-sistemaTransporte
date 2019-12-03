import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sistema_transporte/src/models/cards.dart';
import 'package:sistema_transporte/src/models/trarjetasTren.dart';
import 'package:sistema_transporte/src/models/user.dart';
import 'package:sistema_transporte/src/pages/CardTransaction/payAmount.dart';
import 'package:sistema_transporte/src/pages/MainMenu/drawerScreen.dart';
import 'package:sistema_transporte/src/provider/userProvider.dart';

class Recargar extends StatefulWidget {
  Recargar({Key key}) : super(key: key);

  @override
  _RecargarState createState() => _RecargarState();
}

class _RecargarState extends State<Recargar> {
  var litems;
 
  void removeCard(index) {
    litems.removeAt(index);
    setState(() {});
  }

  void addCard(context, Cards card) {
    litems.add(card);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    User user;  

    setState(() {
      user = Provider.of<UserProvider>(context).getUsuario();
    });

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.blue[300], title: Text("Escoger Tarjeta a recargar"), centerTitle: true, ),
      drawer: NavigationDrawer(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(5, 20, 5, 20),
          child: Container(
            decoration: BoxDecoration(color: Colors.white),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    children: 
                      List.generate(user.getTarjetas.length, ( index ){
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RawMaterialButton(
                            constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width, minHeight: 50),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text("Tarjeta ${user.getTarjetas[index].getPerfilTarjeta}", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                                Text("Codigo: ${user.getTarjetas[index].getCodigoTarjeta}", style: TextStyle(fontSize: 15)),
                                Center(
                                  child: 
                                    Text("S/. ${user.getTarjetas[index].getSaldoTarjeta}",
                                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold) 
                                  )
                                )
                              ],
                            ),
                            fillColor: 
                              double.parse(user.getTarjetas[index].getSaldoTarjeta) < 10 ? Colors.red[200] :
                              double.parse(user.getTarjetas[index].getSaldoTarjeta) < 30 ? Colors.yellow[200] :
                              Colors.blue[200],
                            onPressed: () => { seleccionaCard(user.getTarjetas[index], context) },
                            shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(5.0) ),
                            
                          ),
                        );
                      })              
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void seleccionaCard(TarjetasTren tarjeta, context ){
    payAmount(tarjeta, context);
  }
  
}
