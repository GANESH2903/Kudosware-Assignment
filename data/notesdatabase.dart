import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:task3/features/home/ui/homePage.dart';

class DatabaseMethods{
  var userId = FirebaseAuth.instance.currentUser!.email!;
  Future addStudentDetails(Map<String , dynamic> studentsDetails , String id) async {
    return await FirebaseFirestore.instance
        .collection(userId)
        .doc(id)
        .set(studentsDetails);
  }

  Future<Stream<QuerySnapshot>> getStudentDetails() async {
    return await FirebaseFirestore.instance.collection(userId).snapshots();
  }

  Future updateStudentDetails(String id , Map<String , dynamic> updateStudentDetails) async{
    return await FirebaseFirestore.instance.collection(userId).doc(id).update(updateStudentDetails);
  }

  Future deleteStudentDetails(String id) async{
    return await FirebaseFirestore.instance.collection(userId).doc(id).delete();
  }

  // Future addStudentsContent(String notesContent, String id) async {
  //   Map<String , dynamic> notesData={"notesContent" : notesContent};
  //   return await FirebaseFirestore.instance
  //       .collection(userId)
  //       .doc(id)
  //       .update(notesData);
  // }
}