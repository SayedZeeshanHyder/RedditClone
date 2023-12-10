import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reddit/auth/authScreen.dart';
import 'package:reddit/auth/authservices.dart';

class Home extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [
          TextButton(onPressed: (){

            AuthServices.signOut(context);

          }, child: Text("Log Out"),),
        ],
      ),
    );
  }

}