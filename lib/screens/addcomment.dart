import 'package:flutter/material.dart';

import '../images.dart';

class AddComment extends StatelessWidget
{

  final index;
  final post;
  AddComment({required this.post,required this.index});

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Scaffold(

      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(icon: const Icon(Icons.close),onPressed: (){},),
        title: const Text("Add comment"),
        actions: [
          TextButton(onPressed: (){}, child: Text("Post",style: TextStyle(color: Colors.blue.shade700),),),
        ],
      ),

      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(size.width*0.02),
              child: Text(post["title"],style: TextStyle(fontWeight: FontWeight.w600,fontSize: size.width*0.05,overflow: TextOverflow.ellipsis),),
            ),

            Divider(),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width*0.02,vertical: size.height*0.03),
              child: TextField(
                maxLines: 25,
                decoration: InputDecoration(
                  hintText: "Add a Comment",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: Container(
        height: size.height*0.06,
        decoration: BoxDecoration(
          color: Colors.blue.shade50,
          border: Border(
            top: BorderSide(color: Colors.grey.shade400)
          ),
        ),
        child: Row(
          children: [
            IconButton(onPressed: (){}, icon: const Icon(Icons.attach_file),),
            Spacer(),
            Padding(
              padding: EdgeInsets.all(size.width*0.01),
              child: const CircleAvatar(
                backgroundImage: AssetImage(appIcon),
              ),
            ),

            IconButton(onPressed: (){}, icon: const Icon(Icons.video_chat_outlined),),

            IconButton(onPressed: (){}, icon: const Icon(Icons.photo),),

          ],
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );

  }
}