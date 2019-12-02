import 'package:flutter/material.dart';

class ChatBot extends StatefulWidget {
  ChatBot({Key key}) : super(key: key);

  @override
  _ChatBotState createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[400],
        title: Text("Configuracion"),
        centerTitle: true,
      ),
      body: Container(
        child: Center(
          child: Text("En construccion"),
        ),
      ),
    );
  }
}