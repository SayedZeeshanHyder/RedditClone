import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../colors.dart';

class ImageService
{
  static Future<String> uploadImage(context)
  async{

    //Image Uploading

    final currentUserUid = FirebaseAuth.instance.currentUser!.uid;

    final firestore = await FirebaseFirestore.instance.collection("Posts").doc(currentUserUid).get();

    int getPostLength = firestore.exists ? firestore.data()!["posts"].length + 1 : 1;

    final img = await ImagePicker.platform.getImageFromSource(source: ImageSource.gallery);

    if(img!=null) {

      //Declaring Alert Dialogue
      AlertDialog alert=AlertDialog(
        content: Row(
          children: [
            CircularProgressIndicator(color: appColor,),
            Container(margin: const EdgeInsets.only(left: 7),child: const Text("Uploading Image ..." )),
          ],),
      );

      //Displaying AlertDialogue
      showDialog(
        barrierDismissible: false,
        context:context,
        builder:(BuildContext context){
          return alert;
        },
      );

      File imgPath = File(img.path);

      final destination = "Posts/$currentUserUid/";

      final ref = FirebaseStorage.instance.ref(destination).child("post$getPostLength");

      await ref.putFile(imgPath);

      String imgUrl = await ref.getDownloadURL();

      Navigator.pop(context);

      return imgUrl;

    }
    else{

      debugPrint("No Image Selected");

    }

    return "";

  }
}