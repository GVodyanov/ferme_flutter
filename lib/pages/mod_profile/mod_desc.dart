import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import '../../services/prefs.dart';
import '../../services/url.dart';

class ModDesc extends StatefulWidget {
  const ModDesc({Key? key}) : super(key: key);

  @override
  _ModDescState createState() => _ModDescState();
}

class _ModDescState extends State<ModDesc> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController? _editingController;
  String initialText = "";

  String? newText;

  void edit (newText) async {
    int? gotInt = await getId();
    String? gotPassword = await getPassword();

    var urlPost = Uri.parse('${url}pages/modProfile.php');
    var response = await http.post(urlPost, body: {'modify': 'description', 'id': '$gotInt', 'password' : '$gotPassword', 'newDescription': '$newText'});
    Navigator.pushReplacementNamed(context, '/profile');
  }

  @override
  Widget build(BuildContext context) {
    Map data = {};
    data = data.isNotEmpty ? data : ModalRoute.of(context)!.settings.arguments as Map;
    String initialText = data['desc'];
    _editingController = TextEditingController(text: initialText);
    newText = initialText;
    return Scaffold(
        appBar: AppBar(
          title: Text('Modifica Descrizione'),
          centerTitle: true,
          backgroundColor: HexColor("#00ABDE"),
        ),
        body: Form(
          key: _formKey,
          child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    maxLength: 1024,
                    minLines: 5,
                    maxLines: 8,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Sfogatevi',
                    ),
                    onChanged: (newValue){
                      newText = newValue;
                    },
                    autofocus: true,
                    controller: _editingController,
                  ),
                ),
              ]
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              if (newText == '' || newText == null) newText = 'Utente di FerMe';
              edit(newText);
            }
          },
          backgroundColor: HexColor("#00ABDE"),
          child: Icon(Icons.check),
        )
    );
  }
}
