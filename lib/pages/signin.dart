import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import '../services/prefs.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import '../services/url.dart';

class Signin extends StatefulWidget {
  const Signin({Key? key}) : super(key: key);

  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {

  final _formKey = GlobalKey<FormState>();

  String? email;
  String? password;
  bool? isLogged = false;

  Future<bool?> signin (email, password) async {

    var urlPost = Uri.parse('${url}pages/signin.php');
    var response = await http.post(urlPost, body: {'email': email, 'password': password});
    String? id = response.body;

    if (id != 'null') {

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
        title: Text('Accedi'),
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
                        hintText: 'Inserite la vostra mail',
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
                        hintText: 'Inserite la vostra password',
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
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        signin(email, password).then((value) {
                          isLogged = value;
                          if (isLogged == true) {
                            Navigator.pushReplacementNamed(context, '/home');
                          } else {
                            setState(() {
                              buttonText = 'Email o Password sbagliati, Riprova';
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
            SizedBox(height:100),
            TextButton (
              child: Text(
                'Non avete un account? Registratevi qui',
                style: TextStyle (
                  color: Colors.grey[600],
                )
              ),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/signup');
              },

            )
          ],
        ),
      )
    );
  }
}

