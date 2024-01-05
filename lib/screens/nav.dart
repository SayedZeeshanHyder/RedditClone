import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:reddit/auth/authservices.dart';
import 'package:reddit/controller/bottomNavController.dart';
import 'package:reddit/screens/createscreen.dart';
import 'package:reddit/screens/home.dart';
import 'package:reddit/screens/settings.dart';
import 'package:reddit/services/postController.dart';

import '../colors.dart';
import 'chat/listofchats.dart';

class Nav extends StatelessWidget {
  List<Widget> pages = [
    //Home
    Home(),

    //Communities
    const Center(
      child: Text("Communitites Section will be Added soon"),
    ),

    //Create
    Create(),

    //Chat
    MyChatScreen(),

    //Inbox
    SizedBox(),
  ];

  final postController = Get.put(PostController());

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final bottomNavController = Get.put(BottomNavController());

  final pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Obx(
      () => WillPopScope(
        onWillPop: () async {
          if (bottomNavController.currentIndex.value == 2) {
            showDiscardDialogue(context, size);
          } else {
            showAlertDialogue(context, size);
          }
          return true;
        },
        child: Scaffold(
          key: scaffoldKey,
          appBar: bottomNavController.currentIndex.value != 2
              ? AppBar(
                  actions: [
                    Container(),
                  ],
                  automaticallyImplyLeading: false,
                  title: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          scaffoldKey.currentState?.openDrawer();
                        },
                        child: Icon(
                          Icons.menu,
                          size: size.width * 0.08,
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.02,
                      ),
                      Container(
                        padding: EdgeInsets.all(size.width * 0.02),
                        height: size.height * 0.05,
                        decoration: BoxDecoration(
                          color: greyButton,
                          borderRadius:
                              BorderRadius.circular(size.width * 0.02),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Obx(
                              () => appBarText(size),
                            ),
                            SizedBox(
                              width: size.width * 0.03,
                            ),
                            Icon(
                              CupertinoIcons.chevron_down,
                              size: size.width * 0.05,
                            ),
                          ],
                        ),
                      ),

                      const Spacer(),

                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.search,
                          size: size.width * 0.1,
                        ),
                      ),

                      //Avatar
                      Icon(Icons.fastfood),

