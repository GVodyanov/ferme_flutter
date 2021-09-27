import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import '../../services/url.dart';
import '../../services/prefs.dart';

class ModPicture extends StatefulWidget {
  const ModPicture({Key? key}) : super(key: key);

  @override
  _ModPictureState createState() => _ModPictureState();
}

class _ModPictureState extends State<ModPicture> {

  Color? selectedColor = Colors.grey[100];
  int selected = 0;

  Color? setColor (i) {
    if (i == selected) {
      return Colors.greenAccent;
    } else {
      return Colors.grey[100];
    }
  }

  void setPicture (selected, id, password) async {
    var urlPost = Uri.parse('${url}pages/modProfile.php');
    var response = await http.post(urlPost, body: {'modify': 'picture', 'id' : '$id', 'password': '$password', 'newPicture' : '$selected'});
    if (response.body == '"true"') {
      Navigator.pushReplacementNamed(context, '/profile');
    }
  }

  int? gotInt;
  String? gotPassword;
  _ModPictureState() {
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

    List pictures = [1,2,3,4,5,6,7,8];

    return Scaffold (
      appBar: AppBar (
        title: Text('Modifica Foto Profilo'),
        centerTitle: true,
        backgroundColor: HexColor("#00ABDE"),
        leading: TextButton (
          child: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/profile');
          },
        )
      ),
      body: ListView(
        children: [Padding (
          padding: EdgeInsets.all(30),
          child: Column (
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              for (var i in pictures) Column (
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        selected = i;
                      });
                    },
                    child: Image.asset('assets/pictures/im$i.png', width: 150),
                    style: ButtonStyle (
                      backgroundColor: MaterialStateProperty.all(setColor(i))
                    )
                  ),
                  SizedBox(height: 20)
                ],
              )
            ],
          )
        ),]
      ),
      floatingActionButton: FloatingActionButton (
        onPressed: () {
          setPicture(selected, gotInt, gotPassword);
        },
        backgroundColor: HexColor("#00ABDE"),
        child: Icon(Icons.check),
      ),
    );
  }
}
