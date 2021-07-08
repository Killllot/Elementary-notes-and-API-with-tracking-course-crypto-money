import 'package:flutter/material.dart';

class Notes extends StatefulWidget {
  const Notes({Key? key}) : super(key: key);

  @override
  _NotesState createState() => _NotesState();
}

//---------------------------------------------------------------------------------
class _NotesState extends State<Notes> {
  late String _userToDo;
  List doList=[];
  @override
  void initState() {
    super.initState();

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
      body: ListView.builder(
          itemCount: doList.length,
          itemBuilder: (BuildContext context, int index ){
            return Dismissible(
              key: Key(doList[index]),
              child: Card(
                child: ListTile(
                  title: Text(doList[index] ),
                  trailing: IconButton (
                    icon: Icon(Icons.delete, color: Colors.indigoAccent,),
                    onPressed: () {
                      setState(() {
                        doList.removeAt(index);
                      });
                    },
                  ),
                ),
              ),
              onDismissed: (direction){
                //if(direction==DismissDirection.endToStart)
                setState(() {
                  doList.removeAt(index);
                });
              },
            );
          }),
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
                  setState((){
                    doList.add(_userToDo);
                  });
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
