import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'features/home/ui/homePage.dart';
import 'welcomePage/invitationPage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid ? await Firebase.initializeApp(
      options: const FirebaseOptions(apiKey: 'AIzaSyArbQTf1_XCCSYNQTxjl8VqMOJQbmyAenc', appId: '1:849450879315:android:6ea341838e82d7deaeb9a6', messagingSenderId: '849450879315', projectId: 'task3-c579d')
  ) : await Firebase.initializeApp();

  runApp( MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
   MyHomePage createState() => MyHomePage();
}

class MyHomePage extends State<MyApp> {
  late String userId;
  var auth = FirebaseAuth.instance;
  var islogin = false;
  checkloggedin(){
    auth.authStateChanges().listen((User? user) {
      if(user != null && mounted){
        setState(() {
          islogin = true;
        });
      }
    });
  }
  @override
  void initState(){
    super.initState();
    checkloggedin();
  }
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: islogin ? HomePage() : WelcomePage(),
    );
  }
}


