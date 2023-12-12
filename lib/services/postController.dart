import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class PostController
{

  RxString title = "".obs;
  RxString subtitle = "".obs;
  RxString img = "".obs;

  static post(String title,String body,image)
  async {

    final currentUserUid = FirebaseAuth.instance.currentUser!.uid.toString();

    print("Reached here");
    List myPosts;
    final get = await FirebaseFirestore.instance.collection("Posts").doc(currentUserUid).get();

    myPosts = get.exists ? get.data()!["posts"] : [];

    myPosts.add({
      "time":DateTime.now(),
      "influencer":FirebaseAuth.instance.currentUser!.displayName,
      "title":title,
      "subtitle":body,
      "image": image != "" ? image : "",
      "comments":[],
      "up":0,
      "forwards":0
    });


    FirebaseFirestore.instance.collection("Posts").doc(currentUserUid).set({
      "posts":myPosts,
    }).onError((error, stackTrace){
      print(error.toString());
    });
  }



}