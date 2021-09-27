import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hexcolor/hexcolor.dart';
import '../services/prefs.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  void menuActions (action, context) {
    if (action == 3) Navigator.pushNamed(context, '/privacy');
    if (action == 4) Navigator.pushNamed(context, '/netiquette');
    if (action == 5) Navigator.pushNamed(context, '/info');
    if (action == 0) {
      if (gotInt != null) {
        Navigator.pushNamed(context, '/profile');
      } else {
        Alert(
          context: context,
          type: AlertType.warning,
          title: "Prima di visualizzare il vostro profilo dovete accedere con un account",
          style: AlertStyle (
            animationType: AnimationType.fromTop,
          ),
          buttons: [
            DialogButton(
              child: Text(
                "Chiudi",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () => Navigator.pop(context),
              color: HexColor("#00ABDE"),
            ),
            DialogButton(
              child: Text(
                "Accedi",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/signin');
              },
              gradient: LinearGradient(colors: [
                HexColor('#00ff7f'),
                HexColor('#00d868'),
              ]),
            )
          ],
        ).show();
      }
    }
    if (action == 1) {
      if (gotInt != null) {
        Navigator.pushNamed(context, '/finduser');
      } else {
        Alert(
          context: context,
          type: AlertType.warning,
          title: "Prima di cercare utenti dovete accedere con un account",
          style: AlertStyle (
            animationType: AnimationType.fromTop,
          ),
          buttons: [
            DialogButton(
              child: Text(
                "Chiudi",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () => Navigator.pop(context),
              color: HexColor("#00ABDE"),
            ),
            DialogButton(
              child: Text(
                "Accedi",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/signin');
              },
              gradient: LinearGradient(colors: [
                HexColor('#00ff7f'),
                HexColor('#00d868'),
              ]),
            )
          ],
        ).show();
      }
    }
    if (action == 2) {
      if (gotInt != null) {
        deleteId();
        setState(() {
          gotInt = null;
        });
      } else {
        Alert(
          context: context,
          type: AlertType.warning,
          title: "Prima dovete accedere con il vostro account",
          style: AlertStyle (
            animationType: AnimationType.fromTop,
          ),
          buttons: [
            DialogButton(
              child: Text(
                "Chiudi",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () => Navigator.pop(context),
              color: HexColor("#00ABDE"),
            ),
            DialogButton(
              child: Text(
                "Accedi",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/signin');
              },
              gradient: LinearGradient(colors: [
                HexColor('#00ff7f'),
                HexColor('#00d868'),
              ]),
            )
          ],
        ).show();
      }
    }
  }

  int? gotInt;
  String? gotPassword;
  _HomeState() {
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

    //semplice menu per scegliere i forum non c'e' niente da spiegare
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor("#00ABDE"),
        title: Text('Benvenuto a FerMe'),
        centerTitle: true,
        leading: PopupMenuButton(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Icon(
              Icons.menu,
            ),
          ),
          onSelected: (item) => menuActions(item, context),
          itemBuilder: (context) => [
            PopupMenuItem(
              child: Row (
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Profilo'),
                  Icon(Icons.person, color: Colors.black),
                ]
              ),
              value: 0
            ),
            PopupMenuItem(
              child: Row (
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Cerca utente'),
                  Icon(Icons.person_search, color: Colors.black),
                ]
              ),
              value: 1
            ),
            PopupMenuItem(
                child: Row (
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Privacy Policy'),
                      Icon(Icons.lock, color: Colors.black),
                    ]
                ),
                value: 3,
            ),
            PopupMenuItem(
              child: Row (
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Netiquette'),
                    Icon(Icons.fact_check, color: Colors.black),
                  ]
              ),
              value: 4,
            ),
            PopupMenuItem(
              child: Row (
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Info'),
                    Icon(Icons.info, color: Colors.black),
                  ]
              ),
              value: 5,
            ),
            PopupMenuItem(
              child: Row (
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Esci'),
                  Icon(Icons.logout, color: Colors.black),
                ]
              ),
              value: 2
            )
          ]
        ),
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
