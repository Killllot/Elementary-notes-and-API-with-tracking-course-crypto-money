import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class Notes extends StatefulWidget {
  const Notes({Key? key}) : super(key: key);

  @override
  _NotesState createState() => _NotesState();
}

//---------------------------------------------------------------------------------
class _NotesState extends State<Notes> {
  late String _userData;
  List doList=[];


  void initFirebase() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }
  @override
  void initState() {
    super.initState();
    initFirebase();
    doList.addAll(['Buy potato','Refresh Spotify','Find an internship','123']);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Заметки'),
        centerTitle: true,
      ) ,
      body:   StreamBuilder(
          stream: FirebaseFirestore.instance.collection('data').snapshots(),
          builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> shapshot) {
            if (!shapshot.hasData) {
              return Text('Not data');
           }
           return ListView.builder(
               itemCount: shapshot.data!.docs.length,
               itemBuilder: (BuildContext context, int index) {
                 return Dismissible(
                   key: Key(shapshot.data!.docs[index].id),
                   child: Card(
                     child: ListTile(
                       title: Text(shapshot.data!.docs[index].get('data')),
                       tileColor: Color.fromARGB(20, 0, 0, 255),
                       trailing: IconButton(
                         icon: Icon(Icons.delete, color: Colors.blue,),
                         onPressed: () {
                           FirebaseFirestore.instance.collection('data')
                               .doc(shapshot.data!.docs[index].id)
                               .delete();
                         },
                       ),
                     ),
                   ),
                   onDismissed: (direction) {
                     //if(direction==DismissDirection.endToStart)

                   },
                 );
               });
         }
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(20, 0, 0, 255),
        onPressed: (){
          showDialog(context: context, builder: (BuildContext context){

            return AlertDialog(
              title: Text ('Add element'),
              content: TextField (
                onChanged: (String value){
                  _userData=value;
                },
              ),
              actions: [
                ElevatedButton(onPressed: (){
                  FirebaseFirestore.instance.collection('data').add({'data':_userData});
                  Navigator.of(context).pop();
                }, child: Text('Add',)
                )
              ],
            );
          });
        },
        child: Icon(Icons.add_box_outlined, color: Colors.grey,),
      ),
    );
  }
}
