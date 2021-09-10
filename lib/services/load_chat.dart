import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'prefs.dart';
import 'url.dart';

class LoadChat extends StatefulWidget {
  const LoadChat({Key? key}) : super(key: key);

  @override
  _LoadChatState createState() => _LoadChatState();
}

class _LoadChatState extends State<LoadChat> {

  //funzione per caricare chat
  Future <void> getChat() async {
    try {
      //map per dati presi da home.dart
      Map data = {};
      data = data.isNotEmpty ? data : ModalRoute.of(context)!.settings.arguments as Map;
      String selection = data['selection'];

      //prendiamo i dati da ferme
      Response response = await get(Uri.parse('${url}pages/loadChat.php?selection=$selection'));
      List<dynamic> result = jsonDecode(response.body);

      //e mandiamo a chat.dart
      Navigator.pushReplacementNamed(context, '/chat', arguments:{'selection': selection, 'messages': result});
    } catch (e) {
      print('caught error: $e');
    }
  }

  int? gotInt = 0;
  _LoadChatState() {
    getId().then((val) =>
        setState(() {
          gotInt = val;
        }));
  }

  @override
  Widget build(BuildContext context) {

    if (gotInt == null) {
      Future.delayed(const Duration(milliseconds: 350), () {
        Navigator.pushReplacementNamed(context, '/signin');
      });
    }

    //l'unica cosa che avremo in termine di interfaccia grafica e' un'animazione di caricamento
    getChat();
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: SpinKitRotatingPlain(
          color: HexColor("#edf1f2"),
          size: 50.0,
        ),
      ),
    );
  }
}

