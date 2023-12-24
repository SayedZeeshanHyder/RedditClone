import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatServices
{
  static addChat(String oppName)
  async{
    final currentUser = FirebaseAuth.instance.currentUser;
    String chatRoomId = chatRoomCode(currentUser!.displayName.toString(), oppName);
    await FirebaseFirestore.instance.collection("Chats").doc(chatRoomId).set({
      "user1":currentUser.displayName.toString(),
      "user2":oppName,
      "chats":[],
      "roomId":chatRoomId,
    });
  }

  static String chatRoomCode(String userName,String chatUser)
  {
    if(userName.hashCode > chatUser.hashCode)
      {
        return userName+chatUser;
      }
    else{
      return chatUser+userName;
    }
  }
}