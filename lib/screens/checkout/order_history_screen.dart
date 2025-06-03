import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../controllers/payment_controller.dart';

class OrderHistoryScreen extends StatelessWidget {
  final PaymentController paymentController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Order History', style: TextStyle(color: Colors.black))),
      body: Obx(() => paymentController.orders.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.history, size: 60, color: Colors.grey),
                  SizedBox(height: 20),
                  Text(
                    'No orders yet',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => Get.offAllNamed('/home'),
                    child: Text('Browse Motorbikes'),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: paymentController.orders.length,
              itemBuilder: (context, index) {
                final order = paymentController.orders.reversed.toList()[index];
                return Card(
                  margin: EdgeInsets.only(bottom: 16),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Order #${order.id.substring(0, 8)}',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '${order.date.day}/${order.date.month}/${order.date.year}',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Total: \$${order.total.toStringAsFixed(2)}',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Payment: ${order.paymentMethod}',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Items: ${order.items.length}',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            Get.defaultDialog(
                              title: 'Order Details',
                              content: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Order #${order.id.substring(0, 8)}',
                                        style:
                                            TextStyle(fontWeight: FontWeight.bold)),
                                    SizedBox(height: 10),
                                    Text('Date: ${order.date.toString()}'),
                                    SizedBox(height: 10),
                                    Text(
                                        'Total: \$${order.total.toStringAsFixed(2)}'),
                                    SizedBox(height: 10),
                                    Text('Payment: ${order.paymentMethod}'),
                                    SizedBox(height: 10),
                                    Text('Address: ${order.address}'),
                                    SizedBox(height: 20),
                                    Text('Items:',
                                        style:
                                            TextStyle(fontWeight: FontWeight.bold)),
                                    ...order.items.map((item) => ListTile(
                                          leading: CachedNetworkImage(
                                            imageUrl: item['imageUrl'],
                                            width: 40,
                                            height: 40,
                                            fit: BoxFit.cover,
                                            errorWidget: (context, url, error) =>
                                                Icon(Icons.motorcycle),
                                          ),
                                          title: Text(item['name']),
                                          subtitle: Text('Qty: ${item['quantity']}'),
                                          trailing: Text(
                                              '\$${(item['price'] * item['quantity']).toStringAsFixed(2)}'),
                                        )),
                                  ],
                                ),
                              ),
                            );
                          },
                          child: Text('View Details'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue[50],
                            foregroundColor: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            )),
    );
  }
}