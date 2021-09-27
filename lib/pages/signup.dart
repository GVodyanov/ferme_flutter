import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import '../services/prefs.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import '../services/url.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {

  final _formKey = GlobalKey<FormState>();

  String? email;
  String? password;
  String? username;
  String? passwordConf;
  bool? isLogged = false;

  Future<bool?> signup (username, email, password, passwordConf) async {

    var urlPost = Uri.parse('${url}pages/signup.php');
    var response = await http.post(urlPost, body: {'email': '$email', 'password': '$password', 'username' : '$username', 'passwordConf' : '$passwordConf'});
    String? id = response.body;

    if (id != '"false"') {

      id = id.substring(1, id.length - 1);

      setId(int.parse(id));

      var bytes = utf8.encode(password);
      var digest = sha256.convert(bytes);

      setPassword('$digest');

      return true;
    } else {
      return false;
    }
  }

  String buttonText = 'Invia';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: (Container()),
          backgroundColor: HexColor("#00ABDE"),
          title: Text('Registrati'),
          centerTitle: true,
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
                          decoration: const InputDecoration(
                            hintText: 'Nome utente',
                          ),
                          onChanged: (value) {
                            username = value;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(50, 0, 50, 50),
                        child: TextFormField (
                          decoration: const InputDecoration(
                            hintText: 'Mail istituzionale',
                          ),
                          onChanged: (value) {
                            email = value;
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
                            hintText: 'Password',
                          ),
                          onChanged: (value) {
                            password = value;
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
                            hintText: 'Conferma Password',
                          ),
                          onChanged: (value) {
                            passwordConf = value;
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
                            signup(username, email, password, passwordConf).then((value) {
                              isLogged = value;
                              if (isLogged == true) {
                                Navigator.pushReplacementNamed(context, '/home');
                              } else if (username.toString().length < 4) {
                                setState(() {
                                  buttonText = 'Username deve avere come minimo\n 4 caratteri, riprovate';
                                });
                              } else if (username.toString().length > 25) {
                                setState(() {
                                  buttonText = 'Username può avere al massimo\n 25 caratteri, riprovate';
                                });
                              } else if (email.toString().length < 4) {
                                setState(() {
                                  buttonText = 'Inserite un email valido, riprovate';
                                });
                              } else if (email.toString().length > 70) {
                                setState(() {
                                  buttonText = 'Email può avere al massimo\n 70 caratteri, riprovate';
                                });
                              } else if (email.toString().contains('liceofermipadova') == false) {
                                setState(() {
                                  buttonText = 'Email deve essere istituzionale,\n riprovate';
                                });
                              } else if (password.toString().length < 6) {
                                setState(() {
                                  buttonText = 'Per favore scegliete un password più sicuro\n (min 6 caratteri), riprovate';
                                });
                              } else if (password.toString().length > 70) {
                                setState(() {
                                  buttonText = 'Password può avere al massimo\n 70 caratteri, riprovate';
                                });
                              } else if (password != passwordConf) {
                                setState(() {
                                  buttonText = 'Il password di conferma è sbagliato,\n riprovate';
                                });
                              } else {
                                setState(() {
                                  buttonText = 'Email già in uso o connessione fallita, riprovate';
                                });
                              }
                            });
                          }
                        },
                        child: Text(buttonText),
                      ),
                    ],
                  )
              ),
              SizedBox(height:50),
              TextButton (
                child: Text(
                    'Avete già un account? Accedete qui',
                    style: TextStyle (
                      color: Colors.grey[600],
                    )
                ),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/signin');
                },

              )
            ],
          ),
        )
    );
  }
}