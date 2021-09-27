import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:html_unescape/html_unescape.dart';
import '../services/prefs.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import '../services/url.dart';
import 'dart:async';
import 'package:timer_builder/timer_builder.dart';
import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {

  Future<String> getChat(selection) async {
    Response response = await get(Uri.parse('${url}pages/loadChat.php?selection=$selection'));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(selection, response.body);
    return response.body;
  }

  //unescape ci serve per convertire caratteri speciali di html
  var unescape = HtmlUnescape();

  //buildMessage serve piu' che altro per gestire segnalazioni
  String buttonText = "Messaggio segnalato :( Clicca per visualizzare";
  Widget buildMessage (Map i) {
    if (i['reports'] == 0) {
      return Text(
          unescape.convert(i['message']),
          style: TextStyle (
            color: Colors.black45,
          )
      );
    } else {
      bool isChanged = false;
      return TextButton(
        child: Text(
          buttonText,
          style: TextStyle(
            fontStyle: FontStyle.normal,
            color: Colors.redAccent,
          )
        ),
        onPressed: () {
          isChanged = !isChanged;
          setState(() {
            if (isChanged == true)  buttonText = unescape.convert(i['message']);
          });
        }
      );
    }
  }

  Future<Widget?> messageActions(action, messageId, id, selection, message) async{
    if (action == 1) {
      //modificare
      Navigator.pushNamed(context, '/msgedit', arguments: {'selection': selection, 'message': message, 'messageId': '$messageId'});
    } else if (action == 2) {
      //cancellare
      Alert(
        context: context,
        type: AlertType.warning,
        title: "Sicuri che volete cancellare questo messaggio?",
        desc: "Questa azione non può essere disfatta",
        style: AlertStyle (
          animationType: AnimationType.fromTop,
        ),
        buttons: [
          DialogButton(
            child: Text(
              "Annulla",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
            color: HexColor("#00ABDE"),
          ),
          DialogButton(
            child: Text(
              "Cancella",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: ()  async {
              var urlPost = Uri.parse('${url}pages/messageActions.php');
              var response = await http.post(urlPost, body: {'action': 'delete', 'id': '$gotInt', 'selection': selection, 'messageId' : '$messageId', 'password' : '$gotPassword'});
              Navigator.pop(context);
            },
            gradient: LinearGradient(colors: [
              HexColor('#ff3b14'),
              HexColor('#b1290e'),
            ]),
          )
        ],
      ).show();
    } else if (action == 3) {
      //segnalare
      Alert(
        context: context,
        type: AlertType.warning,
        title: "Sicuri che volete segnalare questo messaggio?",
        desc: "Questa azione non può essere disfatta",
        style: AlertStyle (
          animationType: AnimationType.fromTop,
        ),
        buttons: [
          DialogButton(
            child: Text(
              "Annulla",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
            color: HexColor("#00ABDE"),
          ),
          DialogButton(
            child: Text(
              "Segnala",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: ()  async {
              var urlPost = Uri.parse('${url}pages/messageActions.php');
              var response = await http.post(urlPost, body: {'action': 'report', 'id': '$gotInt', 'selection': selection, 'messageId' : '$messageId', 'password' : '$gotPassword'});
              Navigator.pop(context);
            },
            gradient: LinearGradient(colors: [
              HexColor('#ff3b14'),
              HexColor('#b1290e'),
            ]),
          )
        ],
      ).show();

    }
  }

  Widget whichOptions (id, setId, Map i, selection) {
    if (id.toString() == setId.toString()) {
      return PopupMenuButton(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Icon(
              Icons.more_horiz,
              color: Colors.grey[400],
            ),
          ),
          onSelected: (item) => messageActions(item, i['messageId'], gotInt, selection, i['message']),
          itemBuilder: (context) => [
            PopupMenuItem(
              child: Text("Modifica"),
              value: 1,
            ),
            PopupMenuItem(
              child: Text("Cancella"),
              value: 2,
            )
          ]
      );
    } else {
      return PopupMenuButton(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Icon(
              Icons.more_horiz,
              color: Colors.grey[400],
            ),
          ),
          onSelected: (item) => messageActions(item, i['messageId'], gotInt, selection, i['message']),
          itemBuilder: (context) => [
            PopupMenuItem(
              child: Text("Segnala"),
              value: 3,
            )
          ]
      );
    }
  }

  int? gotInt;
  String? gotPassword;
  List<dynamic>? newData;
  _ChatState() {
    getId().then((val) =>
        setState(() {
          gotInt = val;
          if (gotInt == null) {
            Future.delayed(const Duration(milliseconds: 350), () {
              Navigator.pushReplacementNamed(context, '/signin');
            });
          }
        }));
    getPassword().then((valP) =>
        setState(() {
          gotPassword = valP;
        }));
  }

  @override
  Widget build(BuildContext context) {

    //scroll controller per partire dal basso
    ScrollController _scrollController = new ScrollController();

    Map data = {};
    data = data.isNotEmpty ? data : ModalRoute.of(context)!.settings.arguments as Map;
    String selection = data['selection'];

    String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

    return TimerBuilder.periodic(Duration(seconds: 5),
      builder: (context) {
        return FutureBuilder<String>(
            future: getChat(selection),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (snapshot.hasData) {
              //preparatevi per codice schifoso
              List convert = ['r/' , '[{"idk" : null}]', 'programminghorror'];
              if (snapshot.data != null) {
                convert[1] = snapshot.data;
              }
              List<dynamic>? messages = json.decode(convert[1]);
              convert[2] = messages;
              convert[2] = convert[2].reversed.toList();

              messages = convert[2].reversed.toList();
              return Scaffold(
                appBar: AppBar(
                  backgroundColor: HexColor("#00ABDE"),
                  title: Text(capitalize(data['selection'])),
                  centerTitle: true,
                ),
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    String selection = data['selection'];
                    Navigator.pushNamed(
                        context, '/write', arguments: {'selection': selection});
                  },
                  backgroundColor: HexColor("#00ABDE"),
                  child: Icon(Icons.edit),
                ),
                body: Container(
                  child: ListView(
                      shrinkWrap: true,
                      controller: _scrollController,
                      reverse: true,
                      children: [
                        for ( var i in convert[2] ) Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: <Widget>[
                              ListTile(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    side: BorderSide(color: HexColor('#ebebeb'))),
                                leading: Image.asset(
                                    'assets/pictures/im${i['picture']}.png'
                                ),
                                title: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        height: 25,
                                        child: RawMaterialButton(
                                          constraints: BoxConstraints(minWidth: 0, maxWidth: 50000),
                                          child: Text(
                                            unescape.convert(i['username']),
                                            style: TextStyle (
                                              fontSize: 17,
                                              color: Colors.black54,
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                          onPressed: () {
                                            Navigator.pushNamed(context, '/viewprofile', arguments:{'id': i['userId']});
                                          }
                                        ),
                                      ),
                                      whichOptions(i['userId'], gotInt, i, data['selection'])
                                    ]
                                ),
                                tileColor: HexColor('#eeeeee'),
                                subtitle: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Divider(),
                                      buildMessage(i),
                                      SizedBox(height: 10),
                                      Text(
                                          i['date'],
                                          style: TextStyle(
                                            fontStyle: FontStyle.italic,
                                            color: Colors.grey[400],
                                          )
                                      )
                                    ]
                                ),
                                contentPadding: EdgeInsets.fromLTRB(0, 0, 65, 10),
                              )
                            ],
                          ),
                        ),
                      ]
                  ),
                ),
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
    );
  }
}