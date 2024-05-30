import 'package:flutter/material.dart';
import 'package:task3/authentication/login.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage('assets/welcomeScreen.png'), fit: BoxFit.fill),
            ),
            height: MediaQuery.sizeOf(context).height,
            width: MediaQuery.sizeOf(context).width,
          ),
        ],
      ),
      floatingActionButton: Container(
        height: 100.0,
        width: 100.0,
        child: FittedBox(
          child: FloatingActionButton(
            backgroundColor: Colors.black,
            onPressed: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
            },
            child: Image(image: AssetImage('assets/nextButton.png'),),
          ),
        ),
      ),
    );
  }
}
