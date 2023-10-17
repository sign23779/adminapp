import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

import 'dart:developer';

import 'package:image_picker/image_picker.dart';

class Images {
  static List addimage(String imgurl, List images) {
    images.add(imgurl);
    return images;
  }

  static Future<XFile?> selectimage() async {
    // ignore: non_constant_identifier_names
    final XFile = imagePicker.pickImage(source: ImageSource.gallery);
    return XFile;
  }

  static ImagePicker imagePicker = ImagePicker();

  static Future<String> uploadimage(XFile image) async {
    final path = 'images/${image.name}';
    final file = File(image.path);

    final ref = FirebaseStorage.instance.ref().child(path);
    final uploadTask = ref.putFile(file);

    final snap =
        await uploadTask.whenComplete(() => log(image.name.toString()));

    final imageurl = await snap.ref.getDownloadURL();
    log('is returning imageurl-------- $imageurl ');
    return imageurl;
  }

  static Future<String?> getimage() async {
    final xfile = await Images.selectimage();
    if (xfile != null) {
      String imageurlimg = await Images.uploadimage(xfile);
      return imageurlimg;
    } else {
      return null;
    }
  }
}
