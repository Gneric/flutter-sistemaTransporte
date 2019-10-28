import 'package:flutter/material.dart';
import 'package:sistema_transporte/src/models/cards.dart';
import 'package:sistema_transporte/src/pages/drawer.dart';

class Recargar extends StatefulWidget {
  Recargar({Key key}) : super(key: key);

  @override
  _RecargarState createState() => _RecargarState();
}

class _RecargarState extends State<Recargar> {
  final List<Cards> litems = new List();

  @override
  void initState() {
    super.initState();
    setState(() {
      litems.add(new Cards('Card Modelo', '4458 55662 8877 9985', '02/25'));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.green),
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
                  color: Colors.green[100],
                  child: ListTile(
                    title: Text('Agregar metodo de pago'),
                    leading: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(Icons.credit_card),
                        Icon(Icons.add)
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 30.0),
                Expanded(
                  child: ListView.builder(
                      itemCount: litems.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            elevation: 5.0,
                            child: ListTile(
                              isThreeLine: true,
                              leading: Icon(Icons.credit_card),
                              title: Text(litems[index].name),
                              subtitle: Text(litems[index].number),
                              trailing: IconButton(icon: Icon(Icons.more_vert), onPressed: () => {})
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
}
