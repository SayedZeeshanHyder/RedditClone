
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:reddit/auth/authname.dart';
import 'package:reddit/colors.dart';
import 'package:reddit/screens/avatarScreen.dart';

import '../screens/nav.dart';
import 'authScreen.dart';

class AuthServices
{

  static emailLogin(BuildContext context,String email,String password)
  {


    FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password).then((value){

      print("kuch hua");
      Navigator.pop(context);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AuthName()));
    }).onError((error, stackTrace){


      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          shape: const StadiumBorder(),
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
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AuthName()));
    });

  }


  static signOut(context)
  {
    FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AuthScreen()));
  }


  static sendSms(String phonenumber,context)
  {

    FirebaseAuth.instance.verifyPhoneNumber(

        phoneNumber: phonenumber,

        verificationCompleted: (val){

          //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home()));
          print("Verification Completed");

        },
        verificationFailed: (val){

          print("Failed due to :$val");

        },
        codeSent: (verificationId,resendToken){

          String smsCode = "123456";

          PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);

          FirebaseAuth.instance.signInWithCredential(credential).then((value){

            Navigator.pop(context);
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AuthName()));


          }).onError((error, stackTrace){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: appColor,content: Text(error.toString()),),);
          });

        },
        codeAutoRetrievalTimeout: (val) {

        },
      timeout: const Duration(minutes: 1),

    );
  }


  static setUsername(List listOfUsers,context,username)
  async{

    final get = await FirebaseFirestore.instance.collection("Users").doc("uniqueIds").set(
        {
          "users": listOfUsers,
        }
    );


    FirebaseAuth.instance.currentUser?.updateDisplayName(username);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AvatarScreen()));
  }

  static updateAvatar(String avatar,context)
  async{
    await FirebaseAuth.instance.currentUser?.updatePhotoURL(avatar);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Nav()));
  }

}