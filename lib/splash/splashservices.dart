import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reddit/auth/authScreen.dart';

class SplashServices
{
  splash(BuildContext context)
  {
    final currentUser = FirebaseAuth.instance.currentUser;
    if(currentUser!=null)
      {
        //Navigate to Home
      }
    else{
      Timer(const Duration(seconds: 3),()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>AuthScreen())));
    }
  }
}