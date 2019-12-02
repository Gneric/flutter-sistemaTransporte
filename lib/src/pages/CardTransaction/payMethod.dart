import 'package:flutter/material.dart';
import 'package:sistema_transporte/src/models/creditCard.dart';
import 'package:sistema_transporte/src/models/credit_card_model.dart';
import 'package:sistema_transporte/src/models/trarjetasTren.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:sistema_transporte/src/pages/CardTransaction/addPayMethod.dart';
import 'package:sistema_transporte/src/pages/MainMenu/mainMenu.dart';
import 'package:sistema_transporte/src/provider/recargaProvider.dart';

class PayMethod extends StatefulWidget {
  final TarjetasTren tarjeta;
  final double amount;
  PayMethod({Key key, @required this.tarjeta, @required this.amount})
      : super(key: key);

  @override
  _PayMethodState createState() => _PayMethodState(this.tarjeta, this.amount);
}

class _PayMethodState extends State<PayMethod> {
  bool _isLoading = false;
  RecargaProvider recargaProvider = new RecargaProvider();
  TarjetasTren tarjeta;
  double amount;

  _PayMethodState(this.tarjeta, this.amount);

  @override
  Widget build(BuildContext context) {
    return _isLoading ? 
    Container(
    decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.white, Colors.blue[100]],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)),
      child: Center(
        child: CircularProgressIndicator()
      )
    )
    :Scaffold(
      appBar: AppBar(backgroundColor: Colors.blue[300], title: Text("Escoger Tarjeta a recargar"), centerTitle: true, ),
      body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            child: Column(
          children: <Widget>[
            Card(
              elevation: 10.0,
              color: Colors.blue[300] ,
              child: ListTile(
                title: Text('Agregar metodo de pago'),
                leading: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(Icons.credit_card),
                    Icon(Icons.add)
                  ],
                ),
                onTap: () {
                  Navigator.of(context).pushNamed('/metodoPago');
                },
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    _creditCardWidget(CreditCard(cardHolderName: "Tarjeta Visa 1", cardNumber: "7785 4996 5885 6215", cvvCode: "885", expiryDate: "05/11", showBackView: false)),
                    _creditCardWidget(CreditCard(cardHolderName: "Tarjeta Visa 2", cardNumber: "8856 6244 1599 687845", cvvCode: "224", expiryDate: "06/14", showBackView: false)),
                  ],
                ),
              )
            )
          ],
        )),
      ),
    ));
  }



  Widget _creditCardWidget(CreditCard creditCard){
    String cardHolder = creditCard.getCardHoldeName;
    String string = creditCard.getCardNumber;
    var medioP = string.substring(string.length - 4);

    return GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                // return object of type Dialog
                return AlertDialog(
                  title: Text("Mensaje de Confirmacion"),
                  content: Text("Desea confirmar la recarga con la tarjeta $cardHolder"),
                  actions: <Widget>[
                    FlatButton(
                      child: new Text("Confirmar"),
                      onPressed: () async {
                        setState(() {
                          _isLoading = true;
                        });   
                        var res = await recargaProvider.registrarRecarga(tarjeta.getCodigoTarjeta, medioP, amount);
                        setState(() {
                          _isLoading = false;
                        });
                        res == 1 ? Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainMenu(message: "Recarga Procesada",) ) ) : 
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainMenu(message: "Recarga Fallida  ",) ) ) ;
                      },
                    ),
                    FlatButton(
                      child: new Text("Cancelar"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          },
          child: Padding(
            padding: const EdgeInsets.fromLTRB(5, 6, 5, 6),
            child: CreditCardWidget(
            cardHolderName: creditCard.getCardHoldeName,
            expiryDate: creditCard.getExpiryDate,
            cardNumber: creditCard.cardNumber,
            cvvCode: creditCard.cvvCode,
            showBackView: false,                     
        ),
          ),
      );
  }
}

/*
showDialog(
  context: context,
  builder: (BuildContext context) {
    // return object of type Dialog
    return AlertDialog(
      title: Text("Alert Dialog title"),
      content: Text("Alert Dialog body"),
      actions: <Widget>[
        FlatButton(
          child: new Text("Confirmar"),
          onPressed: () async {
            setState(() {
              _isLoading = true;
            });   
            var res = await recargaProvider.registrarRecarga(tarjeta.getCodigoTarjeta, medioP, amount);
            setState(() {
              _isLoading = false;
            });
            res == 1 ? Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainMenu(message: "Recarga Procesada",) ) ) : 
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainMenu(message: "Recarga Fallida  ",) ) ) ;
          },
        ),
        FlatButton(
          child: new Text("Cancelar"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  },
);

*/
