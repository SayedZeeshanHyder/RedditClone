import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../colors.dart';

class Home extends StatelessWidget
{

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("Posts").snapshots(),
      builder: (context,snapshots){

        if(snapshots.connectionState==ConnectionState.waiting)
        {
          return Center(
            child: CircularProgressIndicator(color: appColor,),
          );
        }

        final doc = snapshots.data?.docs[0];

        return ListView.builder(itemCount: snapshots.data?.docs[0]["posts"].length,itemBuilder: (context,index){

          final post = doc?["posts"][index];

          return Column(

            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: size.width*0.03,vertical: size.height*0.01),
                child: Column(

                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Row(
                      children: [
                        CircleAvatar(backgroundColor: Colors.grey.shade400,radius: size.width*0.03,),
                        SizedBox(width: size.width*0.02,),
                        Text(post["influencer"],style: TextStyle(fontWeight: FontWeight.bold,fontSize: size.width*0.035),),
                        SizedBox(width: size.width*0.015,),
                        Text("${post["time"]}d",style: TextStyle(color: Colors.grey.shade400),),

                        Spacer(),
                        Icon(Icons.more_vert),
                      ],
                    ),

                    SizedBox(height: size.height*0.01,),

                    Text(post["title"],style: TextStyle(fontWeight: FontWeight.w600),textAlign: TextAlign.start,),

                    SizedBox(height: size.height*0.01,),

                    post["image"]!=""? Container(
                      color: Colors.green.shade200,
                      height: size.height*0.25,
                      child: Image.network(post["image"]),
                    ) :
                    Text(post["subtitle"],style: TextStyle(fontWeight: FontWeight.w300),maxLines: 3,overflow: TextOverflow.ellipsis,),

                    SizedBox(height: size.height*0.02,),

                    Row(
                      children: [
                        const Icon(Icons.arrow_upward),
                        SizedBox(width: size.width*0.03,),
                        Text(post["up"].toString()),

                        SizedBox(width: size.width*0.03,),
                        const Icon(Icons.arrow_downward),

                        SizedBox(width: size.width*0.13,),

                        const Icon(Icons.chat_bubble_outline),

                        SizedBox(width: size.width*0.02,),

                        Text(post["comments"].length.toString()),

                        SizedBox(width: size.width*0.10,),

                        const Icon(CupertinoIcons.arrow_turn_up_right),

                        SizedBox(width: size.width*0.02,),

                        const Text("Share"),

                        SizedBox(width: size.width*0.02,),

                        Text(post["forwards"].toString()),

                      ],
                    ),
                  ],
                ),
              ),
              const Divider(),
            ],
          );
        });
      },
    );
  }

}