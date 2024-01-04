import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'chatscreen.dart';

class ListOfUsers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Explore"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("UserInfo").snapshots(),
        builder: (context, snapshots) {
          if (snapshots.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView.builder(
              itemCount: snapshots.data!.docs.length,
              itemBuilder: (context, index) {
                final user = snapshots.data!.docs[index];

                if (user["name"] ==
                    FirebaseAuth.instance.currentUser!.displayName) {
                  return SizedBox();
                }

                return ListTile(
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChatScreen(
                                  user: user,
                                )));
                  },
                  title: Text(user["name"]),
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(
                      user["avatar"],
                    ),
                  ),
                );
              });
        },
      ),
    );
  }
}
