import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:html_unescape/html_unescape.dart';
import '../services/prefs.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../services/url.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  Future<String> getData (id, password) async {
    var urlPost = Uri.parse('${url}pages/profile.php');
    var response = await http.post(urlPost, body: {'id': '$id', 'password': '$password'});
    return response.body;
  }

  int? gotInt;
  String? gotPassword;
  _ProfileState() {
    getId().then((val) =>
      setState(() {
        if (val != null) {
          gotInt = val;
        }
      }));
    getPassword().then((valP) =>
      setState(() {
        if (valP != null) {
          gotPassword = valP;
        }
      }));
  }
  @override
  Widget build(BuildContext context) {
    var unescape = HtmlUnescape();
    return FutureBuilder(
        future: getData(gotInt, gotPassword),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData) {
            //preparatevi per codice schifoso
            List convert = [''];
            convert[0] = snapshot.data;
            Map profile = json.decode(convert[0]);

            return Scaffold(
                appBar: AppBar (
                  title: Text('Profilo Personale'),
                  centerTitle: true,
                  backgroundColor: HexColor("#00ABDE"),
                ),
                body: ListView(
                    children: [Padding (
                        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 70),
                        child: Center(
                          child: Column (
                              children: [
                                Image.asset('assets/pictures/im${profile['picture']}.png'),
                                SizedBox (height: 30),
                                Text (unescape.convert(profile['username']), style: TextStyle(fontSize: 25)),
                                SizedBox (height: 40),
                                Text (unescape.convert(profile['email']), style: TextStyle(fontSize: 15, color: Colors.black54)),
                                SizedBox (height: 30),
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
                ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Alert(
                    context: context,
                    type: AlertType.none,
                    title: "Cosa volete modificare?",
                    style: AlertStyle (
                      animationType: AnimationType.fromTop,
                    ),
                    content: Column (
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 20),
                        DialogButton(
                          child: Text(
                            "Foto Profilo",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.popAndPushNamed(context, '/modpicture');
                          },
                          color: HexColor("#00ABDE"),
                        ),
                        SizedBox(height: 20),
                        DialogButton(
                          child: Text(
                            "Email",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.popAndPushNamed(context, '/modemail');
                          },
                          color: HexColor("#00ABDE"),
                        ),
                        SizedBox(height: 20),
                        DialogButton(
                          child: Text(
                            "Descrizione",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.popAndPushNamed(context, '/moddesc', arguments:{'desc' : profile['description']});
                          },
                          color: HexColor("#00ABDE"),
                        ),
                        SizedBox(height: 20),
                        DialogButton(
                          child: Text(
                            "Password",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.popAndPushNamed(context, '/modpassword');
                          },
                          color: HexColor("#00ABDE"),
                        ),
                        SizedBox(height: 20),
                        DialogButton(
                          child: Text(
                            "Cancella Account",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          onPressed: () async{
                            final _formKey = GlobalKey<FormState>();
                            String? input;
                            Alert(
                                context: context,
                                type: AlertType.none,
                                title: "Sicuri di voler cancellare l'account?",
                                style: AlertStyle (
                                animationType: AnimationType.fromTop,
                            ),
                            content: Column (
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Form (
                                  key: _formKey,
                                  child: Center(
                                    child: Column(
                                        children: <Widget> [
                                          Padding (
                                            padding: EdgeInsets.all(20),
                                            child: TextFormField (
                                              obscureText: true,
                                              enableSuggestions: false,
                                              autocorrect: false,
                                              decoration: const InputDecoration(
                                                hintText: 'Inserite password',
                                              ),
                                              onChanged: (value) {
                                                input = value;
                                              },
                                            ),
                                          ),
                                          SizedBox(height: 20),
                                          SizedBox(
                                            child: TextButton (
                                                onPressed: () async {
                                                  if (_formKey.currentState!.validate()) {
                                                    var urlPost = Uri.parse('${url}pages/accDel.php');
                                                    var response = await http.post(urlPost, body: {'id' : '$gotInt', 'password' : '$input'});
                                                    deleteId();
                                                    deletePassword();
                                                    Navigator.pop(context);
                                                    Navigator.pop(context);
                                                    Navigator.pop(context);
                                                    Navigator.pushReplacementNamed(context, '/home');
                                                  }
                                                },
                                                style: ButtonStyle(
                                                  backgroundColor: MaterialStateProperty.all(HexColor("#00ABDE")),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Text('Invia', style: TextStyle(color: Colors.white)),
                                                )
                                            ),
                                          ),
                                        ]
                                    ),
                                  )
                              ),
                            ]),
                            buttons: [
                              DialogButton(
                                child: Text(
                                  "Annulla",
                                  style: TextStyle(color: Colors.white, fontSize: 20),
                                ),
                                onPressed: () => Navigator.pop(context),
                                color: Colors.orange,
                              ),
                            ]
                            ).show();
                          },
                          color: HexColor("#f42222"),
                        ),
                      ]
                    ),
                    buttons: [
                      DialogButton(
                        child: Text(
                          "Annulla",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        onPressed: () => Navigator.pop(context),
                        color: Colors.orange,
                      ),
                    ],
                  ).show();
                },
                backgroundColor: HexColor("#00ABDE"),
                child: Icon(Icons.manage_accounts),
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
}
