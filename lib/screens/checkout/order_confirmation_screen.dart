import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/payment_controller.dart';

class OrderConfirmationScreen extends StatelessWidget {
  final PaymentController paymentController = Get.find();

  @override
  Widget build(BuildContext context) {
    final order = paymentController.orders.last;

    return Scaffold(
      appBar: AppBar(
        title: Text('Order Confirmation', style: TextStyle(color: Colors.black)),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.check_circle, color: Colors.green, size: 100),
              SizedBox(height: 20),
              Text(
                'Order Placed Successfully!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              Card(
                child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text(
                          'Order #${order.id.substring(0, 8)}',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Date: ${order.date.day}/${order.date.month}/${order.date.year}',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Total: \$${order.total.toStringAsFixed(2)}',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Payment Method: ${order.paymentMethod}',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    )),
              ),
              SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Get.offAllNamed('/home'),
                  child: Text('Continue Shopping'),
                ),
              ),
              SizedBox(height: 15),
              TextButton(
                onPressed: () => Get.toNamed('/order-history'),
                child: Text('View Order History'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}