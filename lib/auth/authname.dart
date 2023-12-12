import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reddit/auth/authservices.dart';
import 'package:reddit/controller/emailController.dart';
import 'package:username_generator/username_generator.dart';

import '../colors.dart';
import '../images.dart';

class AuthName extends StatefulWidget {


  @override
  State<AuthName> createState() => _AuthNameState();
}

class _AuthNameState extends State<AuthName> {

  final generator = UsernameGenerator();

  final buttonController = Get.put(ButtonController());

  final usernameController = TextEditingController();

  late List listOfUsers;

  @override
  void initState() {
    super.initState();
    getAllUsers();
  }

  getAllUsers()async{
    final get = await FirebaseFirestore.instance.collection("Users").doc("uniqueIds").get();
    listOfUsers = get.exists ? get.data()!['users'] : [];
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: CircleAvatar(
          radius: size.width * 0.05,
          backgroundImage: const AssetImage(appIcon),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: size.height * 0.05,
          ),
          const Text(
            "Create your username",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: size.height * 0.05,
          ),
          Text(
            "Most redditors use an anonymous username \n You won't be able to change it later.",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey.shade400, fontSize: 12.5),
          ),
          SizedBox(
            height: size.height * 0.075,
          ),

          Container(

            decoration: BoxDecoration(
              color: greyButton,
              borderRadius: BorderRadius.circular(size.width*0.05),
            ),

            margin: EdgeInsets.symmetric(vertical: size.height*0.015,horizontal: size.width*0.05),
            padding: EdgeInsets.symmetric(vertical: size.height*0.015,horizontal: size.width*0.05),


            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Username",style: TextStyle(color: Colors.grey.shade500,fontSize: 12),),


                SizedBox(
                  height: size.height*0.03,
                  child: TextField(
                    onChanged: (val){
                      if(val.isNotEmpty){
                        buttonController.buttonEnabled.value=true;
                      }
                      else{
                        buttonController.buttonEnabled.value=false;
                      }
                    },
                    keyboardType: TextInputType.text,
                    controller: usernameController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        )
                    ),
                  ),
                ),
              ],
            ),
          ),


          SizedBox(height: size.height*0.05,),

          Text("Need Inspiration? Try these usernames:",textAlign: TextAlign.start,style: TextStyle(color: Colors.grey.shade500,fontSize: size.width*0.04),),

          Expanded(
            child: ListView.builder(itemCount: 4,itemBuilder: (context,index){

              String random = generator.generateRandom();

              return ListTile(
                onTap: (){
                  buttonController.buttonEnabled.value=true;
                  usernameController.text=random;
                },
                title: Text(random),
              );
            }),
          ),
        ],
      ),
      floatingActionButton: SizedBox(
        width: size.width * 0.97,
        height: size.height * 0.06,
        child: Obx(
          () => ElevatedButton(
            onPressed: buttonController.buttonEnabled.value ? () {

              if(!listOfUsers.contains(usernameController.text)) {

                listOfUsers.add(usernameController.text);
                AuthServices.setUsername(listOfUsers, context,usernameController.text);

              }
              else{
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: appColor,content: const Text("Sorry , username is Already Taken."),),);
              }

            } : null,
            child: const Text("Continue"),
          ),
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}