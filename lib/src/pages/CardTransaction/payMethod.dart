import 'package:flutter/material.dart';
import 'package:sistema_transporte/src/models/creditCard.dart';
import 'package:sistema_transporte/src/models/trarjetasTren.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
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
  RecargaProvider recargaProvider = new RecargaProvider();
  TarjetasTren tarjeta;
  double amount;

  _PayMethodState(this.tarjeta, this.amount);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            child: Column(
          children: <Widget>[
            Container(
              height: 50,
              child: Text(
                "Metodo de Pago",
                style: TextStyle(color: Colors.blue, fontSize: 25),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    _creditCardWidget(CreditCard(cardHolderName: "Tarjeta Visa 1", cardNumber: "77854996588562215", cvvCode: "885", expiryDate: "05/11", showBackView: false)),
                    _creditCardWidget(CreditCard(cardHolderName: "Tarjeta Visa 2", cardNumber: "885662441599687845", cvvCode: "224", expiryDate: "06/14", showBackView: false)),
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
    String string = creditCard.getCardNumber;
    var medioP = string.substring(string.length - 4);

    return GestureDetector(
          onTap: () async {       
              var res = await recargaProvider.registrarRecarga(tarjeta.getCodigoTarjeta, medioP, amount);
              //res == 1 ? Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainMenu(message: "Recarga Procesada",) ) ) : 
              //           Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainMenu(message: "Recarga Fallida  ",) ) ) ;
          },
          child: CreditCardWidget(
          cardHolderName: creditCard.getCardHoldeName,
          expiryDate: creditCard.getExpiryDate,
          cardNumber: creditCard.cardNumber,
          cvvCode: creditCard.cvvCode,
          showBackView: false,                     
        ),
      );
  }
}
