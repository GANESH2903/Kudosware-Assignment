import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../authentication/login.dart';
import '../bloc/home_bloc.dart';

class navigationDrawer extends StatefulWidget {
  const navigationDrawer({super.key});

  @override
  State<navigationDrawer> createState() => _navigationDrawerState();
}

class _navigationDrawerState extends State<navigationDrawer> {
  final HomeBloc homeBloc = HomeBloc();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous , current) => current is !HomeActionState,
      listener: (context, state) {
        if (state is HomeNavigateToLoginPageActionState) {
          FirebaseAuth.instance.signOut();
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Login()));
        }
      },
  builder: (context, state) {
    return Drawer(
      backgroundColor: Color(0xffa8dadc),
      child: Column(
        children: [
          DrawerHeader(child: Icon(Icons.person , size: 65,)),
          Text("signed in as " , style: TextStyle(fontSize: 15),),
          Text(FirebaseAuth.instance.currentUser!.email! , style: TextStyle(fontSize: 15),),
          Container(
            padding: EdgeInsets.all(40),
            child: SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.5,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Color.fromARGB(255, 215, 247, 245)),
                  ),
                  onPressed: () {
                    homeBloc.add(HomeSignOutButtonClickedEvent());
                  },
                  child: Text(
                    'SignOut',
                    style: TextStyle(color: Colors.black),
                  ),
                )),
          )
        ],
      ),
    );
  },
);
  }
}
