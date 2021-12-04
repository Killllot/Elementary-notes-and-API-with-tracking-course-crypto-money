import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';


class mainWindow extends StatefulWidget {
  const mainWindow({Key? key}) : super(key: key);

  @override
  _mainWindowState createState() => _mainWindowState();
}

class _mainWindowState extends State<mainWindow> {
  void initFirebase() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }
  @override
  void initState() {
    super.initState();
    initFirebase();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text ('Windows'),
        centerTitle: true,
      ),
      body: Column(

        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ElevatedButton(onPressed: (){
            Navigator.pushNamed(context, '/Notes');
          }, child: Text ('Notes')),

          ElevatedButton(onPressed: (){
            Navigator.pushNamed(context, '/Coin');
          }, child: Text('Coin TOP')),
          ElevatedButton(onPressed: (){
            Navigator.pushNamed(context, '/login');
          }, child: Text('login'))
        ],
      ),
    );
  }
}
