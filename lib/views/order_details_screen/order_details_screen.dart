import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nodusteradminapp/model/order_model.dart';
import 'package:nodusteradminapp/views/workers_list_screen/workers_list_screen.dart';

class OrderDetailScreen extends StatelessWidget {
  const OrderDetailScreen({Key? key, required this.orderModel})
      : super(key: key);

  final OrderModel orderModel;

  @override
  Widget build(BuildContext context) {
    log(orderModel.isFinished.toString());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Details'),
        centerTitle: true,
      ),
      backgroundColor: Colors.grey[200],
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView(
                children: [
                  _buildDetailTile(
                    title: 'Contact Name',
                    value: orderModel.contactname,
                    icon: Icons.person,
                  ),
                  _buildDetailTile(
                    title: 'Google Map Address',
                    value: orderModel.address,
                    icon: Icons.location_on,
                  ),
                  _buildDetailTile(
                    title: 'Flat No',
                    value: orderModel.flatno,
                    icon: Icons.home,
                  ),
                  _buildDetailTile(
                    title: 'Landmark',
                    value: orderModel.landmark,
                    icon: Icons.location_city,
                  ),
                  _buildDetailTile(
                    title: 'Ordered Time',
                    value: orderModel.datetime.substring(1, 19),
                    icon: Icons.access_time,
                  ),
                  _buildDetailTile(
                    title: 'Categories',
                    value: orderModel.mainservicename,
                    icon: Icons.category,
                  ),
                  _buildDetailTile(
                    title: 'Order ID',
                    value: orderModel.orderid,
                    icon: Icons.confirmation_number,
                  ),
                  _buildDetailTile(
                    title: 'Order Quantity',
                    value: orderModel.orderquantity.toString(),
                    icon: Icons.shopping_cart,
                  ),
                  _buildDetailTile(
                    title: 'Price',
                    value: orderModel.price.toString(),
                    icon: Icons.attach_money,
                  ),
                  _buildDetailTile(
                    title: 'Total Price',
                    value: orderModel.totalprice.toString(),
                    icon: Icons.monetization_on,
                  ),
                  _buildDetailTile(
                    title: 'Specific Service Name',
                    value: orderModel.specificservicename,
                    icon: Icons.assignment,
                  ),
                  _buildDetailTile(
                    title: 'Subcategory',
                    value: orderModel.subcate,
                    icon: Icons.subtitles,
                  ),
                  _buildDetailTile(
                    title: 'Phone number',
                    value: orderModel.userphoneNumber,
                    icon: Icons.phone,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            Align(
                alignment: Alignment.bottomCenter,
                child: orderModel.isFinished == false
                    ? ElevatedButton(
                        onPressed: () {
                          Get.to(
                            WorkersList(
                              orderModel: OrderModel(
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
                                  address: orderModel.address,
                                  flatno: orderModel.flatno,
                                  paymentmethod: orderModel.paymentmethod,
                                  userphoneNumber: orderModel.userphoneNumber,
                                  workfinishimage: orderModel.workfinishimage,
                                  workstartimage: orderModel.workstartimage),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 1.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20.0,
                            vertical: 16.0,
                          ),
                        ),
                        child: const Text(
                          'Assign Work to Workers',
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    : const SizedBox()),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailTile({
    required String title,
    required String value,
    required IconData icon,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      subtitle: Text(
        value,
        style: const TextStyle(fontSize: 16.0, color: Colors.black),
      ),
    );
  }
}
