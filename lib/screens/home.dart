import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reddit/screens/postscreen.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../colors.dart';

class Home extends StatefulWidget
{

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("AllPosts").snapshots(),
      builder: (context,snapshots){

        if(snapshots.connectionState==ConnectionState.waiting)
        {
          return Center(
            child: CircularProgressIndicator(color: appColor,),
          );
        }

        //If Not Posts Available
        if(snapshots.data!.docs.isEmpty){
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("No Posts Yet"),
                ElevatedButton(onPressed: (){
                  setState(() {});
                }, child: const Text("Refresh"),),
              ],
            ),
          );
        }

        //If Only One Post that too of User.
        else if(snapshots.data?.docs[0]["posts"].length==1 && snapshots.data?.docs[0]["posts"][0]["influencer"]==FirebaseAuth.instance.currentUser!.displayName)
          {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("No Posts Yet"),
                  ElevatedButton(onPressed: (){
                    setState(() {});
                  }, child: const Text("Refresh"),),
                ],
              ),
            );
          }


        //Returning Posts
          return ListView.builder(
              itemCount: snapshots.data!.docs[0]["posts"].length, itemBuilder: (context, index) {

            final doc = snapshots.data?.docs[0];

            final post = doc?["posts"][index];

            if(post["influencer"]==FirebaseAuth.instance.currentUser!.displayName)
            {
              return const SizedBox();
            }


            final time = Timestamp(
                post["time"].seconds, post["time"].nanoseconds).toDate();

            return InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>PostScreen(index : index,post: post,)));
              },
              child: Column(

                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: size.width * 0.03,
                        vertical: size.height * 0.01),
                    child: Column(

                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Row(
                          children: [
                            CircleAvatar(backgroundColor: Colors.grey.shade400,
                              radius: size.width * 0.05,
                              backgroundImage: AssetImage(
                                  post["influencerAvatar"]),),
                            SizedBox(width: size.width * 0.02,),
                            Text(post["influencer"], style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: size.width * 0.035),),
                            SizedBox(width: size.width * 0.015,),
                            Text((timeago.format(time)),
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(color: Colors.grey.shade400,
                                  fontSize: size.width * 0.035),),

                            Spacer(),
                            const Icon(Icons.more_vert),
                          ],
                        ),

                        SizedBox(height: size.height * 0.01,),

                        Text(post["title"], style: const TextStyle(
                            fontWeight: FontWeight.w600),
                          textAlign: TextAlign.start,),

                        SizedBox(height: size.height * 0.01,),

                        post["image"] != "" ? Container(
                          color: greyButton,
                          height: size.height * 0.25,
                          width: size.width,
                          child: Image.network(post["image"],fit: BoxFit.contain,),
                        ) :
                        Text(post["subtitle"], style: const TextStyle(
                            fontWeight: FontWeight.w300),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,),

                        SizedBox(height: size.height * 0.02,),

                        Row(
                          children: [
                            const Icon(Icons.arrow_upward),
                            SizedBox(width: size.width * 0.03,),
                            Text(post["up"].toString()),

                            SizedBox(width: size.width * 0.03,),
                            const Icon(Icons.arrow_downward),

                            SizedBox(width: size.width * 0.13,),

                            const Icon(Icons.chat_bubble_outline),

                            SizedBox(width: size.width * 0.02,),

                            Text(post["comments"].length.toString()),

                            SizedBox(width: size.width * 0.10,),

                            const Icon(CupertinoIcons.arrow_turn_up_right),

                            SizedBox(width: size.width * 0.02,),

                            const Text("Share"),

                            SizedBox(width: size.width * 0.02,),

                            Text(post["forwards"].toString()),

                          ],
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                ],
              ),
            );
          });

      },
    );
  }
}