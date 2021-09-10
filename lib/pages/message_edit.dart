import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import '../services/prefs.dart';
import '../services/url.dart';

class MsgEdit extends StatefulWidget {
  const MsgEdit({Key? key}) : super(key: key);

  @override
  _MsgEditState createState() => _MsgEditState();
}

class _MsgEditState extends State<MsgEdit> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController? _editingController;
  String initialText = "";

  String? newText;

  void edit (String selection, String messageId) async {
    int? gotInt = await getId();
    String? gotPassword = await getPassword();

    var urlPost = Uri.parse('${url}pages/messageActions.php');
    var response = await http.post(urlPost, body: {'action': 'modify', 'id': '$gotInt', 'newMessage' : newText, 'selection': selection, 'messageId' : messageId, 'password' : '$gotPassword'});
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    Map data = {};
    data = data.isNotEmpty ? data : ModalRoute.of(context)!.settings.arguments as Map;
    String initialText = data['message'];
    String selection = data['selection'];
    String messageId = data['messageId'];
    _editingController = TextEditingController(text: initialText);
    newText = initialText;
    return Scaffold(
      appBar: AppBar(
        title: Text('Modifica Messaggio'),
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
            edit(selection, messageId);
          }
        },
        backgroundColor: HexColor("#00ABDE"),
        child: Icon(Icons.check),
      )
    );
  }
}
