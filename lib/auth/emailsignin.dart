import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reddit/colors.dart';
import 'package:reddit/controller/emailController.dart';

import '../images.dart';

class EmailSignIn extends StatelessWidget
{

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final emailAuthController = Get.put(EmailController());

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Scaffold(
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
              controller: emailController,
              decoration: InputDecoration(

                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),

                hintText: "Email"
              ),
            ),
          ),

          emailAuthController.incorrectEmail.value.isNotEmpty?Obx(()=> Text(emailAuthController.incorrectEmail.value,style: TextStyle(color: appColor),)):SizedBox(),

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

          emailAuthController.incorrectPassword.value.isNotEmpty?Obx(()=> Text(emailAuthController.incorrectPassword.value,style: TextStyle(color: appColor),textAlign: TextAlign.start,),):SizedBox(width:0,height: 0,),

          const Spacer(flex: 11,),

          Text("By continuing you agree to our User Agreement and \n acknowledge that you understand the Privacy Policy .",textAlign: TextAlign.center,maxLines: 2,style: TextStyle(color: Colors.grey.shade400,fontSize: 12.5),),

          const Spacer(flex: 5,),
        ],
      ),



      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

      floatingActionButton: SizedBox(
        width: size.width*0.97,
        height: size.height*0.06,
        child: ElevatedButton(
          onPressed: (){

            if(emailController.text.isEmpty)
              {
                emailAuthController.incorrectEmail.value="Enter Email";
              }
            else if(!emailController.text.contains("@"))
              {
                emailAuthController.incorrectEmail.value="Invalid Format";
              }
            else
              {
                emailAuthController.incorrectEmail.value="";
              }

            if(passwordController.text.isEmpty)
            {
              print("this called");
              emailAuthController.incorrectPassword.value="Enter Password";
            }
            else if(passwordController.text.length<6)
            {
              emailAuthController.incorrectPassword.value="Password must contain atleast 6 letters";
            }
            else
            {
              emailAuthController.incorrectPassword.value="";
            }

            if(emailAuthController.incorrectEmail.value=="" && emailAuthController.incorrectPassword.value=="")
              {
                //Firebase Email Auth
              }

          },
          child: const Text("Continue"),
        ),
      ),
    );
  }

}