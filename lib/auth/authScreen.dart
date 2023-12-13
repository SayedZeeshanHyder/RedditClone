import 'package:flutter/material.dart';
import 'package:reddit/auth/authservices.dart';
import 'package:reddit/auth/emailsignin.dart';
import 'package:reddit/auth/loginscreen.dart';
import 'package:reddit/auth/phoneAuthScreen.dart';
import 'package:reddit/colors.dart';
import 'package:reddit/images.dart';

class AuthScreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width*0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: size.height*0.25,),
              CircleAvatar(
                  radius: size.width*0.1,
                backgroundImage: AssetImage(appIcon),
              ),

              SizedBox(height: size.height*0.05,),
              const Text("All your interests in one place",style: TextStyle(fontSize: 38,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),

              SizedBox(
                height: size.height*0.125,
              ),

              //Phone Number Button
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>PhoneAuthScreen()));
                },
                child: Container(
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

              SizedBox(
                height: size.height*0.01,
              ),

              //Google Button
              InkWell(

                onTap: (){

                  AuthServices.googleSignIn(context);

                },

                child: Container(
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
                        child: Image.asset(googleIcon,fit: BoxFit.contain,),
                      ),
                      Spacer(flex: 4,),
                      Text("Continue with Google",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                      Spacer(flex: 4,),
                    ],
                  ),
                ),
              ),

              SizedBox(
                height: size.height*0.01,
              ),

              //Email Button
              InkWell(
                onTap: (){

                  Navigator.push(context, MaterialPageRoute(builder: (context)=>EmailSignIn()));

                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 0,vertical: size.width*0.03),
                  decoration: BoxDecoration(
                    color: greyButton,
                    borderRadius: BorderRadius.circular(size.width*0.05),
                  ),
                  child:const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Spacer(flex: 1,),
                      Icon(Icons.email),
                      Spacer(flex: 4,),
                      Text("Continue with email",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                      Spacer(flex: 4,),
                    ],
                  ),
                ),
              ),


              SizedBox(
                height: size.height*0.02,
              ),

              Text("By continuing you agree to our User Agreement and \n acknowledge that you understand the Privacy Policy .",textAlign: TextAlign.center,maxLines: 2,style: TextStyle(color: Colors.grey.shade400,fontSize: 12.5),),

              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already a Redditor?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: size.width * 0.01,
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen(),),);
                        },
                        child: Text(
                          "Log in",
                          style: TextStyle(
                              color: appColor,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}