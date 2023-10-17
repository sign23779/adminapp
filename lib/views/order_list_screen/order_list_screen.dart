import 'package:flutter/material.dart';
import 'package:nodusteradminapp/common/drawer_widget.dart';
import 'package:nodusteradminapp/views/order_list_screen/finished_orders.dart';
import 'package:nodusteradminapp/views/order_list_screen/pending_order.dart';

class OrderListScreen extends StatelessWidget {
  const OrderListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Order List'),
            centerTitle: true,
            bottom: const TabBar(tabs: [
              Tab(
                  text: 'Pending Orders',
                  icon: Icon(Icons.pending_actions_outlined)),
              Tab(text: 'Finished orders', icon: Icon(Icons.beenhere))
            ]),
          ),
          drawer: const DrawerWidget(),
          body:
              const TabBarView(children: [PendingOrders(), FinishedOrders()])),
    );
  }
}
