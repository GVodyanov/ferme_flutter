import 'package:flutter/material.dart';
import 'pages/home.dart';
import 'pages/chat.dart';
import 'pages/signin.dart';
import 'pages/signup.dart';
import 'pages/message_write.dart';
import 'pages/message_edit.dart';
import 'pages/viewProfile.dart';
import 'pages/profile.dart';
import 'pages/netiquette.dart';
import 'pages/privacy.dart';
import 'pages/info.dart';
import 'pages/findUser.dart';
import 'pages/mod_profile/mod_picture.dart';
import 'pages/mod_profile/mod_email.dart';
import 'pages/mod_profile/mod_desc.dart';
import 'pages/mod_profile/mod_password.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart';
import 'services/url.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter/foundation.dart' show TargetPlatform;

void main(context) async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MaterialApp(

    //qui ci sono i route per la navigazione e basta praticamente
    initialRoute: '/home',
    routes: {
      '/home': (context) => Home(),
      '/chat': (context) => Chat(),
      '/write': (context) => Write(),
      '/msgedit': (context) => MsgEdit(),
      '/viewprofile': (context) => ViewProfile(),
      '/signin': (context) => Signin(),
      '/finduser': (context) => FindUser(),
      '/profile': (context) => Profile(),
      '/modpicture': (context) => ModPicture(),
      '/modemail': (context) => ModEmail(),
      '/moddesc': (context) => ModDesc(),
      '/modpassword': (context) => ModPassword(),
      '/privacy': (context) => Privacy(),
      '/signup': (context) => Signup(),
      '/netiquette': (context) => Netiquette(),
      '/info': (context) => Info(),
    },
  ));
  var platform = Theme.of(context).platform;
  // if (platform == TargetPlatform.iOS || platform == TargetPlatform.android) FlutterBackgroundService.initialize(shouldNotify());
}

/// TODO NOTIFICAZIONI NON FUNZIONANO BENE, PER QUESTO LA PARTE SEGUENTE E' COMMENTATA, SE RIUSCITE A FARLO FUNZIONARE VI RINGRAZIO

//
// showNotification (title) async{
//   FlutterLocalNotificationsPlugin localNotification;
//
//   var androidInitialize = new AndroidInitializationSettings('launcher_icon');
//   var iOSInitialize = new IOSInitializationSettings();
//
//   var initializationSettings = new InitializationSettings(android: androidInitialize, iOS: iOSInitialize);
//   localNotification = new FlutterLocalNotificationsPlugin();
//   localNotification.initialize(initializationSettings);
//
//   var androidDetails = new AndroidNotificationDetails("channelId", "Local Notification", "desc", importance: Importance.high);
//   var iOSDetails = new IOSNotificationDetails();
//   var generalNotificationDetails = new NotificationDetails(android: androidDetails, iOS : iOSDetails);
//
//   localNotification.show(1, title, null, generalNotificationDetails);
// }

//TODO max not

// shouldNotify () async {
//   // WidgetsFlutterBinding.ensureInitialized();
//   // final service = FlutterBackgroundService();
//   // service.setForegroundMode(false);
//   while (true) {
//     List forums = [
//       'informatica',
//       'cucina',
//       'sport',
//       'anime',
//       'arte',
//       'cinema',
//       'compiti',
//       'gaming',
//       'hobby',
//       'musica',
//       'altro'
//     ];
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String newForum = 'null';
//     for (var i in forums) {
//       Response response = await get(
//           Uri.parse('${url}pages/loadChat.php?selection=$i'));
//       String result = response.body;
//       String? current = prefs.getString('$i');
//
//       if (current == null || current == 'null') {
//         await prefs.setString('$i', result);
//       }
//       if (result != current && current != null && current != 'null' && result.length > current.length) {
//         await prefs.setString('$i', result);
//         newForum = 'C\'è un nuovo messaggio in $i';
//         break;
//       }
//     }
//     if (newForum != 'null') {
//       showNotification(newForum);
//     }
//     Future.delayed(Duration(minutes: 5), () {
//     });
//   }
}
