import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reddit/screens/chat/chatservices.dart';

import 'chatscreen.dart';

class ListOfUsers extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("UserInfo").snapshots(),
        builder: (context,snapshots){

          if(snapshots.connectionState == ConnectionState.waiting)
            {
              return const Center(child: CircularProgressIndicator(),);
            }

          return ListView.builder(itemCount: snapshots.data!.docs.length,itemBuilder: (context,index){

            final user= snapshots.data!.docs[index];
            return ListTile(

              onTap: ()async{
                await ChatServices.addChat(user["name"]);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ChatScreen()));
              },

              title: Text(user["name"]),
              leading: CircleAvatar(
                backgroundImage: AssetImage(user["avatar"],),
              ),
            );

          });

        },
      ),
    );
  }

}