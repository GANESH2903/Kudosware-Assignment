import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popover/popover.dart';
import 'package:task3/data/addOrUpdateNotesDetails.dart';
import 'package:task3/features/home/bloc/home_bloc.dart';
import '../../../data/notesdatabase.dart';

class PopOver extends StatefulWidget {
  PopOver(this.index);
  int index;
  @override
  State<PopOver> createState() => _PopOverState(index);
}

class _PopOverState extends State<PopOver> {
  _PopOverState(this.index);
  int index;
  Stream? NotesStream;

  getOnLoad() async{
    // NotesStream = await DatabaseMethods().getNotesDetails();
    setState(() {

    });
  }
  @override
  void initState(){
    getOnLoad();
    super.initState();
  }
  addOrUpdateNotesDetails updateData = new addOrUpdateNotesDetails();
  final HomeBloc homeBloc = HomeBloc();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is! HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        if(state is HomeEditNotesSuccessState){
          print("edit success");
        }
        else if(state is HomeDeleteNotesSuccessState){
          print("delete success");
        }
      },
      builder: (context, state) {
        return StreamBuilder(
            stream: NotesStream,
            builder: (context, AsyncSnapshot snapshot) {
              DocumentSnapshot ds = snapshot.data.docs[index];
              return snapshot.hasData
                  ? Builder(builder: (context) {
                      return IconButton(
                          onPressed: () => showPopover(
                              height: 100,
                              width: 100,
                              context: context,
                              bodyBuilder: (context) => Container(
                                    child: Column(
                                      children: [
                                        GestureDetector(
                                            onTap: () {
                                              homeBloc.add(HomePopOverEditNotesDetailsButtonClickedEvent());
                                              updateData.getNotes(
                                                  context,
                                                  "Update",
                                                  ds["notesName"],
                                                  ds["notesDescription"],
                                                  ds["Id"],
                                                  ds["notesContent"]);
                                            },
                                            child: Container(
                                              padding: EdgeInsets.only(
                                                  left: 5, right: 5),
                                              height: 50,
                                              child: Row(
                                                children: [
                                                  Icon(Icons.edit),
                                                  Text(
                                                    " Edit",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            )),
                                        GestureDetector(
                                            onTap: () {
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      title: Text(
                                                          "Are you sure you want to delete this notes"),
                                                      actions: [
                                                        TextButton(
                                                            child: Text("No"),
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            }),
                                                        TextButton(
                                                            child: Text("yes"),
                                                            onPressed: () {
                                                              homeBloc.add(HomePopOverDeleteNotesButtonClickedEvent());
                                                              // DatabaseMethods().deleteNotes(ds["Id"]);
                                                              Navigator.of(context).pop();
                                                              Navigator.of(context).pop();
                                                            }),
                                                      ],
                                                    );
                                                  });
                                            },
                                            child: Container(
                                              padding: EdgeInsets.only(
                                                  left: 5, right: 5),
                                              height: 50,
                                              child: Row(
                                                children: [
                                                  Icon(Icons.delete),
                                                  Text(
                                                    " Delete",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            )),
                                      ],
                                    ),
                                  )),
                          icon: Icon(Icons.more_vert));
                    })
                  : Column();
            });
      },
);
  }
}
