import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reddit/auth/authservices.dart';
import 'package:reddit/colors.dart';
import 'package:reddit/controller/avatarController.dart';
import 'package:reddit/controller/emailController.dart';

import '../images.dart';

class AvatarScreen extends StatelessWidget
{

  final avatarController = Get.put(AvatarController());

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

      body: Center(
        child: Column(
          children: [

            SizedBox(
              height: size.height * 0.05,
            ),

            const Text(
              "Select your Avengers",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),

            SizedBox(
              height: size.height * 0.05,
            ),

            Text(
              "Whose team are you in?",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey.shade400, fontSize: size.width*0.05),
            ),

            SizedBox(height: size.height*0.04,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: (){
                    buttonController.buttonEnabled.value = true;
                    avatarController.currentAvatar.value=1;
                  },
                  child: Obx(
                        ()=> CircleAvatar(
                          backgroundColor: appColor,
                      radius: size.width*0.125,
                      backgroundImage:  avatarController.currentAvatar.value!=1 ? const AssetImage(captainAmericaAvatar):null,
                          child: avatarController.currentAvatar.value == 1 ? Icon(Icons.check,color: Colors.white,size: size.width*0.1,):null,
                    ),
                  ),
                ),
                InkWell(
                  onTap: (){
                    buttonController.buttonEnabled.value = true;
                    avatarController.currentAvatar.value=2;
                  },
                  child: Obx(
                        ()=> CircleAvatar(
                          backgroundColor: appColor,
                      radius: size.width*0.125,
                      backgroundImage:  avatarController.currentAvatar.value != 2 ? const AssetImage(ironManAvatar):null,
                      child: avatarController.currentAvatar.value == 2 ? Icon(Icons.check,color: Colors.white,size: size.width*0.1,):null,
                    ),
                  ),
                ),
                InkWell(
                  onTap: (){
                    buttonController.buttonEnabled.value = true;
                    avatarController.currentAvatar.value=3;
                  },
                  child: Obx(
                        ()=> CircleAvatar(
                          backgroundColor: appColor,
                      radius: size.width*0.125,
                      backgroundImage:  avatarController.currentAvatar.value!=3 ? const AssetImage(thorAvatar):null,
                      child: avatarController.currentAvatar.value == 3 ?  Icon(Icons.check,color: Colors.white,size: size.width*0.1,):null,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: size.height*0.04,),


            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: (){
                    buttonController.buttonEnabled.value = true;
                    avatarController.currentAvatar.value=4;
                  },
                  child: Obx(
                        ()=> CircleAvatar(
                          backgroundColor: appColor,
                      radius: size.width*0.125,
                      backgroundImage:  avatarController.currentAvatar.value!=4 ? const AssetImage(hulkAvatar):null,
                      child: avatarController.currentAvatar.value == 4 ? Icon(Icons.check,color: Colors.white,size: size.width*0.1,):null,
                    ),
                  ),
                ),
                InkWell(
                  onTap: (){
                    buttonController.buttonEnabled.value = true;
                    avatarController.currentAvatar.value=5;
                  },
                  child: Obx(
                        ()=> CircleAvatar(
                          backgroundColor: appColor,
                      radius: size.width*0.125,
                      backgroundImage:  avatarController.currentAvatar.value!=5 ? const AssetImage(hawkeyeAvatar):null,
                      child: avatarController.currentAvatar.value == 5 ? Icon(Icons.check,color: Colors.white,size: size.width*0.1,):null,
                    ),
                  ),
                ),
                InkWell(
                  onTap: (){
                    buttonController.buttonEnabled.value = true;
                    avatarController.currentAvatar.value=6;
                  },
                  child: Obx(
                        ()=> CircleAvatar(
                          backgroundColor: appColor,
                      radius: size.width*0.125,
                      backgroundImage:  avatarController.currentAvatar.value!=6 ? const AssetImage(blackWidowAvatar):null,
                      child: avatarController.currentAvatar.value == 6 ? Icon(Icons.check,color: Colors.white,size: size.width*0.1,):null,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: size.height*0.04,),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: (){
                    buttonController.buttonEnabled.value = true;
                    avatarController.currentAvatar.value=7;
                  },
                  child: Obx(
                        ()=> CircleAvatar(
                          backgroundColor: appColor,
                      radius: size.width*0.125,
                      backgroundImage:  avatarController.currentAvatar.value!=7 ? const AssetImage(drStrangeAvatar):null,
                      child: avatarController.currentAvatar.value == 7 ? Icon(Icons.check,color: Colors.white,size: size.width*0.1,):null,
                    ),
                  ),
                ),
                InkWell(
                  onTap: (){
                    buttonController.buttonEnabled.value = true;
                    avatarController.currentAvatar.value=8;
                  },
                  child: Obx(
                        ()=> CircleAvatar(
                          backgroundColor: appColor,
                      radius: size.width*0.125,
                      backgroundImage:  avatarController.currentAvatar.value!=8 ? const AssetImage(spidermanAvatar):null,
                      child: avatarController.currentAvatar.value == 8 ? Icon(Icons.check,color: Colors.white,size: size.width*0.1,):null,
                    ),
                  ),
                ),
                InkWell(
                  onTap: (){
                    buttonController.buttonEnabled.value = true;
                    avatarController.currentAvatar.value=9;
                  },
                  child: Obx(
                        ()=> CircleAvatar(
                          backgroundColor: appColor,
                      radius: size.width*0.125,
                      backgroundImage:  avatarController.currentAvatar.value!=9 ? const AssetImage(antmanAvatar):null,
                      child: avatarController.currentAvatar.value == 9 ? Icon(Icons.check,color: Colors.white,size: size.width*0.1,):null,
                    ),
                  ),
                ),
              ],
            ),

          ],
        ),
      ),


      floatingActionButton: SizedBox(
        width: size.width * 0.97,
        height: size.height * 0.06,
        child: Obx(
              () => ElevatedButton(
            onPressed: buttonController.buttonEnabled.value ? () {

              AuthServices.updateAvatar(passAvatar(), context);

            } : null,
            child: const Text("Continue"),
          ),
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

    );
  }

  String passAvatar()
  {
    switch(avatarController.currentAvatar.value)
    {
      case 1:return captainAmericaAvatar;
      case 2:return ironManAvatar;
      case 3:return thorAvatar;
      case 4:return hulkAvatar;
      case 5:return hawkeyeAvatar;
      case 6:return blackWidowAvatar;
      case 7:return drStrangeAvatar;
      case 8:return spidermanAvatar;
      case 9:return antmanAvatar;
    }
    return "";
  }

}