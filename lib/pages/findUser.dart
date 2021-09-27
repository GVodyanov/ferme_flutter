import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hexcolor/hexcolor.dart';
import '../services/url.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:html_unescape/html_unescape.dart';

class FindUser extends StatefulWidget {
  const FindUser({Key? key}) : super(key: key);

  @override
  _FindUserState createState() => _FindUserState();
}

class _FindUserState extends State<FindUser> {

  final _formKey = GlobalKey<FormState>();

  Future<String?> search (input) async {
    Response response = await get(Uri.parse('${url}pages/findUser.php?query=$input'));
    String? result = response.body;
    return result;
  }

  Widget buildResult (data) {
    var unescape = HtmlUnescape();
    if (data != null && data != '' && data != '"false"') {
      List<dynamic> results = json.decode(data);
      return Column (
        children: [
          for ( var i in results ) Padding (
            padding: EdgeInsets.all(20),
            child: TextButton (
              onPressed: () {
                Navigator.pushNamed(context, '/viewprofile', arguments: {'id' : '${i['id']}'});
              },
              style: ButtonStyle (
                backgroundColor: MaterialStateProperty.all(HexColor("#eeeeee")),
                padding: MaterialStateProperty.all(EdgeInsets.all(20)),
                foregroundColor: MaterialStateProperty.all(Colors.black54)
              ),
              child: SizedBox(
                width: 280,
                child: Row (
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset('assets/pictures/im${i['picture']}.png', width: 50),
                    Text (unescape.convert(i['username']))
                  ]
                ),
              ),
            )
          )
        ]
      );
    } else {
      return Text('');
    }
  }
  String? result = '';
  String? data = '';
  String? input;
  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar (
        title: Text('Cerca utente'),
        centerTitle: true,
        backgroundColor: HexColor("#00ABDE"),
      ),
      body: Column (
        children: [
          Form (
            key: _formKey,
            child: Center(
              child: Column(
                children: <Widget> [
                  Padding (
                    padding: EdgeInsets.all(20),
                    child: TextFormField (
                      decoration: const InputDecoration(
                        hintText: 'Inserisci nome utente',
                      ),
                      onChanged: (value) {
                        input = value;
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: 300,
                    child: TextButton (
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          search(input).then((value) {
                            if (value == '"false"' || value == null) {
                              setState(() {
                                result = 'Nessun utente trovato :(';
                                data = null;
                              });
                            } else {
                              setState(() {
                                data = value;
                                result = '';
                              });
                            }
                          });
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(HexColor("#00ABDE")),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row (
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Cerca', style: TextStyle(color: Colors.white)),
                            Icon(Icons.search, color: Colors.white),
                          ]
                        ),
                      )
                    ),
                  ),
                  SizedBox(height:20),
                  Text('$result'),
                  buildResult(data)
                ]
              ),
            )
          )
        ]
      )
    );
  }
}
