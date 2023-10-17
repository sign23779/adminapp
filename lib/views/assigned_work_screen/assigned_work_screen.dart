import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nodusteradminapp/common/colors.dart';
import 'package:nodusteradminapp/common/drawer_widget.dart';
import 'package:nodusteradminapp/views/assigned_work_screen/inside_assigned_work.dart';

class AssignedWorkScreen extends StatelessWidget {
  const AssignedWorkScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Assigned Works'),
        centerTitle: true,
      ),
      drawer: const DrawerWidget(),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('Assignedworks')
                // .orderBy('datetime', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
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
                          // Get.to(
                          //   () => OrderDetailScreen(
                          //       orderModel: OrderModel(
                          //           subcate: documentsnampshot['subcate'],
                          //           contactname: documentsnampshot['contactname'],
                          //           landmark: documentsnampshot['landmark'],
                          //           totalprice: documentsnampshot['totalprice'],
                          //           orderid: documentsnampshot['orderid'],
                          //           mainservicename:
                          //               documentsnampshot['mainservicename'],
                          //           specificservicename:
                          //               documentsnampshot['specificservicename'],
                          //           orderquantity:
                          //               documentsnampshot['orderquantity'],
                          //           price: documentsnampshot['price'],
                          //           isPending: documentsnampshot['isPending'],
                          //           isFinished: documentsnampshot['isFinished'],
                          //           datetime: documentsnampshot['datetime'],
                          //           address: documentsnampshot['address'])),
                          // );
                          Get.to(() => InsideAssignedWorkScreen(
                              email: documentsnampshot['email']));
                        },
                        title: Text(documentsnampshot['email'],
                            maxLines: 1,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        trailing: IconButton(
                            onPressed: () {
                              // delectcategories(
                              //     categories: documentsnampshot['name']);
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: kred,
                            )),
                      ),
                    );
                  },
                );
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
      ),
    );
  }
}
