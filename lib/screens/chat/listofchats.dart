import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reddit/screens/chat/listofusers.dart';

class ChatScreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Chats").snapshots(),
        builder: (context,snapshots){

          if(snapshots.connectionState == ConnectionState.waiting)
            {
              return const Center(child: CircularProgressIndicator(),);
            }

          else if(snapshots.data!.docs.isEmpty){
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("No Chats Available"),
                  SizedBox(height: size.height*0.02,),
                  ElevatedButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ListOfUsers()));
                  }, child: const Text("Find People"),),
                ],
              ),
            );
          }

          return ListView.builder(itemCount: 1,itemBuilder: (context,index){

            final doc = snapshots.data!.docs[index];

            return ListTile(

            );
          });
        },
      ),
    );
  }

}