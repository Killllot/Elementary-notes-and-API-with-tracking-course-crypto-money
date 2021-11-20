import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class Notes extends StatefulWidget {
  const Notes({Key? key}) : super(key: key);

  @override
  _NotesState createState() => _NotesState();
}

//---------------------------------------------------------------------------------
class _NotesState extends State<Notes> {
  late String _userToDo;
  List doList=[];

  void initFireBase() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();

  }

  @override
  void initState() {
    super.initState();

    initFireBase();

    doList.addAll(['Buy potato','Refresh Spotify','Find an internship']);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text('Заметки'),
        centerTitle: true,
      ) ,
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('data').snapshots(),
          builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> shapshot) {
            if(!shapshot.hasData){
              return Text('Not data');
            }
            return ListView.builder(
                itemCount: shapshot.data!.docs.length,
                itemBuilder: (BuildContext context, int index ){
                  return Dismissible(
                    key: Key(shapshot.data!.docs[index].id),
                    child: Card(
                      child: ListTile(
                        title: Text(shapshot.data!.docs[index].get('data') ),
                        trailing: IconButton (
                          icon: Icon(Icons.delete, color: Colors.indigoAccent,),
                          onPressed: () {
                            FirebaseFirestore.instance.collection('data').doc(shapshot.data!.docs[index].id).delete();
                          },
                        ),
                      ),
                    ),
                    onDismissed: (direction){
                      //if(direction==DismissDirection.endToStart)
                      FirebaseFirestore.instance.collection('data').doc(shapshot.data!.docs[index].id).delete();
                    },
                  );
                });
          }
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigoAccent,
        onPressed: (){
          showDialog(context: context, builder: (BuildContext context){

            return AlertDialog(
              title: Text ('Add element'),
              content: TextField (
                onChanged: (String value){
                  _userToDo=value;
                },
              ),
              actions: [
                ElevatedButton(onPressed: (){
                  FirebaseFirestore.instance.collection('data').add({'data':_userToDo});
                  
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
