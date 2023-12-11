
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:reddit/colors.dart';

import '../screens/home.dart';
import 'authScreen.dart';

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


  static googleSignIn(BuildContext context)
  async{

    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    FirebaseAuth.instance.signInWithCredential(credential).then((value){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home()));
    });

  }


  static signOut(context)
  {
    FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AuthScreen()));
  }


  static sendSms(String phonenumber)
  {
    FirebaseAuth.instance.verifyPhoneNumber(

        phoneNumber: phonenumber,

        verificationCompleted: (val){

        },
        verificationFailed: (val){

        },
        codeSent: (verificationId,resendToken){
          print(verificationId);
        },
        codeAutoRetrievalTimeout: (val) {

        });
  }

}