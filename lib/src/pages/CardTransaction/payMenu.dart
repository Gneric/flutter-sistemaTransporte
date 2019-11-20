import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sistema_transporte/src/models/cards.dart';
import 'package:sistema_transporte/src/models/trarjetasTren.dart';
import 'package:sistema_transporte/src/models/user.dart';
import 'package:sistema_transporte/src/pages/CardTransaction/payAmount.dart';
import 'package:sistema_transporte/src/pages/MainMenu/drawer.dart';
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

    TarjetasTren _selectedCard;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.blue[300]),
      drawer: NavigationDrawer(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            decoration: BoxDecoration(color: Colors.white),
            child: Column(
              children: <Widget>[
                Card(
                  elevation: 10.0,
                  color: Colors.blue[100],
                  child: ListTile(
                    title: Text('Agregar metodo de pago'),
                    leading: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(Icons.credit_card),
                        Icon(Icons.add)
                      ],
                    ),
                    onTap: () => {
                      //addCard(context, Cards('Card Add Test', '9988 5574 9856 2541', '04/22'))
                    },
                  ),
                ),
                SizedBox(height: 30.0),
                Expanded(
                  child: ListView.builder(
                      itemCount: user.getTarjetas.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            elevation: 5.0,
                            child: Dismissible(
                                  key: Key(user.getTarjetas[index].getCodigoTarjeta),
                                  background: Container(color: Colors.red,child: ListTile(trailing: Icon(Icons.delete, color: Colors.black))),
                                  onDismissed: (direction) => {
                                    setState((){
                                      Provider.of<UserProvider>(context).deleteTarjeta(index);
                                    }),
                                    Scaffold.of(context).showSnackBar(SnackBar(content: Text('Tarjeta Eliminada'), duration: Duration(seconds: 1),) )
                                  },
                                  child: ListTile(
                                    onTap: () => { seleccionaCard(user.getTarjetas[index], context) },
                                    leading: Icon(Icons.credit_card),
                                    title: Text("Tarjeta ${user.getTarjetas[index].getPerfilTarjeta}"),
                                    subtitle: Text("Codigo: ${user.getTarjetas[index].getCodigoTarjeta}   Saldo: ${user.getTarjetas[index].getSaldoTarjeta}")),
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
    );
  }

  void seleccionaCard(TarjetasTren tarjeta, context ){
    payAmount(tarjeta, context);
  }
}