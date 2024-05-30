import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';

import 'notesdatabase.dart';

class addOrUpdateNotesDetails{

  TextEditingController notesNameController = new TextEditingController();
  TextEditingController notesDescriptionController = new TextEditingController();


  Future<void> getNotes(BuildContext context ,String addorupdate, [String? presentNotesName , String? presentDescription , String? presentId, String? notesContent]) {
    if(presentNotesName != null && presentDescription != null && presentId != null){
      notesNameController.text = presentNotesName;
      notesDescriptionController.text = presentDescription;
    }
    else{
      notesNameController.text = "";
      notesDescriptionController.text = "";
    }

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(addorupdate + " Notes"),
          actions: <Widget>[
            Column(
                children : [
                  TextField(
                    controller: notesNameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.teal)
                      ),
                      labelText: 'Notes name',
                      prefixIcon: Icon(Icons.menu_book),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: notesDescriptionController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.teal)
                      ),
                      labelText: 'Description',
                      prefixIcon: Icon(Icons.link),
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      textStyle: Theme.of(context).textTheme.labelLarge,
                    ),
                    child: Text(addorupdate),
                    onPressed: () async{
                      String id = randomAlphaNumeric(10);
                      if(addorupdate == "Add"){
                        Map<String , dynamic> coursedata= {
                          "Id" : id,
                          "notesName" : notesNameController.text,
                          "notesDescription" : notesDescriptionController.text,
                          "notesContent" : "",
                        };
                        // await DatabaseMethods().addCourse(coursedata , id);
                        Navigator.of(context).pop();
                      }
                      else{
                        Map<String , dynamic> coursedata= {
                          "Id" : presentId,
                          "notesName" : notesNameController.text,
                          "notesDescription" : notesDescriptionController.text,
                          "notesContent" : notesContent,
                        };
                        // await DatabaseMethods().updateNotesDetails(presentId!, coursedata);
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      }
                    },
                  ),
                ]

            ),
          ],
        );
      },
    );
  }
}