import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class mainWindow extends StatefulWidget {
  const mainWindow({Key? key}) : super(key: key);

  @override
  _mainWindowState createState() => _mainWindowState();
}

class _mainWindowState extends State<mainWindow> {
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
            Navigator.pushNamed(context, '/Camera');
          }, child: Text('Camera'))
        ],
      ),
    );
  }
}
