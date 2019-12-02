import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:sistema_transporte/src/models/credit_card_model.dart';
import 'package:sistema_transporte/src/utils/credit_card_form.dart';

class AddPayMethod extends StatefulWidget {
  AddPayMethod({Key key}) : super(key: key);

  @override
  _AddPayMethodState createState() => _AddPayMethodState();
}

class _AddPayMethodState extends State<AddPayMethod> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(backgroundColor: Colors.blue[300], title: Text("Añadir Metodo de Pago"), centerTitle: true, ),
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: Column(
            children: <Widget>[
              CreditCardWidget(
                cardNumber: cardNumber,
                expiryDate: expiryDate,
                cardHolderName: cardHolderName,
                cvvCode: cvvCode,
                showBackView: isCvvFocused,
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    CreditCardForm(
                      onCreditCardModelChange: onCreditCardModelChange,
                    ),
                    SizedBox(height: 20.0),
                    RawMaterialButton(
                      constraints: BoxConstraints(minWidth: 25, minHeight: 50),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width / 1.5,
                            child: Center(
                              child: Text("Agregar metodo de pago",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
                            ),
                          )
                        ],
                      ),
                      fillColor: Colors.blue[400],
                      onPressed: () { 
                          // flutter defined function
                          
                        
                      },
                      shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(5.0) )       
                    )
                  ]  
                ),
              )
            ],
          ),
        ),
      );
  }

  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    setState(() {
      cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }
}