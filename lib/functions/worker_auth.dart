import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nodusteradminapp/common/snackbar.dart';
import 'package:nodusteradminapp/model/worker_model.dart';

class WorkerAuth {
  static Future signUp(
      {required WorkerModel workerModel, required context}) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: workerModel.email,
        password: workerModel.password,
      );

      final workerdetails = FirebaseFirestore.instance
          .collection('workers')
          .doc(workerModel.mainservice)
          .collection(workerModel.specificservice)
          .doc(workerModel.email);
      final workerdetailsjson = workerModel.toJson();
      await workerdetails.set(workerdetailsjson);

      log('new user created n added to databse');
      // Get.off(LoginScreen());
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(context: context, text: 'Invalid Email id');
      log(e.toString());
    }
  }

  // static Future login({required UserModel usermodel, required context}) async {
  //   UserCredential user;

  //   try {
  //     final user = await FirebaseAuth.instance
  //         .signInWithEmailAndPassword(
  //             email: usermodel.email, password: usermodel.password)
  //         .then((value) => {
  //               Navigator.of(context).pushReplacement(MaterialPageRoute(
  //                 builder: (context) => BottomNavScreen(),
  //               ))
  //             });

  //     return user;
  //   } on FirebaseAuthException catch (e) {
  //     Utils.showSnackBar(context: context, text: 'Enter Valid Email/Password');

  //     log(e.toString());
  //   }
  // }
}
