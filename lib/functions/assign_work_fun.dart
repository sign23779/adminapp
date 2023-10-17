import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nodusteradminapp/model/order_model.dart';

Future assignwork(
    {required OrderModel orderModel, required String useremail}) async {
  final add = FirebaseFirestore.instance
      .collection('workers')
      .doc(orderModel.mainservicename)
      .collection(orderModel.specificservicename)
      .doc(useremail)
      .collection('Assignedworks')
      .doc(orderModel.datetime);

  final json = orderModel.toJson();
  await add.set(json);

  final updateavailable = FirebaseFirestore.instance
      .collection('workers')
      .doc(orderModel.mainservicename)
      .collection(orderModel.specificservicename)
      .doc(useremail);

  updateavailable.update({'isAvailable': false});

  final assignedwork =
      FirebaseFirestore.instance.collection('Assignedworks').doc(useremail);

  Map<String, dynamic> map = {
    'email': useremail,
  };
  await assignedwork.set(map);

  final assignedworkcollection = FirebaseFirestore.instance
      .collection('Assignedworks')
      .doc(useremail)
      .collection('pendingworks')
      .doc(orderModel.datetime);

  final assignedworkjson = orderModel.toJson();
  await assignedworkcollection.set(assignedworkjson);

  log('added');
}
