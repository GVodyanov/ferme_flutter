import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import '../../services/url.dart';
import '../../services/prefs.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

class ModPassword extends StatefulWidget {
  const ModPassword({Key? key}) : super(key: key);

  @override
  _ModPasswordState createState() => _ModPasswordState();
}

class _ModPasswordState extends State<ModPassword> {

  Future<bool> modPassword (password, newPassword, newPasswordConf) async {
    var urlPost = Uri.parse('${url}pages/modProfile.php');
    var response = await http.post(urlPost, body: {'modify': 'password', 'id' : '$gotInt', 'password': '$password', 'newPassword' : '$newPassword', 'newPasswordConf' : '$newPasswordConf'});
    if (response.body == '"true"') {
      return true;
    } else {
      return false;
    }
  }

  final _formKey = GlobalKey<FormState>();

  String? newPassword;
  String? newPasswordConf;
  String? password;

  int? gotInt;
  _ModPasswordState() {
    getId().then((val) =>
        setState(() {
          if (val != null) {
            gotInt = val;
          }
        }));
  }

  String buttonText = 'Invia';

  @override
  Widget build(BuildContext context) {
    return Scaffold (
        appBar: AppBar (
            title: Text('Modifica Password'),
            centerTitle: true,
            backgroundColor: HexColor("#00ABDE"),
            leading: TextButton (
              child: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/profile');
              },
            )
        ),
        body: Center(
          child: Column (
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(50, 0, 50, 50),
                        child: TextFormField (
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
                          decoration: const InputDecoration(
                            hintText: 'Inserite la password a cui volete cambiare',
                          ),
                          onChanged: (value) {
                            newPassword = value;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(50, 0, 50, 50),
                        child: TextFormField (
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
                          decoration: const InputDecoration(
                            hintText: 'Confermate la nuova password',
                          ),
                          onChanged: (value) {
                            newPasswordConf = value;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(50, 0, 50, 50),
                        child: TextFormField (
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
                          decoration: const InputDecoration(
                            hintText: 'Inserite la vostra password corrente',
                          ),
                          onChanged: (value) {
                            password = value;
                          },
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
                            primary: HexColor('#00ABDE')
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            if (await modPassword (password, newPassword, newPasswordConf) == true) {
                              var bytes = utf8.encode(newPassword.toString());
                              var digest = sha256.convert(bytes);
                              setPassword('$digest');
                              Navigator.pushReplacementNamed(context, '/profile');
                              await Future.delayed(const Duration(milliseconds: 200), (){});
                            } else if (newPassword != newPasswordConf) {
                              setState(() {
                                buttonText = 'Il password di conferma è sbagliato,\n riprovate';
                              });
                            } else if (newPassword.toString().length < 6) {
                              setState(() {
                                buttonText = 'Il password è deve essere almeno\n di 6 caratteri,riprovate';
                              });
                            } else if (newPassword.toString().length > 70) {
                              setState(() {
                                buttonText = 'Il password è troppo lungo, riprovate';
                              });
                            } else {
                              setState(() {
                                buttonText = 'Credenziali sbagliate, riprovate';
                              });
                            }
                          }
                        },
                        child: Text(buttonText),
                      ),
                      SizedBox(height: 200)
                    ],
                  )
              )
            ],
          ),
        )
    );
  }
}
