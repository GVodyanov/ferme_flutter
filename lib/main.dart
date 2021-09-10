import 'package:flutter/material.dart';
import 'pages/home.dart';
import 'pages/chat.dart';
import 'pages/signin.dart';
import 'pages/message_write.dart';
import 'pages/message_edit.dart';
import 'services/load_chat.dart';

void main() => runApp(MaterialApp(
  //qui ci sono i route per la navigazione e basta praticamente
  initialRoute: '/home',
  routes: {
    '/home': (context) => Home(),
    '/chat': (context) => Chat(),
    '/write': (context) => Write(),
    '/msgedit': (context) => MsgEdit(),
    '/signin': (context) => Signin(),
    '/load_chat': (context) => LoadChat(),
  },
));