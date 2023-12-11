import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PostController
{
  post(String title,String body,image)
  async {

    final currentUserUid = FirebaseAuth.instance.currentUser?.uid.toString();

    List myPosts;
    final get = await FirebaseFirestore.instance.collection("Posts").doc(currentUserUid).get();

    myPosts = get.exists ? get.data()!["posts"] : [];

    myPosts.add({
      "time":DateTime.now().second,
      "influencer":FirebaseAuth.instance.currentUser?.displayName,
      "title":title,
      "subtitle":body,
      "image":image!=""?image:"",
      "comments":[],
      "up":0,
      "forwards":0
    });


    FirebaseFirestore.instance.collection("Posts").doc(currentUserUid).set({
      "posts":myPosts,
    });
  }


}