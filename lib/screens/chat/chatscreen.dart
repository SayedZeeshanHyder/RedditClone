import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reddit/screens/chat/chatservices.dart';

class ChatScreen extends StatelessWidget {
  final user;

  final auth = FirebaseAuth.instance;
  final messageController = TextEditingController();

  ChatScreen({required this.user});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(user["avatar"]),
            ),
            SizedBox(
              width: size.width * 0.02,
            ),
            Text(user["name"]),
          ],
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("Chats")
            .doc(chatRoomCode(
                auth.currentUser!.displayName.toString(), user["name"]))
            .snapshots(),
        builder: (context, snapshots) {
          if (snapshots.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          List listOfChats;
          try {
            listOfChats = snapshots.data!.data()!["chats"];
          } catch (e) {
            return const Center(
              child: Text("No Chats Available"),
            );
          }

          return ListView.builder(
              itemCount: listOfChats.length,
              itemBuilder: (context, index) {
                return ListTile(
                  subtitle: Text(listOfChats[index]["message"]),
                  title: Text(
                    listOfChats[index]["by"],
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                );
              });
        },
      ),
      floatingActionButton: SizedBox(
        width: size.width * 0.95,
        height: size.height * 0.1,
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: messageController,
                decoration: const InputDecoration(
                  hintText: "Enter Message",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            IconButton(
              onPressed: () async {
                if (messageController.text.isNotEmpty) {
                  await ChatServices.addChat(
                      user["name"], messageController.text);
                  messageController.clear();
                }
              },
              icon: const Icon(Icons.send),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  String oppUser(String user1, String user2) {
    if (user1 == FirebaseAuth.instance.currentUser!.displayName.toString()) {
      return user2;
    } else {
      return user1;
    }
  }

  static String chatRoomCode(String userName, String chatUser) {
    if (userName.hashCode > chatUser.hashCode) {
      return userName + chatUser;
    } else {
      return chatUser + userName;
    }
  }
}
