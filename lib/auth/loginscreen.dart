import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reddit/auth/phoneAuthScreen.dart';
import 'package:reddit/controller/emailController.dart';

import '../colors.dart';
import '../images.dart';
import 'authservices.dart';

class LoginScreen extends StatelessWidget
{

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final buttonController = Get.put(ButtonController());

  @override
  Widget build(BuildContext context) {

    Size size =  MediaQuery.of(context).size;

    return Scaffold(

      appBar: AppBar(
        title: CircleAvatar(
          radius: size.width * 0.05,
          backgroundImage: const AssetImage(appIcon),
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [

            SizedBox(height: size.height*0.05,),
            const Text("Log in to Reddit",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),

            SizedBox(height: size.height*0.03,),

            //Phone Number Button
            InkWell(
              onTap: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>PhoneAuthScreen()));
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: size.width*0.03),
                padding: EdgeInsets.symmetric(horizontal: 0,vertical: size.width*0.03),
                decoration: BoxDecoration(
                  color: greyButton,
                  borderRadius: BorderRadius.circular(size.width*0.05),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Spacer(flex: 1,),
                    Icon(Icons.phone_android),
                    Spacer(flex: 4,),
                    Text("Continue with phone number",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                    Spacer(flex: 4,),
                  ],
                ),
              ),
            ),

            SizedBox(height: size.height*0.02,),

            //Google Sign In Button
            InkWell(

              onTap: (){
                Navigator.pop(context);
                AuthServices.googleSignIn(context);

              },

              child: Container(
                margin: EdgeInsets.symmetric(horizontal: size.width*0.03),
                padding: EdgeInsets.symmetric(horizontal: 0,vertical: size.width*0.03),
                decoration: BoxDecoration(
                  color: greyButton,
                  borderRadius: BorderRadius.circular(size.width*0.05),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Spacer(flex: 1,),
                    SizedBox(
                      width: size.width*0.06,
                      height: size.height*0.03,
                      child: Image.asset(googleIcon,fit: BoxFit.cover,),
                    ),
                    Spacer(flex: 4,),
                    Text("Continue with Google",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                    Spacer(flex: 4,),
                  ],
                ),
              ),
            ),

            SizedBox(height: size.height*0.02,),

            Row(
              children: [
                SizedBox(width: size.width*0.05,),
                const Expanded(child: Divider()),
                SizedBox(width: size.width*0.03,),
                const Text("OR"),
                SizedBox(width: size.width*0.03,),
                const Expanded(child: Divider()),
                SizedBox(width: size.width*0.05,),
              ],
            ),

            SizedBox(
              height: size.height*0.03,
            ),
            //Email Field
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
                decoration: const InputDecoration(

                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),

                    hintText: "Email"
                ),
              ),
            ),

            SizedBox(height: size.height*0.02,),
            //Password Field
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
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  suffixIcon: Icon(Icons.remove_red_eye_outlined),
                  hintText: "Password",
                ),
              ),
            ),

            SizedBox(height: size.height*0.13,),
            Text("By continuing you agree to our User Agreement and \n acknowledge that you understand the Privacy Policy .",textAlign: TextAlign.center,maxLines: 2,style: TextStyle(color: Colors.grey.shade400,fontSize: 12.5),),

          ],
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

      floatingActionButton: SizedBox(
        width: size.width*0.97,
        height: size.height*0.06,
        child: Obx(
              ()=> ElevatedButton(
            onPressed: buttonController.buttonEnabled.value?(){

              AuthServices.emailLogin(emailController.text.toString(), passwordController.text.toString(),context);

            }:null,
            child: const Text("Continue"),
          ),
        ),
      ),

    );
  }

}