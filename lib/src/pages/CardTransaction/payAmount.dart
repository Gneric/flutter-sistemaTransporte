import 'package:flutter/material.dart';
import 'package:sistema_transporte/src/models/trarjetasTren.dart';
import 'package:sistema_transporte/src/pages/CardTransaction/payMethod.dart';

void payAmount(TarjetasTren tarjeta, context) {

  showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(0),
          child: Container(
            color: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                  color: double.parse(tarjeta.getSaldoTarjeta) < 10 ? Colors.red[200] :
                         double.parse(tarjeta.getSaldoTarjeta) < 30 ? Colors.yellow[200] :
                         Colors.blue[200],
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10))),
              child: Container(
                width: 40.0,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            Text("Recarga Tarjeta ${tarjeta.getPerfilTarjeta}", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold) ),
                            SizedBox(height: 10),
                            Text("Codigo Tarjeta: ${tarjeta.getCodigoTarjeta}", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                            SizedBox(height: 10),
                            Text("Saldo Actual:  S/. ${tarjeta.getSaldoTarjeta.toString()}")
                          ],
                        ),
                      ),
                    ),
                    Divider(thickness: 2.0, color: Colors.black),
                    SizedBox(height: 20),
                    Container(
                      width: MediaQuery.of(context).size.width / 2,
                      child: Column(
                        children: <Widget>[
                          Card(
                            child: ListTile(
                              title: Text("S/. 10",style: TextStyle(fontSize: 20)),
                              onTap: () => { Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => PayMethod(tarjeta: tarjeta, amount: 10,) )) },
                            ),
                          ),
                          Card(
                            child: ListTile(
                              title: Text("S/. 20",style: TextStyle(fontSize: 20)),
                              onTap: () => { Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => PayMethod(tarjeta: tarjeta, amount: 20,) )) },
                            ),
                          ),
                          Card(
                            child: ListTile(
                              title: Text("S/. 50",style: TextStyle(fontSize: 20)),
                              onTap: () => { Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => PayMethod(tarjeta: tarjeta, amount: 50,) )) },
                            ),
                          ),
                          Card(
                            child: ListTile(
                              title: Text("S/. 100",style: TextStyle(fontSize: 20)),
                              onTap: () => { Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => PayMethod(tarjeta: tarjeta, amount: 100,) )) },
                            ),
                          ),
                        ],
                      ),
                    ) 
                  ],
                ),
              ),
            ),
          ),
        );
      });
}
