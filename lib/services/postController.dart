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

    final getAllPosts = await FirebaseFirestore.instance.collection("AllPosts").doc("AllPosts").get();

    myPosts = getAllPosts.exists ? getAllPosts.data()!["posts"] : [];

    myPosts.add({
      "time":DateTime.now(),
      "influencer":FirebaseAuth.instance.currentUser!.displayName,
      "title":title,
      "influencerAvatar":FirebaseAuth.instance.currentUser!.photoURL,
      "subtitle":body,
      "image": image != "" ? image : "",
      "comments":[],
      "up":0,
      "forwards":0
    });


    FirebaseFirestore.instance.collection("AllPosts").doc("AllPosts").set({
      "posts":myPosts,
    }).onError((error, stackTrace){
      print(error.toString());
    });
  }



  static addComment(String title,String image,index) async
  {

    print("Reached here");
    List listOfComments,listOfPosts;

    final get = await FirebaseFirestore.instance.collection("AllPosts").doc("AllPosts").get();
    listOfPosts = get.exists ? get.data()!["posts"] : [];
    listOfComments = listOfPosts[index]["comments"];
    final tempPostDetails = listOfPosts[index];

    listOfComments.add({
      "commentBy":FirebaseAuth.instance.currentUser!.displayName,
      "commentTime": DateTime.now(),
      "commenterAvatar":FirebaseAuth.instance.currentUser!.photoURL,
      "commentImage": image!="" ? image : "",
      "commentTitle":title,
      "postTitle":tempPostDetails["title"],
      "postSubtitle":tempPostDetails["subtitle"],
      "influencer":tempPostDetails["influencer"]
    });

    listOfPosts[index]["comments"]=listOfComments;

    await FirebaseFirestore.instance.collection("AllPosts").doc("AllPosts").update({
      "posts":listOfPosts,
    }).onError((error, stackTrace){
      print("Last mein error aaya");
    });


  }

}