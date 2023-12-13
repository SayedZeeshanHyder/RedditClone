import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reddit/services/imageServices.dart';
import 'package:reddit/services/postController.dart';

class Create extends StatelessWidget
{

  final postController = Get.put(PostController());

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextField(
                style: TextStyle(fontSize: size.width*0.08),
                onChanged: (val){
                  postController.title.value=val;
                },
                decoration: InputDecoration(
                  hintText: "Title",
                  hintStyle: TextStyle(color: Colors.grey.shade500,fontSize: size.width*0.08,fontWeight: FontWeight.w600),
                  border: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                  )
                ),
              ),
            ),
            SizedBox(width: size.width*0.02,),
          ],
        ),
        TextField(
          style: TextStyle(fontSize: size.width*0.05),
          onChanged: (val){
            postController.subtitle.value=val;
          },
          decoration: InputDecoration(
              hintText: "Body Text(Optional)",
              hintStyle: TextStyle(color: Colors.grey.shade500,fontSize: size.width*0.05),
              border: const OutlineInputBorder(
                borderSide: BorderSide.none,
              )
          ),
        ),
        const Spacer(),
        Row(
          children: [
            IconButton(icon: const Icon(Icons.attach_file),onPressed: (){},),
            IconButton(icon: const Icon(Icons.photo),onPressed: () async{

              postController.img.value = await ImageService.uploadImage(context);

            },),
            IconButton(icon: const Icon(Icons.video_collection),onPressed: (){},),
          ],
        ),
      ],
    );
  }

}