import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reddit/auth/authservices.dart';
import 'package:reddit/colors.dart';
import 'package:reddit/controller/emailController.dart';

import '../images.dart';

class EmailSignIn extends StatelessWidget
{

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final buttonController = Get.put(ButtonController());

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Scaffold(

      resizeToAvoidBottomInset: true,

      appBar: AppBar(
        title: CircleAvatar(
          radius: size.width*0.05,
          backgroundImage: const AssetImage(appIcon),
        ),

        actions: [
          TextButton(onPressed: (){}, child: Text("Log in",style: TextStyle(color: Colors.grey.shade500),),),
        ],
      ),

      body: Column(
        children: [
          SizedBox(
            height: size.height*0.05,
          ),

          const Text("Hi new friend, welcome to \n Reddit",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),

          SizedBox(
            height: size.height*0.05,
          ),

          //Email TextField
          Container(

            alignment: Alignment.center,
            height: size.height*0.075,

            margin: EdgeInsets.symmetric(horizontal: size.width*0.03),
            padding: EdgeInsets.symmetric(horizontal: size.width*0.03),

            decoration: BoxDecoration(
              color: greyButton,
              borderRadius: BorderRadius.circular(size.width*0.05),
            ),

            child: TextField(

              onChanged: (val){
                if(passwordController.text.isNotEmpty && val.isNotEmpty)
                  {
                    buttonController.buttonEnabled.value=true;
                  }
                else
                  {
                    if(buttonController.buttonEnabled.value) {buttonController.buttonEnabled.value=false;}
                  }
              },

              controller: emailController,
              decoration: InputDecoration(

                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),

                hintText: "Email"
              ),
            ),
          ),

          SizedBox(
            height: size.height*0.02,
          ),

          //Password TextField
          Container(

            alignment: Alignment.center,
            height: size.height*0.075,

            margin: EdgeInsets.symmetric(horizontal: size.width*0.03),
            padding: EdgeInsets.symmetric(horizontal: size.width*0.03),

            decoration: BoxDecoration(
              color: greyButton,
              borderRadius: BorderRadius.circular(size.width*0.05),
            ),

            child: TextField(

              onChanged: (val){
                if(emailController.text.isNotEmpty && val.isNotEmpty)
                {
                  buttonController.buttonEnabled.value=true;
                }
                else
                {
                  if(buttonController.buttonEnabled.value) {buttonController.buttonEnabled.value=false;}
                }
              },

              controller: passwordController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                suffixIcon: Icon(Icons.remove_red_eye_outlined),
                  hintText: "Password",
              ),
            ),
          ),

          const Spacer(flex: 6,),

          Text("By continuing you agree to our User Agreement and \n acknowledge that you understand the Privacy Policy .",textAlign: TextAlign.center,maxLines: 2,style: TextStyle(color: Colors.grey.shade400,fontSize: 12.5),),

          const Spacer(flex: 5,),
        ],
      ),



      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

      floatingActionButton: SizedBox(
        width: size.width*0.97,
        height: size.height*0.06,
        child: Obx(
          ()=> ElevatedButton(
            onPressed: buttonController.buttonEnabled.value?(){

                  AuthServices.emailLogin(context, emailController.text.toString(), passwordController.text.toString());

            }:null,
            child: const Text("Continue"),
          ),
        ),
      ),
    );
  }

}