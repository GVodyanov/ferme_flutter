import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../services/url.dart';

class ViewProfile extends StatefulWidget {
  const ViewProfile({Key? key}) : super(key: key);

  @override
  _ViewProfileState createState() => _ViewProfileState();
}

class _ViewProfileState extends State<ViewProfile> {

  Future<String> getData (id) async {
    Response response = await get(Uri.parse('${url}pages/viewProfile.php?id=$id'));
    return response.body;
  }

  @override
  Widget build(BuildContext context) {
    Map data = {};
    data = data.isNotEmpty ? data : ModalRoute.of(context)!.settings.arguments as Map;
    String id = data['id'];
    var unescape = HtmlUnescape();
    return FutureBuilder(
      future: getData(id),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.hasData) {
          //preparatevi per codice schifoso
          List convert = [''];
          convert[0] = snapshot.data;
          Map profile = json.decode(convert[0]);

          return Scaffold(
            appBar: AppBar (
              title: Text('Profilo di ${unescape.convert(profile['username'])}'),
              centerTitle: true,
              backgroundColor: HexColor("#00ABDE"),
            ),
            body: ListView(
              children: [Padding (
                padding: EdgeInsets.all(30),
                child: Center(
                  child: Column (
                    children: [
                      Image.asset('assets/pictures/im${profile['picture']}.png'),
                      SizedBox (height: 30),
                      Text (unescape.convert(profile['username']), style: TextStyle(fontSize: 25)),
                      SizedBox (height: 40),
                      Text (unescape.convert(profile['description']), style: TextStyle(fontSize: 15, color: Colors.black54)),
                      SizedBox (height: 30),
                      Column (
                        children: [
                          Text('Anime: ${profile['interests']['anime']}%' , style: TextStyle(fontSize: 15, color: Colors.black54)),SizedBox (height: 15),
                          Text('Arte: ${profile['interests']['arte']}%' , style: TextStyle(fontSize: 15, color: Colors.black54)),SizedBox (height: 15),
                          Text('Cinema: ${profile['interests']['cinema']}%' , style: TextStyle(fontSize: 15, color: Colors.black54)),SizedBox (height: 15),
                          Text('Compiti: ${profile['interests']['compiti']}%' , style: TextStyle(fontSize: 15, color: Colors.black54)),SizedBox (height: 15),
                          Text('Cucina: ${profile['interests']['cucina']}%' , style: TextStyle(fontSize: 15, color: Colors.black54)),SizedBox (height: 15),
                          Text('Gaming: ${profile['interests']['gaming']}%' , style: TextStyle(fontSize: 15, color: Colors.black54)),SizedBox (height: 15),
                          Text('Hobby: ${profile['interests']['hobby']}%' , style: TextStyle(fontSize: 15, color: Colors.black54)),SizedBox (height: 15),
                          Text('Informatica: ${profile['interests']['informatica']}%' , style: TextStyle(fontSize: 15, color: Colors.black54)),SizedBox (height: 15),
                          Text('Musica: ${profile['interests']['musica']}%' , style: TextStyle(fontSize: 15, color: Colors.black54)),SizedBox (height: 15),
                          Text('Sport: ${profile['interests']['sport']}%' , style: TextStyle(fontSize: 15, color: Colors.black54))
                        ]
                      )
                    ]
                  ),
                )
              ),]
            )
          );
        } else {
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
    );
  }
}
