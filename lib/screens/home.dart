import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reddit/controller/bottomNavController.dart';

import '../colors.dart';

class Home extends StatelessWidget
{

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final bottomNavController = Get.put(BottomNavController());

  @override
  Widget build(BuildContext context) {

    Size size=MediaQuery.of(context).size;

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
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
              child: Icon(Icons.circle,color: Colors.green,size: size.width*0.1,),
            ),
          ],
        ),
        centerTitle: false,

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
      ),


      bottomNavigationBar: Obx(
        ()=> BottomNavigationBar(
          onTap: (index){
            bottomNavController.currentIndex.value=index;
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
        ),
      ),


      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Posts").snapshots(),
        builder: (context,snapshots){

          if(snapshots.connectionState==ConnectionState.waiting)
            {
              return Center(
                child: CircularProgressIndicator(color: appColor,),
              );
            }

          final doc = snapshots.data?.docs[0];

          return ListView.builder(itemCount: snapshots.data?.docs[0]["posts"].length,itemBuilder: (context,index){

            final post = doc?["posts"][index];

            return Column(

              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: size.width*0.03,vertical: size.height*0.01),
                  child: Column(

                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Row(
                        children: [
                          CircleAvatar(backgroundColor: Colors.grey.shade400,radius: size.width*0.03,),
                          SizedBox(width: size.width*0.02,),
                          Text(post["influencer"],style: TextStyle(fontWeight: FontWeight.bold,fontSize: size.width*0.035),),
                          SizedBox(width: size.width*0.015,),
                          Text("${post["time"]}d",style: TextStyle(color: Colors.grey.shade400),),

                          Spacer(),
                          Icon(Icons.more_vert),
                        ],
                      ),

                      SizedBox(height: size.height*0.01,),

                      Text(post["title"],style: TextStyle(fontWeight: FontWeight.w600),textAlign: TextAlign.start,),

                      SizedBox(height: size.height*0.01,),

                      post["image"]!=""? Container(
                        color: Colors.green.shade200,
                        height: size.height*0.25,
                        child: Image.network(post["image"]),
                      ) :
                      Text(post["subtitle"],style: TextStyle(fontWeight: FontWeight.w300),maxLines: 3,overflow: TextOverflow.ellipsis,),

                      SizedBox(height: size.height*0.02,),

                      Row(
                        children: [
                          const Icon(Icons.arrow_upward),
                          SizedBox(width: size.width*0.03,),
                          Text(post["up"].toString()),

                          SizedBox(width: size.width*0.03,),
                          const Icon(Icons.arrow_downward),

                          SizedBox(width: size.width*0.13,),

                          const Icon(Icons.chat_bubble_outline),

                          SizedBox(width: size.width*0.02,),

                          Text(post["comments"].length.toString()),

                          SizedBox(width: size.width*0.10,),

                          const Icon(CupertinoIcons.arrow_turn_up_right),

                          SizedBox(width: size.width*0.02,),

                          const Text("Share"),

                          SizedBox(width: size.width*0.02,),

                          Text(post["forwards"].toString()),

                        ],
                      ),
                    ],
                  ),
                ),
                const Divider(),
              ],
            );
          });
        },
      ),

    );
  }

}