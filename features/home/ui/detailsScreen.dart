import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../data/notesdatabase.dart';

class detailsScreen extends StatefulWidget {
  const detailsScreen(this.ds);
  final DocumentSnapshot ds;

  @override
  State<detailsScreen> createState() => _detailsScreenState(ds);
}

class _detailsScreenState extends State<detailsScreen> {
  _detailsScreenState(this.ds);
  final DocumentSnapshot ds;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 215, 247, 245),
        title: Text("Student Details"),
      ),
      body: ListView(children: [
        buildBackground(),
        getStudentFullDetails(),
      ]),

    );
  }
  Widget buildBackground() {
    return Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          coverImage(),
          Positioned(
              top: MediaQuery.sizeOf(context).height*0.25 - MediaQuery.sizeOf(context).width*0.2,
              child: profileImage()
          ),
        ]
    );
  }
  Widget getStudentFullDetails(){
    return Container(
      padding: EdgeInsets.only(top: MediaQuery.sizeOf(context).height*0.09,),
      child: Column(
        children: [
          Padding(padding: EdgeInsets.only(left: 20,right: 20,),
            child: Center(
              child: Text(ds["studentName"] , style: TextStyle(fontSize: 30,fontWeight: FontWeight.w600,),),
            ),
          ),
          Center(
            child: Text("Id : " + ds["studentUsn"] , style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600, color: Colors.grey.shade400 )),
          ),
          SizedBox(height: MediaQuery.sizeOf(context).width*0.04,),
          Row(
            children: [
              Spacer(),
              Text("DOB : " + ds["studentDOB"] , style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600, color: Colors.grey.shade600 )),
              Spacer(),
              Text("Gender : " + ds["studentGender"] , style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600, color: Colors.grey.shade600 )),
              Spacer(),
            ],
          ),
          SizedBox(height: MediaQuery.sizeOf(context).height*0.35,),
          MaterialButton(
            onPressed: () async{
                await DatabaseMethods().deleteStudentDetails(ds["Id"]);
                Navigator.pop(context);
            },
            child: CircleAvatar(
              backgroundColor: Colors.redAccent,
              radius: MediaQuery.sizeOf(context).width*0.07,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: MediaQuery.sizeOf(context).width*0.06,
                child: Icon(Icons.delete_sharp, color: Colors.redAccent, size: 30,),
              ),
            ),
          ),

        ],
      ),
    );
  }

  Widget coverImage() => Container(
    child: Image.network('https://t4.ftcdn.net/jpg/01/34/59/37/360_F_134593740_rqmU76hoksn2wYuU9uiah8CuUHpNjpVR.jpg' ,
      fit: BoxFit.cover,
      width: double.infinity,
      height: MediaQuery.sizeOf(context).height*0.25,
    ),
  );
  Widget profileImage() => CircleAvatar(
    radius: MediaQuery.sizeOf(context).width*0.2,
    backgroundColor: Colors.white,
    child: CircleAvatar(
      radius: MediaQuery.sizeOf(context).width*0.18,
      backgroundColor: Colors.grey.shade800,
      backgroundImage: NetworkImage(
          ds["studentGender"] == "Male" ? 'https://img.freepik.com/free-photo/3d-illustration-business-man-with-glasses-grey-background-clipping-path_1142-58140.jpg?size=338&ext=jpg&ga=GA1.1.2082370165.1716768000&semt=ais_user'
              :     'https://img.freepik.com/free-photo/business-woman-with-brown-hair-black-glasses-3d-rendering_1142-40235.jpg'
      ),
    ),
  );

}
