import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //semplice menu per scegliere i forum non c'e' niente da spiegare
    return Scaffold(
        appBar: AppBar(
        backgroundColor: HexColor("#00ABDE"),
        title: Text('Benvenuto a FerMe'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          child: Column (
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ListTile (
                onTap: () {
                  Navigator.pushNamed(context, '/chat', arguments:{'selection': 'informatica'});
                },
                title: new Center (child: Text('Informatica', style: TextStyle(fontSize: 25))),
                leading: Image.asset('assets/informatica.png', width: 35),
                contentPadding: const EdgeInsets.all(20),
                trailing: Image.asset('assets/arrow.png', width: 30),
                tileColor: Colors.grey[200],
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0), side: BorderSide(color: HexColor('#ebebeb'))),
              ),
              SizedBox(height:10),
              ListTile (
                onTap: () {
                  Navigator.pushNamed(context, '/chat', arguments:{'selection': 'cucina'});
                },
                title: new Center (child: Text('Cucina', style: TextStyle(fontSize: 25))),
                leading: Image.asset('assets/cucina.png', width: 35),
                contentPadding: const EdgeInsets.all(20),
                trailing: Image.asset('assets/arrow.png', width: 30),
                tileColor: Colors.grey[200],
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0), side: BorderSide(color: HexColor('#ebebeb'))),

              ),
              SizedBox(height:10),
              ListTile (
                onTap: () {
                  Navigator.pushNamed(context, '/chat', arguments:{'selection': 'sport'});
                },
                title: new Center (child: Text('Sport', style: TextStyle(fontSize: 25))),
                leading: Image.asset('assets/sport.png', width: 35),
                contentPadding: const EdgeInsets.all(20),
                trailing: Image.asset('assets/arrow.png', width: 30),
                tileColor: Colors.grey[200],
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0), side: BorderSide(color: HexColor('#ebebeb'))),
              ),
              SizedBox(height:10),
              ListTile (
                onTap: () {
                  Navigator.pushNamed(context, '/chat', arguments:{'selection': 'anime'});
                },
                title: new Center (child: Text('Anime', style: TextStyle(fontSize: 25))),
                leading: Image.asset('assets/anime.png', width: 35),
                contentPadding: const EdgeInsets.all(20),
                trailing: Image.asset('assets/arrow.png', width: 30),
                tileColor: Colors.grey[200],
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0), side: BorderSide(color: HexColor('#ebebeb'))),
              ),
              SizedBox(height:10),
              ListTile (
                onTap: () {
                  Navigator.pushNamed(context, '/chat', arguments:{'selection': 'arte'});
                },
                title: new Center (child: Text('Arte', style: TextStyle(fontSize: 25))),
                leading: Image.asset('assets/arte.png', width: 35),
                contentPadding: const EdgeInsets.all(20),
                trailing: Image.asset('assets/arrow.png', width: 30),
                tileColor: Colors.grey[200],
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0), side: BorderSide(color: HexColor('#ebebeb'))),
              ),
              SizedBox(height:10),
              ListTile (
                onTap: () {
                  Navigator.pushNamed(context, '/chat', arguments:{'selection': 'cinema'});
                },
                title: new Center (child: Text('Cinema', style: TextStyle(fontSize: 25))),
                leading: Image.asset('assets/cinema.png', width: 35),
                contentPadding: const EdgeInsets.all(20),
                trailing: Image.asset('assets/arrow.png', width: 30),
                tileColor: Colors.grey[200],
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0), side: BorderSide(color: HexColor('#ebebeb'))),
              ),
              SizedBox(height:10),
              ListTile (
                onTap: () {
                  Navigator.pushNamed(context, '/chat', arguments:{'selection': 'compiti'});
                },
                title: new Center (child: Text('Compiti', style: TextStyle(fontSize: 25))),
                leading: Image.asset('assets/compiti.png', width: 35),
                contentPadding: const EdgeInsets.all(20),
                trailing: Image.asset('assets/arrow.png', width: 30),
                tileColor: Colors.grey[200],
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0), side: BorderSide(color: HexColor('#ebebeb'))),
              ),
              SizedBox(height:10),
              ListTile (
                onTap: () {
                  Navigator.pushNamed(context, '/chat', arguments:{'selection': 'gaming'});
                },
                title: new Center (child: Text('Gaming', style: TextStyle(fontSize: 25))),
                leading: Image.asset('assets/gaming.png', width: 35),
                contentPadding: const EdgeInsets.all(20),
                trailing: Image.asset('assets/arrow.png', width: 30),
                tileColor: Colors.grey[200],
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0), side: BorderSide(color: HexColor('#ebebeb'))),
              ),
              SizedBox(height:10),
              ListTile (
                onTap: () {
                  Navigator.pushNamed(context, '/chat', arguments:{'selection': 'hobby'});
                },
                title: new Center (child: Text('Hobby', style: TextStyle(fontSize: 25))),
                leading: Image.asset('assets/hobby.png', width: 35),
                contentPadding: const EdgeInsets.all(20),
                trailing: Image.asset('assets/arrow.png', width: 30),
                tileColor: Colors.grey[200],
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0), side: BorderSide(color: HexColor('#ebebeb'))),
              ),
              SizedBox(height:10),
              ListTile (
                onTap: () {
                  Navigator.pushNamed(context, '/chat', arguments:{'selection': 'musica'});
                },
                title: new Center (child: Text('Musica', style: TextStyle(fontSize: 25))),
                leading: Image.asset('assets/musica.png', width: 35),
                contentPadding: const EdgeInsets.all(20),
                trailing: Image.asset('assets/arrow.png', width: 30),
                tileColor: Colors.grey[200],
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0), side: BorderSide(color: HexColor('#ebebeb'))),
              ),
              SizedBox(height:10),
              ListTile (
                onTap: () {
                  Navigator.pushNamed(context, '/chat', arguments:{'selection': 'altro'});
                },
                title: new Center (child: Text('Altro', style: TextStyle(fontSize: 25))),
                leading: Image.asset('assets/altro.png', width: 35),
                contentPadding: const EdgeInsets.all(20),
                trailing: Image.asset('assets/arrow.png', width: 30),
                tileColor: Colors.grey[200],
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0), side: BorderSide(color: HexColor('#ebebeb'))),
              ),
            ],
          )
        ),
      )
    );
  }
}
