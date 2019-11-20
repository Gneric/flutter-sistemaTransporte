import 'package:flutter/material.dart';
import 'package:sistema_transporte/src/models/trarjetasTren.dart';


class PayMethod extends StatefulWidget {
  final TarjetasTren tarjeta;
  final double amount;
  PayMethod({Key key, @required this.tarjeta, @required this.amount }) : super(key: key);

  @override
  _PayMethodState createState() => _PayMethodState(this.tarjeta, this.amount);
}

class _PayMethodState extends State<PayMethod> {
  TarjetasTren tarjeta;
  double amount;

  _PayMethodState(this.tarjeta, this.amount);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Container(
         child: Text(tarjeta.getCodigoTarjeta),
       )
    );
  }
}