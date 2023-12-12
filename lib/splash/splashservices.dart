import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reddit/auth/authScreen.dart';
import 'package:reddit/auth/authname.dart';
import 'package:reddit/screens/nav.dart';

class SplashServices
{
  splash(BuildContext context)
  {
    final currentUser = FirebaseAuth.instance.currentUser;

    if(currentUser!=null)
      {
        if(currentUser?.displayName==null)
        {
          Timer(const Duration(seconds: 3), () =>
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => AuthName())));
        }
        else {
          Timer(const Duration(seconds: 3), () =>
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => Nav())));
        }
      }
    else{
      Timer(const Duration(seconds: 3),()=>Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AuthScreen())));
    }
  }
}