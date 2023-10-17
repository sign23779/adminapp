// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:nodusteradminapp/common/snackbar.dart';
import 'package:nodusteradminapp/functions/assign_work_fun.dart';
import 'package:nodusteradminapp/model/order_model.dart';
import 'package:nodusteradminapp/model/worker_model.dart';
import 'package:url_launcher/url_launcher.dart';

class WorkerDetailScreen extends StatelessWidget {
  const WorkerDetailScreen(
      {super.key, required this.workerModel, required this.orderModel});

  final WorkerModel workerModel;
  final OrderModel orderModel;

  void openPdf(context) async {
    final url = workerModel.pdf.toString();

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      Utils.showSnackBar(
          context: context, text: 'Could not launch PDF, please try again');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Worker Details'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(workerModel.image.toString()),
              ),
              const SizedBox(height: 20),
              Text(
                workerModel.username,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                workerModel.mainservice,
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
              const SizedBox(height: 20),
              const Text(
                'Contact Information',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              ListTile(
                leading: const Icon(Icons.email),
                title: Text(workerModel.email),
              ),
              ListTile(
                leading: const Icon(Icons.phone),
                title: Text(workerModel.phonenumber),
              ),
              ListTile(
                leading: const Icon(Icons.location_on),
                title: Text(workerModel.address),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  openPdf(context);
                },
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  primary: Colors.blue,
                ),
                child: const Text(
                  'Download Aadhar Card',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  assignwork(
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
                      specificservicename: orderModel.specificservicename,
                      orderquantity: orderModel.orderquantity,
                      price: orderModel.price,
                      isPending: orderModel.isPending,
                      isFinished: orderModel.isFinished,
                      datetime: orderModel.datetime,
                      address: orderModel.address,
                    ),
                    useremail: workerModel.email,
                  );

                  Utils.showSnackBar(
                    context: context,
                    text: 'Work assigned to ${workerModel.username}',
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  primary: Colors.green,
                ),
                child: const Text(
                  'Assign Work',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