                      SizedBox(
                        width: size.width * 0.03,
                      ),
                      InkWell(
                        onTap: () {
                          scaffoldKey.currentState?.openEndDrawer();
                        },
                        child: CircleAvatar(
                          backgroundImage: AssetImage(FirebaseAuth
                              .instance.currentUser!.photoURL
                              .toString()),
                        ),
                      ),
                    ],
                  ),
                  centerTitle: false,
                )
              : AppBar(
                  automaticallyImplyLeading: false,
                  leading: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      bottomNavController.currentIndex.value = 0;
                    },
                  ),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        print("post pressed");
                        if (postController.title.value.isNotEmpty) {
                          bottomNavController.currentIndex.value = 0;
                          PostController.post(
                              postController.title.value,
                              postController.subtitle.value,
                              postController.img.value);
                        }
                      },
                      child: const Text("Post"),
                    ),
                    SizedBox(
                      width: size.width * 0.02,
                    ),
                  ],
                ),
          drawer: Drawer(
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.05,
                ),
                const Divider(),
                ListTile(
                  title: const Text(
                    "Happening Now",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                  ),
                  trailing: Icon(CupertinoIcons.right_chevron),
                ),
                const Divider(),
                ListTile(
                  title: const Text(
                    "Your Communities",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                  ),
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
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * 0.35,
                    child: Image.asset(
                      FirebaseAuth.instance.currentUser!.photoURL.toString(),
                      fit: BoxFit.cover,
                    ),
                  ),

                  SizedBox(
                    height: size.height * 0.02,
                  ),

                  Text(
                    FirebaseAuth.instance.currentUser!.displayName.toString(),
                    style: TextStyle(fontSize: size.width * 0.06),
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Chip(
                    shape: const StadiumBorder(),
                    side: BorderSide(
                      width: size.width * 0.005,
                      color: Colors.green.shade300,
                    ),
                    label: SizedBox(
                      width: size.width * 0.5,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.circle,
                            color: Colors.green.shade300,
                          ),
                          const Text("Status Online"),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(
                    height: size.height * 0.03,
                  ),

                  SizedBox(
                    height: size.height * 0.075,
                    child: Row(
                      children: [
                        SizedBox(
                          width: size.width * 0.03,
                        ),
                        Icon(
                          Icons.severe_cold,
                          color: Colors.blue,
                        ),
                        SizedBox(
                          width: size.width * 0.03,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "1",
                              style: TextStyle(fontSize: size.width * 0.065),
                            ),
                            Text(
                              "Karma",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: size.width * 0.04),
                            ),
                          ],
                        ),
                        const Spacer(
                          flex: 1,
                        ),
                        const VerticalDivider(),
                        SizedBox(
                          width: size.width * 0.03,
                        ),
                        Icon(
                          Icons.cake,
                          color: Colors.blue,
                        ),
                        SizedBox(
                          width: size.width * 0.03,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("1d"),
                            Text("Karma"),
                          ],
                        ),
                        const Spacer(
                          flex: 1,
                        ),
                      ],
                    ),
                  ),

                  const Divider(),

                  // Other Accessibilities
                  SizedBox(
                    height: size.height * 0.3,
                    child: const SingleChildScrollView(
                      child: Column(
                        children: [
                          ListTile(
                            leading: Icon(Icons.emoji_food_beverage),
                            title: Text("Reddit Recap"),
                          ),
                          ListTile(
                            leading: Icon(Icons.person),
                            title: Text("My Profile"),
                          ),
                          ListTile(
                            leading: Icon(Icons.people_outline),
                            title: Text("Create a community"),
                          ),
                          ListTile(
                            leading: Icon(Icons.folder),
                            title: Text("Contributor Program"),
                          ),
                          ListTile(
                            leading: Icon(Icons.stream_sharp),
                            title: Text("Vault"),
                          ),
                          ListTile(
                            leading: Icon(Icons.emoji_food_beverage),
                            title: Text("Reddit Recap"),
                          ),
                          ListTile(
                            leading: Icon(Icons.emoji_food_beverage),
                            title: Text("Reddit Recap"),
                          ),
                          ListTile(
                            leading: Icon(Icons.emoji_food_beverage),
                            title: Text("Reddit Recap"),
                          ),
                        ],
                      ),
                    ),
                  ),

                  ListTile(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Settings()));
                    },
                    leading: const Icon(Icons.settings),
                    title: const Text("Settings"),
                  ),

                  //Log Out Button
                  SizedBox(
                    height: size.height * 0.04,
                    width: size.width * 0.6,
                    child: ElevatedButton(
                      onPressed: () {
                        AuthServices.signOut(context);
                      },
                      child: const Text("LogOut"),
                    ),
                  ),

                  SizedBox(
                    height: size.height * 0.02,
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Obx(
            () => bottomNavController.currentIndex.value != 2
                ? BottomNavigationBar(
                    onTap: (index) {
                      bottomNavController.currentIndex.value = index;
                      pageController.jumpTo(index.toDouble());
                    },
                    currentIndex: bottomNavController.currentIndex.value,
                    showUnselectedLabels: true,
                    unselectedItemColor: Colors.grey.shade500,
                    unselectedLabelStyle: TextStyle(
                        color: Colors.grey.shade500,
                        fontWeight: FontWeight.w400),
                    selectedItemColor: Colors.black,
                    selectedLabelStyle: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                    items: const [
                      BottomNavigationBarItem(
                          icon: Icon(Icons.home), label: "Home"),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.people_outlined),
                          label: "Communities"),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.add), label: "Create"),
                      BottomNavigationBarItem(
                          icon: Icon(CupertinoIcons.chat_bubble_fill),
                          label: "Chat"),
                      BottomNavigationBarItem(
                          icon: Icon(CupertinoIcons.bell), label: "Inbox"),
                    ],
                  )
                : const SizedBox(),
          ),
          body: Obx(() => pages[bottomNavController.currentIndex.value]),
        ),
      ),
    );
  }

  showAlertDialogue(context, Size size) async {
    //Declaring Alert Dialogue
    AlertDialog alert = AlertDialog(
      content: Column(
        children: [
          SizedBox(
            height: size.height * 0.05,
          ),
          const Text("Are you sure you want to Exit?"),
          SizedBox(
            height: size.height * 0.05,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () {
                  SystemNavigator.pop();
                },
                child: const Text("Yes"),
              ),
              SizedBox(
                height: size.width * 0.05,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("No"),
              ),
            ],
          ),
        ],
      ),
    );

    //Displaying AlertDialogue
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showDiscardDialogue(context, Size size) async {
    //Declaring Alert Dialogue
    AlertDialog alert = AlertDialog(
      content: SizedBox(
        width: size.width * 0.95,
        child: SizedBox(
          height: size.height * 0.22,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Are you sure you want to Discard the Post?"),
              SizedBox(
                height: size.height * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      bottomNavController.currentIndex.value = 0;
                    },
                    child: const Text("Yes"),
                  ),
                  SizedBox(
                    height: size.width * 0.1,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("No"),
                  ),
                  SizedBox(
                    height: size.width * 0.075,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );

    //Displaying AlertDialogue
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Widget appBarText(size) {
    String header = '';
    switch (bottomNavController.currentIndex.value) {
      case 0:
        header = "Home";
        break;
      case 1:
        header = "Communities";
        break;
      case 3:
        header = "Chat";
        break;
      case 4:
        header = "Inbox";
        break;
    }

    return Text(
      header,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(fontSize: size.width * 0.05),
    );
  }
}
