import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class ImageService
{
  static Future<String> uploadImage()
  async{

    final currentUserUid = FirebaseAuth.instance.currentUser!.uid;


    final img = await ImagePicker.platform.getImageFromSource(source: ImageSource.gallery);

    if(img!=null) {

      File imgPath = File(img.path);

      final destination = "Posts/$currentUserUid/";

      final ref = FirebaseStorage.instance.ref(destination).child("post1");

      await ref.putFile(imgPath);

      String imgUrl = await ref.getDownloadURL();

      return imgUrl;

    }
    else{
      print("No Image Selected");
    }

    return "";

  }
}