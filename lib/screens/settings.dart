import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reddit/images.dart';

class Settings extends StatelessWidget {
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Settings"),
          backgroundColor: Colors.white,
          shadowColor: Colors.black,
          elevation: 3,
          systemOverlayStyle:
              SystemUiOverlayStyle(statusBarColor: Colors.transparent),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              //General
              Container(
                width: double.infinity,
                height: size.height * 0.05,
                color: Colors.grey.shade200,
                child: Row(
                  children: [
                    SizedBox(
                      width: size.width * 0.05,
                    ),
                    Text("General"),
                  ],
                ),
              ),
              ListTile(
                leading: Icon(Icons.person),
                title: Text(
                  "Account Settings for ${auth.currentUser!.displayName.toString()}",
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: Icon(Icons.arrow_right),
              ),

              //Premium
              Container(
                width: double.infinity,
                height: size.height * 0.05,
                color: Colors.grey.shade200,
                child: Row(
                  children: [
                    SizedBox(
                      width: size.width * 0.05,
                    ),
                    Text("Premium"),
                  ],
                ),
              ),
              const ListTile(
                leading: Icon(Icons.workspace_premium),
                title: Text(
                  "Get Premium",
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: Icon(Icons.arrow_right),
              ),
              ListTile(
                leading: CircleAvatar(
                  radius: size.width * 0.04,
                  backgroundImage: AssetImage(appIcon),
                ),
                title: Text(
                  "Change App Icon",
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: Icon(Icons.arrow_right),
              ),
              ListTile(
                leading: CircleAvatar(
                  radius: size.width * 0.04,
                  backgroundImage:
                      AssetImage(auth.currentUser!.photoURL.toString()),
                ),
                title: Text(
                  "Change Avatar",
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: Icon(Icons.arrow_right),
              ),

              //Language
              Container(
                width: double.infinity,
                height: size.height * 0.05,
                color: Colors.grey.shade200,
                child: Row(
                  children: [
                    SizedBox(
                      width: size.width * 0.05,
                    ),
                    Text("Language"),
                  ],
                ),
              ),
              const ListTile(
                leading: Icon(Icons.language),
                title: Text(
                  "Language",
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: Icon(Icons.arrow_right),
              ),
              const ListTile(
                leading: Icon(Icons.language),
                title: Text(
                  "Content Languages",
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: Icon(Icons.arrow_right),
              ),

              //View Options
              Container(
                width: double.infinity,
                height: size.height * 0.05,
                color: Colors.grey.shade200,
                child: Row(
                  children: [
                    SizedBox(
                      width: size.width * 0.05,
                    ),
                    Text("View Options"),
                  ],
                ),
              ),
              const ListTile(
                leading: Icon(Icons.view_agenda),
                title: Text(
                  "Default View",
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: Icon(Icons.arrow_right),
              ),
              const ListTile(
                leading: Icon(Icons.play_arrow),
                title: Text(
                  "Autoplay",
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: Icon(Icons.arrow_right),
              ),
              const ListTile(
                leading: Icon(Icons.photo),
                title: Text(
                  "Thumbnails",
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: Icon(Icons.arrow_right),
              ),
              const ListTile(
                leading: Icon(Icons.remove_red_eye),
                title: Text(
                  "Reduce Animations",
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: Icon(Icons.arrow_right),
              ),
              const ListTile(
                leading: Icon(Icons.person),
                title: Text(
                  "Show NSFW content(I'm over 18)",
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: Icon(Icons.arrow_right),
              ),
              const ListTile(
                leading: Icon(Icons.eighteen_up_rating),
                title: Text(
                  "Blur NSFW Images",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.grey),
                ),
                trailing: Icon(Icons.arrow_right),
              ),

              //DarkMode
              Container(
                width: double.infinity,
                height: size.height * 0.05,
                color: Colors.grey.shade200,
                child: Row(
                  children: [
                    SizedBox(
                      width: size.width * 0.05,
                    ),
                    Text("Dark Mode"),
                  ],
                ),
              ),
              const ListTile(
                leading: Icon(Icons.settings),
                title: Text(
                  "Auto Dark Mode",
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: Icon(Icons.arrow_right),
              ),
              const ListTile(
                leading: Icon(Icons.dark_mode),
                title: Text(
                  "Dark mode",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.grey),
                ),
                trailing: Icon(Icons.arrow_right),
              ),
              const ListTile(
                leading: Icon(Icons.light_mode),
                title: Text(
                  "Light Theme",
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: Icon(Icons.arrow_right),
              ),
              const ListTile(
                leading: Icon(Icons.dark_mode),
                title: Text(
                  "Dark Theme",
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: Icon(Icons.arrow_right),
              ),

              //Advanced
              Container(
                width: double.infinity,
                height: size.height * 0.05,
                color: Colors.grey.shade200,
                child: Row(
                  children: [
                    SizedBox(
                      width: size.width * 0.05,
                    ),
                    Text("Advanced"),
                  ],
                ),
              ),
              const ListTile(
                leading: Icon(Icons.photo),
                title: Text(
                  "Saved Image attribution",
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: Icon(Icons.arrow_right),
              ),
              const ListTile(
                leading: Icon(Icons.keyboard_arrow_down_sharp),
                title: Text(
                  "Comment jump button",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.grey),
                ),
                trailing: Icon(Icons.arrow_right),
              ),
              const ListTile(
                leading: Icon(Icons.mode_comment_outlined),
                title: Text(
                  "Default Comment Sort",
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: Icon(Icons.arrow_right),
              ),
              const ListTile(
                leading: Icon(Icons.help),
                title: Text(
                  "Export Video Log",
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: Icon(Icons.arrow_right),
              ),

              //About
              Container(
                width: double.infinity,
                height: size.height * 0.05,
                color: Colors.grey.shade200,
                child: Row(
                  children: [
                    SizedBox(
                      width: size.width * 0.05,
                    ),
                    Text("About"),
                  ],
                ),
              ),
              const ListTile(
                leading: Icon(Icons.text_snippet_outlined),
                title: Text(
                  "Content Policy",
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: Icon(Icons.arrow_right),
              ),
              const ListTile(
                leading: Icon(Icons.settings),
                title: Text(
                  "Privacy Policy",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.grey),
                ),
                trailing: Icon(Icons.arrow_right),
              ),
              const ListTile(
                leading: Icon(Icons.person_outline_outlined),
                title: Text(
                  "User Agreement",
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: Icon(Icons.arrow_right),
              ),
              const ListTile(
                leading: Icon(Icons.text_snippet_outlined),
                title: Text(
                  "Acknowledgements",
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: Icon(Icons.arrow_right),
              ),

              //Support
              Container(
                width: double.infinity,
                height: size.height * 0.05,
                color: Colors.grey.shade200,
                child: Row(
                  children: [
                    SizedBox(
                      width: size.width * 0.05,
                    ),
                    Text("Support"),
                  ],
                ),
              ),
              const ListTile(
                leading: Icon(Icons.help),
                title: Text(
                  "Help Center",
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: Icon(Icons.arrow_right),
              ),
              ListTile(
                leading: CircleAvatar(
                  radius: size.width * 0.04,
                  backgroundImage: AssetImage(appIcon),
                ),
                title: Text(
                  "Visit r/redditmobile",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.grey),
                ),
                trailing: Icon(Icons.arrow_right),
              ),
              const ListTile(
                leading: Icon(Icons.mail_outline),
                title: Text(
                  "Report an issue",
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: Icon(Icons.arrow_right),
              ),

              //Build Information
              Container(
                width: double.infinity,
                height: size.height * 0.05,
                color: Colors.grey.shade200,
                child: Row(
                  children: [
                    SizedBox(
                      width: size.width * 0.05,
                    ),
                    Text("Build Information"),
                  ],
                ),
              ),
              const ListTile(
                leading: Icon(Icons.help),
                title: Text(
                  "2023.50.1.1345844",
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: Icon(Icons.arrow_right),
              ),
              Divider(
                color: Colors.grey.shade300,
              ),

              SizedBox(
                height: size.height * 0.03,
              ),

              Text(
                "Updates",
                style: TextStyle(
                    fontSize: size.width * 0.08, fontWeight: FontWeight.bold),
              ),
              const ListTile(
                leading: Icon(Icons.add),
                title: Text("Communities Section to be added"),
              ),
              const ListTile(
                leading: Icon(Icons.add),
                title: Text("Inbox Section to be Added"),
              ),
              const ListTile(
                leading: Icon(Icons.add),
                title: Text("Functional Settings tab to be added"),
              ),
              const Text(
                "And Much More Soon...",
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              const Text(
                "v26.08.20.04",
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
