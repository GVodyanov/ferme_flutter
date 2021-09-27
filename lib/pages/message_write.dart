import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import '../services/prefs.dart';
import '../services/url.dart';

class Write extends StatefulWidget {
  const Write({Key? key}) : super(key: key);

  @override
  _WriteState createState() => _WriteState();
}

class _WriteState extends State<Write> {

  final _formKey = GlobalKey<FormState>();

  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  String? input;

  bool toBoolean(String str, [bool strict = false]) {
    if (strict == true) {
      return str == '1' || str == 'true';
    }
    return str != '0' && str != 'false' && str != '';
  }

  Future<bool?> write (input, selection) async {
    var urlPost = Uri.parse('${url}pages/messageWrite.php');
    int? id = await getId();
    String? password = await getPassword();

    var response = await http.post(urlPost, body: {'id': id.toString(), 'message': input, 'selection' : selection, 'password': password});
    String conf = response.body;

    conf = conf.substring(1, conf.length - 1);
    return toBoolean(conf, true);
  }

  @override
  Widget build(BuildContext context) {

    Map data = {};
    data = data.isNotEmpty ? data : ModalRoute.of(context)!.settings.arguments as Map;
    String selection = data['selection'];

    return Scaffold (
      appBar: AppBar(
        backgroundColor: HexColor("#00ABDE"),
        title: Text('Scrivete Messaggio'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            write(input, selection).then((value) {
              bool? conf = value;
              if (conf == true) {
                Navigator.pop(context);
              } else {

              }
            });
          }
        },
        backgroundColor: HexColor("#00ABDE"),
        child: Icon(Icons.check),
      ),
      body: Form (
        key: _formKey,
        child: Center(
          child: Column(
            children: <Widget> [
              Padding (
                padding: EdgeInsets.all(20),
                child: TextFormField (
                  maxLength: 1024,
                  minLines: 5,
                  maxLines: 8,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Sfogatevi',
                  ),
                  onChanged: (value) {
                    input = value;
                  },
                ),
              )
            ]
          ),
        )
      )
    );
  }
}
