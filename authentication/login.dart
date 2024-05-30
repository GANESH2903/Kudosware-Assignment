
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task3/authentication/signup.dart';

import '../features/home/ui/homePage.dart';
import 'firebase_auth_services.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isSigning = false;

  final FirebaseAuthService _auth = FirebaseAuthService();

  final emailAddress = new TextEditingController();
  final password = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Material(
                elevation: 5.0,
                borderRadius: BorderRadius.circular(50),
                child: Container(
                  decoration: BoxDecoration(color: Color.fromARGB(255,151,231,230), borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50) , bottomRight: Radius.circular(50))),
                  height: MediaQuery.sizeOf(context).height*0.3,
                  child: Stack(
                    children: [
                      Image(image: AssetImage('assets/top_frame.png')),
                      Positioned(top: MediaQuery.sizeOf(context).height*0.065 , left: MediaQuery.sizeOf(context).width*0.23,
                        child: Image(image: AssetImage('assets/digiNotes.png')),width: 200, height: 200,)
                    ],
                  )
                ),
              ),
              SizedBox(height: MediaQuery.sizeOf(context).height*0.06,),
              Container(
                padding: EdgeInsets.only(left: 40, right: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(" User", style: TextStyle(color:Color.fromARGB(255,151,231,230), fontSize: 15 , fontWeight: FontWeight.bold),),
                    TextField(
                      controller: emailAddress,
                      decoration: InputDecoration(
                        hintText: '  E-mail',
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Container(
                padding: EdgeInsets.only(left: 40, right: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(" Password", style: TextStyle(color:Color.fromARGB(255,151,231,230), fontSize: 15 , fontWeight: FontWeight.bold),),
                    TextField(
                      obscureText: true,
                      controller: password,
                      decoration: InputDecoration(
                        hintText: '  password',
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              SizedBox(width : MediaQuery.sizeOf(context).width*0.8,
                child: ElevatedButton(
                    style: ButtonStyle(backgroundColor:MaterialStateProperty.all(Color.fromARGB(255,11,42,40)),),
                    onPressed: () {
                      _login();
                    },
                    child: isSigning ? CircularProgressIndicator(color: Colors.white,) : Text('Login' , style: TextStyle(color: Colors.white),),
                  )
              ),
              TextButton(onPressed: (){}, child:Text("Forgot your password?" , style: TextStyle(fontWeight: FontWeight.bold , color: Colors.black),)),
              Padding(
                padding: EdgeInsets.only(right: 40,left: 40),
                child: Row(
                  children: [
                    Spacer(),
                    Container(color: Color.fromARGB(255,184,226,229),width: MediaQuery.sizeOf(context).width*0.3, height: 2,),
                    Spacer(),
                    Text(" or "),
                    Spacer(),
                    Container(color: Color.fromARGB(255,184,226,229),width: MediaQuery.sizeOf(context).width*0.3, height: 2,),
                    Spacer(),
                  ],
                ),
              ),
              SizedBox(height:  MediaQuery.sizeOf(context).height*0.01,),
              Padding(
                padding: EdgeInsets.only(right: 40,left: 40),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      width: 95,
                      height: 60,
                      decoration: BoxDecoration(color: Color.fromARGB(255,213,246,245), borderRadius: BorderRadius.circular(10)),
                      child: Image.asset('assets/google.png'),
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.all(10),
                      width: 95,
                      height: 60,
                      decoration: BoxDecoration(color: Color.fromARGB(255,213,246,245), borderRadius: BorderRadius.circular(10)),
                      child: Image.asset('assets/linkedin.png'),
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.all(10),
                      width: 95,
                      height: 60,
                      decoration: BoxDecoration(color: Color.fromARGB(255,213,246,245), borderRadius: BorderRadius.circular(10)),
                      child: Image.asset('assets/apple.png'),
                    ),
                  ],
                ),
              ),
              SizedBox(height:  MediaQuery.sizeOf(context).height*0.07,),
              SizedBox(width : MediaQuery.sizeOf(context).width*0.8,
                  child: ElevatedButton(
                    style: ButtonStyle(backgroundColor:MaterialStateProperty.all(Color.fromARGB(255,215,247,245)),),
                    onPressed: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignUp()));
                    },
                    child: Text('Create your account' , style: TextStyle(color: Colors.black),),
                  )
              ),
            ],
          ),
        ),
      )
    );
  }

  void _login() async{
    setState(() {
      isSigning = true;
    });
    String _emailAddress = emailAddress.text.toString();
    String _password = password.text.toString();

    User? user = await _auth.signInWithEmailAndPassword(_emailAddress, _password);

    setState(() {
      isSigning = false;
    });
    if(user != null){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
    }
  }
}
