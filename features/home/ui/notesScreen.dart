import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task3/data/notesdatabase.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen(this.NotesName ,this.presentNotesContent, this.userPresentCollectionId);
  final String NotesName;
  final String presentNotesContent;
  final String userPresentCollectionId;
  @override
  State<NotesScreen> createState() => _NotesScreenState(NotesName, presentNotesContent,userPresentCollectionId);
}

class _NotesScreenState extends State<NotesScreen> {
  _NotesScreenState(this.notesName, this.presentNotesContent , this.userPresentCollectionId);
  final String notesName;
  final String presentNotesContent;
  final String userPresentCollectionId;
  TextEditingController notesContent = TextEditingController();
  @override
  void initState(){
    notesContent.text = presentNotesContent;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(notesName),
        backgroundColor: Color.fromARGB(255, 215, 247, 245),
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                TextField(
                  controller: notesContent,
                  minLines: 1,
                  maxLines: (MediaQuery.sizeOf(context).height*0.0255).toInt(),
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(border: OutlineInputBorder()),
                ),
                SizedBox(height: 6,),
                SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.5,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Color.fromARGB(255, 215, 247, 245)),
                      ),
                      onPressed: () {
                        // DatabaseMethods().addNotesContent(notesContent.text.toString(),userPresentCollectionId);
                      },
                      child: Text(
                        'Save',
                        style: TextStyle(color: Colors.black),
                      ),
                    )),
              ],
            ),
          ),
        ),
      )
    );
  }
}
