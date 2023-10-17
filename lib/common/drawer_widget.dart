import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nodusteradminapp/views/add_worker_screen/add_worker_screen.dart';
import 'package:nodusteradminapp/views/assigned_work_screen/assigned_work_screen.dart';
import 'package:nodusteradminapp/views/order_list_screen/order_list_screen.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: Colors.blue,
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: const Center(
              child: Text(
                'NO DUSTER',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.book, color: Color(0xff2b2b29)),
            title: const Text('Order List'),
            onTap: () => Get.to(const OrderListScreen()),
          ),
          ListTile(
            leading: const Icon(Icons.person, color: Color(0xff2b2b29)),
            title: const Text('Register Worker'),
            onTap: () => Get.to(const AddWorkerScreen()),
          ),
          ListTile(
            leading: const Icon(Icons.work_history, color: Color(0xff2b2b29)),
            title: const Text('Assigned Works'),
            onTap: () => Get.to(() => const AssignedWorkScreen()),
          ),
        ],
      ),
    );
  }
}
