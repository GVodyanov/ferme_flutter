import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import '../../services/url.dart';
import '../../services/prefs.dart';

class ModEmail extends StatefulWidget {
  const ModEmail({Key? key}) : super(key: key);

  @override
  _ModEmailState createState() => _ModEmailState();
}

class _ModEmailState extends State<ModEmail> {

  Future<bool> modEmail (email, password) async {
    var urlPost = Uri.parse('${url}pages/modProfile.php');
    var response = await http.post(urlPost, body: {'modify': 'email', 'id' : '$gotInt', 'password': '$password', 'newEmail' : '$email'});
    if (response.body == '"true"') {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> emailExist (email) async {
    var urlPost = Uri.parse('${url}pages/emailExist.php');
    var response = await http.post(urlPost, body: {'email': '$email'});
    if (response.body == 'true') {
      return true;
    } else {
      return false;
    }
  }

  final _formKey = GlobalKey<FormState>();

  String? email;
  String? password;

  int? gotInt;
  _ModEmailState() {
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
        title: Text('Modifica Email'),
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
                          decoration: const InputDecoration(
                            hintText: 'Inserite la mail a cui volete cambiare',
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
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            if (await modEmail (email, password) == true) {
                              Navigator.pushReplacementNamed(context, '/profile');
                              await Future.delayed(const Duration(milliseconds: 200), (){});
                            } else if (await emailExist(email) == true) {
                              setState(() {
                                buttonText = 'Email già in utilizzo, riprovate';
                              });
                            } else {
                              setState(() {
                                buttonText = 'Credenziali sbagliate o email \nnon scolastico, riprovate';
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
