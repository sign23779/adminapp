import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class InsideAssignedWorkScreen extends StatelessWidget {
  const InsideAssignedWorkScreen({Key? key, required this.email})
      : super(key: key);

  final String email;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: const Text('work'),
            centerTitle: true,
            bottom: const TabBar(tabs: [
              Tab(
                  text: 'Pending Works',
                  icon: Icon(Icons.pending_actions_outlined)),
              Tab(text: 'Finished Works', icon: Icon(Icons.beenhere))
            ]),
          ),
          body: TabBarView(children: [
            Pendingworks(email: email),
            Finishedworks(email: email)
          ])),
    );
  }
}

class Pendingworks extends StatelessWidget {
  const Pendingworks({
    super.key,
    required this.email,
  });

  final String email;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Assignedworks')
              .doc(email)
              .collection('pendingworks')
              .orderBy('datetime', descending: true)
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
                        //           contactname:
                        //               documentsnampshot['contactname'],
                        //           landmark: documentsnampshot['landmark'],
                        //           totalprice: documentsnampshot['totalprice'],
                        //           orderid: documentsnampshot['orderid'],
                        //           mainservicename:
                        //               documentsnampshot['mainservicename'],
                        //           specificservicename: documentsnampshot[
                        //               'specificservicename'],
                        //           orderquantity:
                        //               documentsnampshot['orderquantity'],
                        //           price: documentsnampshot['price'],
                        //           isPending: documentsnampshot['isPending'],
                        //           isFinished: documentsnampshot['isFinished'],
                        //           datetime: documentsnampshot['datetime'],
                        //           address: documentsnampshot['address'])),
                        // );
                      },
                      title: Text(documentsnampshot['subcate'],
                          maxLines: 1,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      subtitle: const Text('Pending',
                          maxLines: 1,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.red)),
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
    );
  }
}

class Finishedworks extends StatelessWidget {
  const Finishedworks({
    super.key,
    required this.email,
  });

  final String email;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Assignedworks')
              .doc(email)
              .collection('finishedworks')
              .orderBy('datetime', descending: true)
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
                        //           contactname:
                        //               documentsnampshot['contactname'],
                        //           landmark: documentsnampshot['landmark'],
                        //           totalprice: documentsnampshot['totalprice'],
                        //           orderid: documentsnampshot['orderid'],
                        //           mainservicename:
                        //               documentsnampshot['mainservicename'],
                        //           specificservicename: documentsnampshot[
                        //               'specificservicename'],
                        //           orderquantity:
                        //               documentsnampshot['orderquantity'],
                        //           price: documentsnampshot['price'],
                        //           isPending: documentsnampshot['isPending'],
                        //           isFinished: documentsnampshot['isFinished'],
                        //           datetime: documentsnampshot['datetime'],
                        //           address: documentsnampshot['address'])),
                        // );
                      },
                      title: Text(documentsnampshot['subcate'],
                          maxLines: 1,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      subtitle: const Text('Finished',
                          maxLines: 1,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.green)),
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
    );
  }
}
