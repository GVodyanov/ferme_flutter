import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class Info extends StatelessWidget {
  const Info({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold (
        appBar: AppBar (
          title: Text('Info'),
          centerTitle: true,
          backgroundColor: HexColor("#00ABDE"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(25.0),
          child: SingleChildScrollView(
            child: Center(
              child: Column (
                children: [
                  Text ('FerMe', style: TextStyle(color: Colors.black, fontSize: 36)),
                  SizedBox(height:20),
                  Text ('Versione 1.0', style: TextStyle(color: Colors.black54, fontSize: 20)),
                  SizedBox(height:20),
                  Text ('Licensa GPLv3', style: TextStyle(color: Colors.black54, fontSize: 20)),
                  SizedBox(height:20),
                  Text ('Software OPEN SOURCE:', style: TextStyle(color: Colors.black54, fontSize: 20)),
                  SizedBox(height:20),
                  Text ('Link codice sorgente front-end: https://github.com/FerMeLive/ferme_flutter',  textAlign: TextAlign.center, style: TextStyle(color: Colors.black54, fontSize: 20)),
                  SizedBox(height:20),
                  Text ('Link codice sorgente back-end: https://github.com/FerMeLive/ferme_api', textAlign: TextAlign.center, style: TextStyle(color: Colors.black54, fontSize: 20)),
                  SizedBox(height:20),
                  Text ('Sito principale: https://ferme.live', style: TextStyle(color: Colors.black54, fontSize: 20)),
                  SizedBox(height:20),
                  Text ('Tecnlogie che sono state usate in questo app: Dart (Flutter), PHP, MySQL, (forse eventualmente Rust)', textAlign: TextAlign.center, style: TextStyle(color: Colors.black54, fontSize: 20)),
                  SizedBox(height:20),
                  Text ('App scritto da Grigory Vodyanov', textAlign: TextAlign.center, style: TextStyle(color: Colors.black54, fontSize: 20)),
                ]
              )
            ),
          ),
        )
    );
  }
}
