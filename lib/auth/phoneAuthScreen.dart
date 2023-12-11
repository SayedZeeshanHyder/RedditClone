import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:reddit/auth/authservices.dart';
import 'package:reddit/colors.dart';

import '../images.dart';
class PhoneAuthScreen extends StatelessWidget
{

  String countryCode = "IN";

  final phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: CircleAvatar(
          radius: size.width*0.05,
          backgroundImage: const AssetImage(appIcon),
        ),
      ),

      body: Column(
        children: [
          SizedBox(
            height: size.height*0.05,
          ),

          const Text("Sign up or log in with your \n phone number",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),

          SizedBox(
            height: size.height*0.05,
          ),

          Row(
            children: [

              SizedBox(width: size.width*0.02,),

              Container(
                width: size.width*0.3,
                decoration: BoxDecoration(
                  color: greyButton,
                  borderRadius: BorderRadius.circular(size.width*0.05),
                ),
                padding: EdgeInsets.all(size.width*0.01),
                child: CountryCodePicker(
                  initialSelection: "+91",
                  onChanged: (val)
                  {
                    countryCode=val.dialCode.toString();
                  },
                ),
              ),

              SizedBox(width: size.width*0.02,),

              Expanded(
                child: Container(

                  decoration: BoxDecoration(
                    color: greyButton,
                    borderRadius: BorderRadius.circular(size.width*0.05),
                  ),

                  padding: EdgeInsets.symmetric(vertical: size.height*0.015,horizontal: size.width*0.05),


                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Phone number",style: TextStyle(color: Colors.grey.shade500,fontSize: 12),),


                      SizedBox(
                        height: size.height*0.03,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: phoneNumberController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            )
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(width: size.width*0.02,),
            ],
          ),

          SizedBox(
            height: size.height*0.03,
          ),

          const Text("Reddit will your phone number for account \n verification and to personalize your ads and \n experience"),

        ],
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

      floatingActionButton: SizedBox(
        width: size.width*0.97,
        height: size.height*0.06,
        child: ElevatedButton(
            onPressed: (){

              print(countryCode);

              if(phoneNumberController.text.length==10)
                {
                  String completeNumber = "$countryCode${phoneNumberController.text}";
                  AuthServices.sendSms(completeNumber.toString(),context);
                }

            },
            child: const Text("Continue"),
          ),
        ),
    );
  }

}