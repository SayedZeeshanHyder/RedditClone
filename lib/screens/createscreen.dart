import 'package:flutter/material.dart';

class Create extends StatelessWidget
{

  final titleController = TextEditingController();
  final subtitleController = TextEditingController();

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
                controller: titleController,
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
          controller: subtitleController,
          decoration: InputDecoration(
              hintText: "Body Text(Optional)",
              hintStyle: TextStyle(color: Colors.grey.shade500,fontSize: size.width*0.05),
              border: const OutlineInputBorder(
                borderSide: BorderSide.none,
              )
          ),
        ),
        Spacer(),
        Row(
          children: [
            IconButton(icon: const Icon(Icons.attach_file),onPressed: (){},),
            IconButton(icon: const Icon(Icons.photo),onPressed: (){},),
            IconButton(icon: const Icon(Icons.video_collection),onPressed: (){},),
          ],
        ),
      ],
    );
  }

}