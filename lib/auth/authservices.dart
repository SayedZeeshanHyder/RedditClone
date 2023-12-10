import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reddit/colors.dart';

import '../screens/home.dart';

class AuthServices
{

  static emailLogin(BuildContext context,String email,String password)
  {


    FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password).then((value){

      print("kuch hua");
      Navigator.pop(context);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home()));
    }).onError((error, stackTrace){

      print(error.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          shape: StadiumBorder(),
          backgroundColor: appColor,
          content: Text(error.toString(),style: const TextStyle(color: Colors.white),
          ),
        ),
      );
    });
  }

}