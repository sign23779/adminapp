import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nodusteradminapp/model/order_model.dart';
import 'package:nodusteradminapp/views/order_details_screen/order_details_screen.dart';

class FinishedOrders extends StatelessWidget {
  const FinishedOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('orders')
              .doc('orders')
              .collection('finishedworks')
              .orderBy('datetime', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.docs.isNotEmpty) {
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    QueryDocumentSnapshot documentsnampshot =
                        snapshot.data!.docs[index];

                    return Card(
                      shadowColor: Colors.blueGrey[200],
                      elevation: 5,
                      child: ListTile(
                        onTap: () {
                          Get.to(
                            () => OrderDetailScreen(
                                orderModel: OrderModel(
                                    flatno: documentsnampshot['flatno'],
                                    paymentmethod:
                                        documentsnampshot['paymentmethod'],
                                    userphoneNumber:
                                        documentsnampshot['phonenum'],
                                    workfinishimage:
                                        documentsnampshot['workfinishimage'],
                                    workstartimage:
                                        documentsnampshot['workstartimage'],
                                    subcate: documentsnampshot['subcate'],
                                    contactname:
                                        documentsnampshot['contactname'],
                                    landmark: documentsnampshot['landmark'],
                                    totalprice: documentsnampshot['totalprice'],
                                    orderid: documentsnampshot['orderid'],
                                    mainservicename:
                                        documentsnampshot['mainservicename'],
                                    specificservicename: documentsnampshot[
                                        'specificservicename'],
                                    orderquantity:
                                        documentsnampshot['orderquantity'],
                                    price: documentsnampshot['price'],
                                    isPending: documentsnampshot['isPending'],
                                    isFinished: documentsnampshot['isFinished'],
                                    datetime: documentsnampshot['datetime'],
                                    address: documentsnampshot['address'])),
                          );
                        },
                        title: Text(documentsnampshot['specificservicename'],
                            maxLines: 1,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        trailing: const Text(
                          'Finished',
                          style: TextStyle(
                              color: Colors.green, fontWeight: FontWeight.bold),
                        ),
                      ),
                    );
                  },
                );
              } else {
                return const Center(
                    child: Text(
                  'No Finished Orders',
                  style: TextStyle(color: Colors.black),
                ));
              }
            } else if (snapshot.hasError) {
              return const Center(
                  child: Text(
                'There is no Data',
                style: TextStyle(color: Colors.black),
              ));
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
