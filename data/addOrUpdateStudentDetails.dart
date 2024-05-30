import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';
import 'package:another_flushbar/flushbar.dart';

import 'notesdatabase.dart';

class addOrUpdateStudentDetails extends StatefulWidget {
  const addOrUpdateStudentDetails({super.key});

  @override
  State<addOrUpdateStudentDetails> createState() => _addOrUpdateStudentDetailsState();
}

class _addOrUpdateStudentDetailsState extends State<addOrUpdateStudentDetails> {
  final studentName = new TextEditingController();
  final studentUsn = new TextEditingController();
  String dateOfBirth = "dd/mm/yyyy";
  String genderValue = "Male";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 215, 247, 245),
        title: Text("Registration Details"),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.only(top: 15),
        child: Center(
          child: Container(
            padding: EdgeInsets.only(left: 5 , right: 5),
            margin: EdgeInsets.only(bottom: 10),
            height: MediaQuery.sizeOf(context).height*0.86,
            width: MediaQuery.sizeOf(context).width*0.93,
            child: Material(
              elevation: 5.0,
              shadowColor: Colors.deepOrange,
              borderRadius: BorderRadius.circular(10),
              child: Padding(
                padding: EdgeInsets.only(left: 15 , top: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("  Student Name" , style: TextStyle(fontWeight: FontWeight.bold , fontSize: 20 ,),),
                    Card(
                      color: Color.fromARGB(255,233,236,255),
                      child: SizedBox(
                        height: 60,
                        width: MediaQuery.sizeOf(context).width*0.77,
                        child: Center(
                          child : TextFormField(
                            style: TextStyle(fontSize: 20),
                            controller: studentName,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(255,244,93,112)) , borderRadius: BorderRadius.circular(10)),
                              border: InputBorder.none
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Text("  USN No." , style: TextStyle(fontWeight: FontWeight.bold , fontSize: 20 ,),),
                    Card(
                      color: Color.fromARGB(255,233,236,255),
                      child: SizedBox(
                        height: 60,
                        width: MediaQuery.sizeOf(context).width*0.77,
                        child: Center(
                          child: TextFormField(
                            style: TextStyle(fontSize: 20),
                            controller: studentUsn,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(255,244,93,112)), borderRadius: BorderRadius.circular(10)),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Row(
                      children: [
                        Text("  Date of Birth" , style: TextStyle(fontWeight: FontWeight.bold , fontSize: 20 ,)),
                        MaterialButton(onPressed: _showDatePicker,
                          child: Row(
                            children: [
                              SizedBox(width: 15),
                              Text(dateOfBirth + "  "),
                              Icon(Icons.calendar_month),
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 20,),
                    Row(
                      children: [
                        Text("  Select Gender " , style: TextStyle(fontWeight: FontWeight.bold , fontSize: 20 ,),),
                        SizedBox(width: 20,),
                        DropdownButton<String>(
                          value: genderValue,
                          icon: Icon(Icons.arrow_drop_down_outlined),
                          onChanged: (String? newValue){
                            setState(() {
                              genderValue = newValue!;
                            });
                          },
                          items: [
                            DropdownMenuItem(
                                child: Text("Male"),
                              value: "Male",
                            ),
                            DropdownMenuItem(
                              child: Text("Female"),
                              value: "Female",
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 80),
                    Center(
                      child: SizedBox(
                        height: MediaQuery.sizeOf(context).height*0.06,
                        width: MediaQuery.sizeOf(context).width*0.4,
                        child: GestureDetector(
                          onTap: () async{
                            if(studentName.text.isEmpty){
                              Flushbar(
                                message: "Enter name",
                                duration: Duration(seconds: 3),
                              )..show(context);
                              return;
                            }
                            if(studentUsn.text.isEmpty){
                              Flushbar(
                                message: "Enter usn",
                                duration: Duration(seconds: 3),

                              )..show(context);
                              return;
                            }
                            if(dateOfBirth == "dd/mm/yyyy"){
                              Flushbar(
                                message: "Enter valid date",
                                duration: Duration(seconds: 3),
                              )..show(context);
                              return;
                            }
                            String id = randomAlphaNumeric(10);
                            Map<String , dynamic> coursedata= {
                              "Id" : id,
                              "studentName" : studentName.text,
                              "studentUsn" : studentUsn.text,
                              "studentDOB" : dateOfBirth,
                              "studentGender" : genderValue,
                            };
                            await DatabaseMethods().addStudentDetails(coursedata , id);
                            Navigator.pop(context);
                          },
                          child: Ink(
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [Color.fromARGB(255,251,73,116) , Color.fromARGB(255,250,179,161)],
                                  begin: Alignment.centerRight,
                                  end: Alignment.centerLeft,
                                ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: ListTile(
                              trailing: Icon(Icons.send),
                              title: Text("   Submit "),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showDatePicker() {
    showDatePicker(context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2025),
    ).then((value){
      setState(() {
        dateOfBirth = value!.day.toString() + "/" + value!.month.toString() + "/" + value!.year.toString();
      });
    });
  }
}
