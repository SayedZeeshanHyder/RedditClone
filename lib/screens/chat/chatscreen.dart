import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget
{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("hello"),
      ),

      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Chats").snapshots(),
        builder: (context,snapshots){

          if(snapshots.connectionState == ConnectionState.waiting)
            {
              return const Center(child: CircularProgressIndicator(),);
            }

          return ListView.builder(itemCount: snapshots.data!.docs.length,itemBuilder: (context,index){

            final roomIds = snapshots.data!.docs[index]["roomId"].toString();
            final doc = snapshots.data!.docs[index];
            final chatUser = oppUser(doc["user1"], doc["user2"]);

            if(roomIds.contains(FirebaseAuth.instance.currentUser!.displayName.toString())) {
              return
            }
            else{
              return const SizedBox();
            }

          });
        },
      ),
    );
  }

  String oppUser(String user1,String user2)
  {
    if(user1==FirebaseAuth.instance.currentUser!.displayName.toString())
      {
        return user2;
      }
    else{
      return user1;
    }
  }

}