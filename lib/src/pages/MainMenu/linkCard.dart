import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sistema_transporte/src/models/user.dart';
import 'package:sistema_transporte/src/provider/nuevaTarjetaProvider.dart';
import 'package:sistema_transporte/src/provider/userProvider.dart';


void vincularTarjeta(context){
  final _formKey = GlobalKey<FormState>();
  final _textKey = GlobalKey();
  TextEditingController tarjetaController = new TextEditingController();
  String mensaje = "Agregar una nueva tarjeta a esta cuenta";
  bool _isLoading = false;
   
   showModalBottomSheet(
     context: context,
     builder: (BuildContext context){
       return StatefulBuilder(builder: (context, state){
          
          updateMensaje(StateSetter updateState){
            try{
               updateState((){
                 _isLoading = false;
                 mensaje = "Esta Tarjeta no puede ser vinculada";
               });
            }
            catch(e){
              print("Error: " + e.toString());
            }                     
          }
          updateStateLoading(StateSetter updateState){
            updateState((){
               _isLoading = true;
            });
          }
          updateStateLoadingFalse(StateSetter updateState){
            updateState((){
              _isLoading = true;
            });
          }
          
          return Scaffold(
            resizeToAvoidBottomInset: true,
            resizeToAvoidBottomPadding: true,
            body: Padding(
              padding: const EdgeInsets.all(0),
              child: SafeArea(
                child: _isLoading ? 
                Container(
                  width: MediaQuery.of(context).size.width,
                   decoration: BoxDecoration(
                   gradient: LinearGradient(
                      colors: [Colors.white, Colors.blue[100]],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter)),
                  child: Center(
                     child: CircularProgressIndicator()
                  )
                )
                : Container(
                  decoration: BoxDecoration(
                    color: Colors.transparent
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                        colors: [Colors.blue[50], Colors.blue[100]],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter
                      )
                    ),
                    child: Container(
                      child: Form(
                         key: _formKey,
                         child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Container(
                               margin: EdgeInsets.fromLTRB(25, 0, 25, 0),
                               child: Text("$mensaje",
                                           key: _textKey,
                                           textAlign: TextAlign.center,
                                           style: TextStyle(color: Colors.blue, 
                                           fontStyle: FontStyle.italic, 
                                           fontWeight: FontWeight.bold,
                                           fontSize: 25 )
                              )
                            ),
                            Container(
                              width:  MediaQuery.of(context).size.width / 1.5,
                              child: TextFormField(
                                controller: tarjetaController,
                                obscureText: false,
                                decoration: InputDecoration(hintText: '999999999'),
                                validator: (value){
                                 if(value.isEmpty){
                                    return "Ingrese codigo de la Tarjeta";
                                 }
                                 return null;
                                },
                              ),
                            ),
                            RawMaterialButton(
                              constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width / 2, minHeight: 50),
                              fillColor: Colors.blue[300],
                              child: Text("Vincula tu tarjeta", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                              shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(5.0) ),
                              onPressed: () async {
                                if(_formKey.currentState.validate()){
                                  updateStateLoading(state);
                                  NuevaTarjetaProvider tarjetaProvider = new NuevaTarjetaProvider();
                                  User actualUser = Provider.of<UserProvider>(context, listen: false).getUsuario();
                                  int res = await tarjetaProvider.agregarTarjeta(actualUser.getUsername, tarjetaController.text);
                                  if(res==0){ 
                                    tarjetaController.clear();
                                    updateMensaje(state); 
                                  } 
                                  else {
                                    updateStateLoadingFalse(state);
                                    Navigator.pop(context);
                                  }
                                } 
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
       });
     }
   );
}