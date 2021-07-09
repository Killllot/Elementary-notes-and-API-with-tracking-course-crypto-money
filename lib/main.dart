import 'package:flutter/material.dart';
import 'package:untitled/pages/notes.dart';
import 'package:untitled/pages/coin.dart';
import 'package:untitled/pages/mainWindow.dart';
import 'package:untitled/pages/Camera.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      primaryColor: Colors.indigoAccent,
    ),
    initialRoute: '/',
    routes: {
      '/':(context)=>mainWindow(),
      '/Notes':(context)=>Notes(),
      '/Coin':(context)=>Coin(),
      '/Camera':(context)=>myCamera(),
    },
  ));
}

