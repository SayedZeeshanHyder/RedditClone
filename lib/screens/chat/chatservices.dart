import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatServices {
  static addChat(String oppName, String message) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    String chatRoomId =
        chatRoomCode(currentUser!.displayName.toString(), oppName);

    final get = await FirebaseFirestore.instance
        .collection("Chats")
        .doc(chatRoomId)
        .get();

    List listOfChats = [];
    if (get.exists) {
      listOfChats = get.data()!["chats"];
      listOfChats.add({
        "by": currentUser.displayName,
        "message": message,
        "time": DateTime.now()
      });

      print(listOfChats);

      await FirebaseFirestore.instance
          .collection("Chats")
          .doc(chatRoomId)
          .update({"chats": listOfChats});
    } else {
      listOfChats.add({
        "by": currentUser.displayName,
        "message": message,
        "time": DateTime.now()
      });
      await FirebaseFirestore.instance.collection("Chats").doc(chatRoomId).set({
        "user1": currentUser.displayName.toString(),
        "user2": oppName,
        "chats": listOfChats,
        "roomId": chatRoomId,
      });
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
