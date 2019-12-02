import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class ChatBot extends StatefulWidget {
  ChatBot({Key key}) : super(key: key);

  @override
  _ChatBotState createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  final flutterWebviewPlugin = new FlutterWebviewPlugin();
  String url = 'https://assistant-chat-us-south.watsonplatform.net/web/public/158655ba-4612-4e1b-8e1a-0d89049d096f';

  @override
  void initState(){
    super.initState();
    loadJS();
  }

  @override
  void dispose() {
    flutterWebviewPlugin.dispose();
    super.dispose();
  }

  Future<void> loadJS() async {
    var givenJS = rootBundle.loadString('assets/injection.js');
    
    return givenJS.then((String js) {
      print("JS: $js");
      flutterWebviewPlugin.onStateChanged.listen((viewState) async {
        if (viewState.type == WebViewState.finishLoad) {
          flutterWebviewPlugin.evalJavascript(js); 
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(backgroundColor: Colors.blue[300], title: Text("IBM Watson ChatBot"), centerTitle: true, ),
        body: WebviewScaffold(
            url: 'https://assistant-chat-us-south.watsonplatform.net/web/public/158655ba-4612-4e1b-8e1a-0d89049d096f',
            clearCache: true,
            hidden: false,
            withJavascript: true,
          ),
    );              
  }
}