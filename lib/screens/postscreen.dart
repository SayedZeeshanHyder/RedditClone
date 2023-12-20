import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reddit/images.dart';
import 'package:reddit/screens/addcomment.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../colors.dart';

class PostScreen extends StatelessWidget {
  int index;

  PostScreen({required this.index});

  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: appColor,
        title: ListTile(
          title: Text(
            "Hello",
            style: TextStyle(color: Colors.white),
          ),
          subtitle: Text(
            "19 people are watching",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.white),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_vert),
          ),
          CircleAvatar(
            radius: size.width * 0.05,
            backgroundImage: AssetImage(FirebaseAuth.instance.currentUser!.photoURL.toString()),
          ),
          SizedBox(
            width: size.width * 0.02,
          ),
        ],
      ),
      body: Column(
        children: [

          //Post Part
          StreamBuilder(
            stream: FirebaseFirestore.instance.collection("AllPosts").snapshots(),
            builder: (context,snapshots){

              if(snapshots.connectionState == ConnectionState.waiting){
                return SizedBox(
                  height: size.height*0.3,
                    child: Center(child: CircularProgressIndicator(),),);
              }
              final post = snapshots.data!.docs[0]["posts"][index];

              final time =
              Timestamp(post["time"].seconds, post["time"].nanoseconds).toDate();

              return Column(
                children: [
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: size.width * 0.03,
                      ),
                      CircleAvatar(backgroundImage: AssetImage(post["influencerAvatar"],),),
                      SizedBox(
                        width: size.width * 0.03,
                      ),
                      Column(
                        children: [
                          Text(
                            post["influencer"],
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(timeago.format(time)),
                        ],
                      ),
                    ],
                  ),

                  SizedBox(height: size.height*0.02,),

                  Container(
                    child: Column(
                      children: [
                        post["image"]!="" ?
                        Container(
                          color: Colors.grey.shade200,
                          width: size.width*0.95,
                          height: size.height*0.25,
                          child: Image.network(post["image"],fit: BoxFit.contain,),)
                            :
                        Text(post["subtitle"]),
                      ],
                    ),
                  ),

                  SizedBox(height: size.height*0.02,),

                  Row(
                    children: [

                      Spacer(flex: 1,),

                      const Icon(Icons.arrow_upward),

                      Spacer(flex: 1,),

                      Text(post["up"].toString()),

                      Spacer(flex: 1,),

                      const Icon(Icons.arrow_downward),

                      Spacer(flex: 5,),

                      const Icon(Icons.chat_bubble_outline),

                      SizedBox(width: size.width * 0.02,),

                      Text("${post["comments"].length.toString()} comments"),

                      Spacer(flex: 5,),

                      const Icon(CupertinoIcons.arrow_turn_up_right),

                      Spacer(flex: 1,),
                    ],
                  ),
                  SizedBox(height: size.height*0.013,),
                ],
              );
            },
          ),

          //Comments
          Expanded(
            flex: 5,
            child: StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection("AllPosts").snapshots(),
              builder: (contex, snapshots) {

                if(snapshots.connectionState==ConnectionState.waiting)
                  {
                    return Center(child: CircularProgressIndicator(),);
                  }
                final comments =
                    snapshots.data?.docs[0]["posts"][index]["comments"];

                return ListView.builder(
                    itemCount: comments.length,
                    itemBuilder: (context, index) {

                      final time =
                      Timestamp(comments[index]["commentTime"].seconds, comments[index]["commentTime"].nanoseconds).toDate();

                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: size.width*0.04,vertical: size.height*0.01),
                        child: Container(
                          padding: EdgeInsets.all(size.width*0.03),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(size.width*0.03),
                            color: Colors.grey.shade100,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              //Post Info
                              Container(
                                padding: EdgeInsets.all(size.width*0.02),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(size.width*0.03),
                                  color:Colors.grey.shade300,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(comments[index]["influencer"],style: TextStyle(fontSize: size.width*0.042,fontWeight: FontWeight.bold),),
                                    SizedBox(height: size.height*0.005,),
                                    Text(comments[index]["postTitle"],maxLines: 3,overflow: TextOverflow.ellipsis,)
                                  ],
                                ),
                              ),

                              SizedBox(height: size.height*0.015,),
                              Row(
                                children: [
                                  CircleAvatar(radius: size.width*0.045,backgroundImage: AssetImage(comments[index]["commenterAvatar"]),),
                                  SizedBox(width: size.width*0.02,),
                                  Column(
                                    children: [
                                      Text(comments[index]["commentBy"],style: TextStyle(fontWeight: FontWeight.bold),),
                                      Text(timeago.format(time),style: TextStyle(color: Colors.grey),)
                                    ],
                                  ),
                                ],
                              ),

                              SizedBox(height: size.height*0.015,),

                              Text(comments[index]["commentTitle"]),

                            ],
                          ),
                        ),
                      );
                    },physics: const BouncingScrollPhysics(),);
              },
            ),
          ),

        ],
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      floatingActionButton: Container(
        height: size.height*0.06,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: size.width*0.01),
        margin: EdgeInsets.symmetric(horizontal: size.width*0.02),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(size.width*0.02),
        ),

        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: TextField(
                onTap: (){

                  Navigator.push(context, MaterialPageRoute(builder: (context)=>AddComment(index: index,),),);

                },
                decoration: InputDecoration(
                  hintText: "Add a comment",
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(size.width*0.02),
              child: const CircleAvatar(
                backgroundImage: AssetImage(appIcon),
              ),
            ),
            IconButton(onPressed: (){}, icon: const Icon(Icons.photo),),
          ],
        ),
      ),

    );
  }
}
