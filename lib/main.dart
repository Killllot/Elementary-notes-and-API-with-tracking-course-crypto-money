import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:myNotes/authorizationOrLogin/login.dart';
import 'package:myNotes/pages/notes.dart';
import 'package:myNotes/pages/coin.dart';
import 'package:myNotes/pages/mainWindow.dart';
import 'package:myNotes/pages/Camera.dart';
import 'package:myNotes/services/auth.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(StreamProvider<User>.value  (
    value: AuthService().currentUser,
    child: MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.indigoAccent,
      ),
      initialRoute: '/',
      routes: {
        '/':(context)=>login(),
        '/Notes':(context)=>Notes(),
        '/Coin':(context)=>Coin(),
        '/login':(context)=>mainWindow(),
      },
    ),
  ));
}

