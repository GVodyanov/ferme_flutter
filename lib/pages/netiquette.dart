import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hexcolor/hexcolor.dart';

class Netiquette extends StatelessWidget {
  const Netiquette({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar (
        title: Text('Netiquette'),
        centerTitle: true,
        backgroundColor: HexColor("#00ABDE"),
      ),
      body: Padding (
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column (
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Vi preghiamo di aderire a queste piccole regole quando usate FerMe, per creare un\'esperienza migliore per tutti', style: TextStyle(color: Colors.black54, fontSize: 17)),
              SizedBox(height: 30),
              Text('1. Sii rispettoso', style: TextStyle(color: Colors.black, fontSize: 20)),
              SizedBox(height: 30),
              Text('2. Esprimiti al meglio', style: TextStyle(color: Colors.black, fontSize: 20)),
              SizedBox(height: 30),
              Text('3. Se sei moderatore, non abusare dei propri poteri', style: TextStyle(color: Colors.black, fontSize: 20)),
              SizedBox(height: 30),
              Text('4. No info private', style: TextStyle(color: Colors.black, fontSize: 20)),
              SizedBox(height: 30),
              Text('5. Rispetta la privacy degli altri', style: TextStyle(color: Colors.black, fontSize: 20)),
              SizedBox(height: 30),
              Text('6. No spam', style: TextStyle(color: Colors.black, fontSize: 20)),
              SizedBox(height: 30),
              Text('7. No contenuti illeciti', style: TextStyle(color: Colors.black, fontSize: 20)),
              SizedBox(height: 30),
              Text('8. No contenuti volgari', style: TextStyle(color: Colors.black, fontSize: 20)),
            ]
          ),

        )
      )
    );
  }
}
