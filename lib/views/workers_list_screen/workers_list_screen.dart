import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nodusteradminapp/model/order_model.dart';
import 'package:nodusteradminapp/model/worker_model.dart';
import 'package:nodusteradminapp/views/worker_details_screen/worker_details_screen.dart';

class WorkersList extends StatelessWidget {
  const WorkersList({Key? key, required this.orderModel}) : super(key: key);

  final OrderModel orderModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(orderModel.specificservicename),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: StreamBuilder<List<WorkerModel>>(
            stream: FirebaseFirestore.instance
                .collection('workers')
                .doc(orderModel.mainservicename)
                .collection(orderModel.specificservicename)
                .snapshots()
                .map((event) => event.docs
                    .map((e) => WorkerModel.fromJson(e.data()))
                    .toList()),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    List<WorkerModel> workerlist = snapshot.data!;
                    return Card(
                      shadowColor: Colors.amber,
                      elevation: 5,
                      child: ListTile(
                          onTap: () {
                            Get.to(WorkerDetailScreen(
                              workerModel: WorkerModel(
                                  username: workerlist[index].username,
                                  email: workerlist[index].email,
                                  password: workerlist[index].password,
                                  datetime: workerlist[index].datetime,
                                  phonenumber: workerlist[index].phonenumber,
                                  postalcode: workerlist[index].postalcode,
                                  address: workerlist[index].address,
                                  mainservice: workerlist[index].mainservice,
                                  specificservice:
                                      workerlist[index].specificservice,
                                  pdf: workerlist[index].pdf,
                                  isAvailable: workerlist[index].isAvailable,
                                  image: workerlist[index].image),
                              orderModel: OrderModel(
                                  flatno: orderModel.flatno,
                                  paymentmethod: orderModel.paymentmethod,
                                  userphoneNumber: orderModel.userphoneNumber,
                                  workfinishimage: orderModel.workfinishimage,
                                  workstartimage: orderModel.workstartimage,
                                  subcate: orderModel.subcate,
                                  contactname: orderModel.contactname,
                                  landmark: orderModel.landmark,
                                  totalprice: orderModel.totalprice,
                                  orderid: orderModel.orderid,
                                  mainservicename: orderModel.mainservicename,
                                  specificservicename:
                                      orderModel.specificservicename,
                                  orderquantity: orderModel.orderquantity,
                                  price: orderModel.price,
                                  isPending: orderModel.isPending,
                                  isFinished: orderModel.isFinished,
                                  datetime: orderModel.datetime,
                                  address: orderModel.address),
                            ));
                          },
                          title: Text(workerlist[index].username,
                              maxLines: 1,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          subtitle: Text(workerlist[index].email,
                              maxLines: 1,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          trailing: Icon(
                            Icons.circle,
                            color: workerlist[index].isAvailable == true
                                ? Colors.green
                                : Colors.red,
                            size: 20,
                          )),
                    );
                  },
                );
              } else {
                return const Text(
                  'No Data',
                  style: TextStyle(color: Colors.black),
                );
              }
            }),
      ),
    );
  }
}
