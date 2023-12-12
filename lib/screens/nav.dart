import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reddit/auth/authservices.dart';
import 'package:reddit/controller/bottomNavController.dart';
import 'package:reddit/screens/createscreen.dart';
import 'package:reddit/screens/home.dart';
import 'package:reddit/services/postController.dart';

import '../colors.dart';

class Nav extends StatelessWidget
{

  List<Widget> pages=[
    //Home
    Home(),

    //Communities
    Center(child: Text("Communitites"),),

    //Create
    Create(),

    //Chat
    SizedBox(),

    //Inbox
    SizedBox(),

  ];

  final postController = Get.put(PostController());

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final bottomNavController = Get.put(BottomNavController());

  final pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {

    Size size=MediaQuery.of(context).size;

    return Obx(
      ()=> Scaffold(
        key: scaffoldKey,
        appBar: bottomNavController.currentIndex.value!=2?AppBar(
          actions: [
            Container(),
          ],
          automaticallyImplyLeading: false,
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: (){
                  scaffoldKey.currentState?.openDrawer();
                },
                child: Icon(Icons.menu,size: size.width*0.08,),
              ),
              SizedBox(width: size.width*0.02,),
              Container(
                width: size.width*0.3,
                height: size.height*0.05,
                padding: EdgeInsets.zero,
                decoration: BoxDecoration(
                  color: greyButton,
                  borderRadius: BorderRadius.circular(size.width*0.02),
                ),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("Home",style: TextStyle(fontSize: size.width*0.05),),
                    Icon(CupertinoIcons.chevron_down,size: size.width*0.05,),
                  ],
                ),

              ),

              const Spacer(),

              IconButton(onPressed: (){

              }, icon: Icon(Icons.search,size: size.width*0.1,),),

              //Avatar
              Icon(Icons.fastfood),

              SizedBox(width: size.width*0.03,),
              InkWell(
                onTap: (){
                  scaffoldKey.currentState?.openEndDrawer();
                },
                child: CircleAvatar(backgroundImage: AssetImage(FirebaseAuth.instance.currentUser!.photoURL.toString()),),
              ),
            ],
          ),
          centerTitle: false,

        ):AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(icon : Icon(Icons.close),onPressed: (){
            bottomNavController.currentIndex.value = 0;
          },),
          actions: [
            ElevatedButton(onPressed: (){

              print("post pressed");
              if(postController.title.value.isNotEmpty) {
                bottomNavController.currentIndex.value = 0;
                PostController.post(postController.title.value, postController.subtitle.value, postController.img.value);
              }

              }, child: const Text("Post"),),

            SizedBox(width: size.width*0.02,),
          ],
        ),

        drawer: Drawer(
          child: Column(
            children: [
              SizedBox(height: size.height*0.05,),

              const Divider(),

              ListTile(
                title: const Text("Happening Now",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14),),
                trailing: Icon(CupertinoIcons.right_chevron),
              ),

              const Divider(),

              ListTile(
                title: const Text("Your Communities",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14),),
                trailing: Icon(CupertinoIcons.right_chevron),
              ),

              const Divider(),

              ListTile(
                title: const Text("All"),
                leading: Icon(CupertinoIcons.graph_circle),
              ),
            ],
          ),
        ),

        endDrawer: Drawer(
          child: Center(
            child: ElevatedButton(
              onPressed: (){
                AuthServices.signOut(context);
              },
              child: Text("LogOut"),
            ),
          ),
        ),


        bottomNavigationBar: Obx(
          ()=> bottomNavController.currentIndex.value!=2?BottomNavigationBar(
            onTap: (index){
              bottomNavController.currentIndex.value=index;
              pageController.jumpTo(index.toDouble());
            },
            currentIndex: bottomNavController.currentIndex.value,
            showUnselectedLabels: true,
            unselectedItemColor: Colors.grey.shade500,
            unselectedLabelStyle: TextStyle(color: Colors.grey.shade500,fontWeight: FontWeight.w400),
            selectedItemColor: Colors.black,
            selectedLabelStyle: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold),

            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home"),
              BottomNavigationBarItem(icon: Icon(Icons.people_outlined),label: "Communities"),
              BottomNavigationBarItem(icon: Icon(Icons.add),label: "Create"),
              BottomNavigationBarItem(icon: Icon(CupertinoIcons.chat_bubble_fill),label: "Chat"),
              BottomNavigationBarItem(icon: Icon(CupertinoIcons.bell),label: "Inbox"),
            ],
          ): const SizedBox(),
        ),


        body: Obx(()=>pages[bottomNavController.currentIndex.value]),

      ),
    );
  }

}