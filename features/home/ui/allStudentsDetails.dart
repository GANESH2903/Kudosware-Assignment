import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task3/features/home/ui/detailsScreen.dart';
import 'package:task3/features/home/ui/notesScreen.dart';
import 'package:task3/features/home/ui/popOver.dart';
import '../../../data/notesdatabase.dart';

class AllStudentsDetails extends StatefulWidget {
  const AllStudentsDetails({super.key});

  @override
  State<AllStudentsDetails> createState() => _AllStudentsDetailsState();
}

class _AllStudentsDetailsState extends State<AllStudentsDetails> {

  Stream? NotesStream;

  getOnLoad() async{
    NotesStream = await DatabaseMethods().getStudentDetails();
    setState(() {

    });
  }
  @override
  void initState(){
    getOnLoad();
    super.initState();
  }
  @override
  Widget build(BuildContext context){
    return Expanded(
      child: StreamBuilder(
          stream: NotesStream,
          builder: (context , AsyncSnapshot snapshot){
            return snapshot.hasData
                ? ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context , index){
                  DocumentSnapshot ds = snapshot.data.docs[index];
                  return Container(
                    padding: EdgeInsets.only(left: 5 , right: 5),
                    margin: EdgeInsets.only(bottom: 10),
                    child: Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width*0.8,
                        decoration: BoxDecoration(color: Colors.white , borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: MediaQuery.sizeOf(context).width*0.45,
                                  child:Text("\"" + ds["studentName"]+"\"", style: TextStyle(color: Colors.orange , fontSize: 25,overflow: TextOverflow.ellipsis,)),
                                ),
                                Spacer(),
                                Text("" + ds["studentUsn"], style: TextStyle(color: Colors.black , fontSize: 15, overflow: TextOverflow.clip)),
                                // PopOver(index),
                              ],
                            ),
                            Divider(
                              color: Colors.black12,
                            ),
                            GestureDetector(
                                  onTap: () {
                                    // Navigator.push(context , MaterialPageRoute(builder: (context) => NotesScreen(ds["notesName"], ds["notesContent"] , ds["Id"])));
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => detailsScreen(ds)));
                                  },
                                  child: Container(
                                    padding: EdgeInsets.only(left: 105, top: 2.5),
                                      width: MediaQuery.of(context).size.width,
                                      height: MediaQuery.of(context).size.height * 0.04,
                                      color: Color.fromRGBO(227, 227, 227, 0.4),
                                      child: Text("View Details" , style: TextStyle(fontWeight: FontWeight.bold , fontSize: 18),),),
                                ),
                          ],
                        ),
                      ),
                    ),
                  );
                } )
                : Container();
          }),
    );
  }
}
