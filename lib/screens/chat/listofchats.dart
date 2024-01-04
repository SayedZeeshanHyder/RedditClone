import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reddit/screens/chat/chatscreen.dart';
import 'package:reddit/screens/chat/listofusers.dart';

class MyChatScreen extends StatelessWidget {
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Chats").snapshots(),
        builder: (context, snapshots) {
          if (snapshots.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshots.data!.docs.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("No Chats Available"),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ListOfUsers()));
                    },
                    child: const Text("Find People"),
                  ),
                ],
              ),
            );
          }

          return StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection("Chats").snapshots(),
              builder: (context, snapshots) {
                if (snapshots.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return ListView.builder(
                    itemCount: snapshots.data?.docs.length,
                    itemBuilder: (context, index) {
                      String roomId = snapshots.data!.docs[index]["roomId"];
                      if (roomId
                          .contains(auth.currentUser!.displayName.toString())) {
                        final info = snapshots.data!.docs[index];
                        final chats = info["chats"][info["chats"].length - 1];

                        return ListTile(
                          onTap: () async {
                            final passUserInfo = await passUser(
                                getOppUser(info["user1"], info["user2"]));
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ChatScreen(user: passUserInfo)));
                          },
                          title: Text(
                            getOppUser(info["user1"], info["user2"]),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(chats["message"]),
                        );
                      } else {
                        return SizedBox();
                      }
                    });
              });
        },
      ),
    );
  }

  String getOppUser(String user1, String user2) {
    if (user1 == auth.currentUser!.displayName) {
      return user2;
    } else {
      return user1;
    }
  }

  passUser(String oppUser) async {
    final get = await FirebaseFirestore.instance
        .collection("UserInfo")
        .doc(oppUser)
        .get();
    return get.data();
  }
}
