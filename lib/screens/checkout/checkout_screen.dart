import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../controllers/payment_controller.dart';
import '../../controllers/cart_controller.dart';
import '../../controllers/auth_controller.dart';

class CheckoutScreen extends StatelessWidget {
  final PaymentController paymentController = Get.find();
  final CartController cartController = Get.find();
  final AuthController authController = Get.find();
  final TextEditingController addressController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Checkout', style: TextStyle(color: Colors.black))),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Delivery Address',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: addressController,
                decoration: InputDecoration(
                  hintText: 'Enter your full address with postal code',
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your address';
                  }
                  if (value.length < 10) {
                    return 'Please enter a complete address';
                  }
                  return null;
                },
              ),
              SizedBox(height: 30),
              Text(
                'Payment Method',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Obx(() => Column(
                    children: paymentController.paymentMethods
                        .map((method) => RadioListTile<String>(
                              title: Text(method),
                              value: method,
                              groupValue: paymentController.selectedPaymentMethod.value,
                              onChanged: (value) {
                                paymentController.selectedPaymentMethod.value = value!;
                              },
                            ))
                        .toList(),
                  )),
              SizedBox(height: 30),
              Text(
                'Order Summary',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Obx(() => Column(
                    children: cartController.cartItems.entries
                        .map((item) => ListTile(
                              leading: CachedNetworkImage(
                                imageUrl: item.key.imageUrl,
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.motorcycle),
                              ),
                              title: Text(item.key.name),
                              subtitle: Text('Qty: ${item.value}'),
                              trailing: Text(
                                  '\$${(item.key.price * item.value).toStringAsFixed(2)}'),
                            ))
                        .toList(),
                  )),
              Divider(),
              Obx(() => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '\$${cartController.totalPrice.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  )),
              SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      paymentController.placeOrder(
                        addressController.text,
                        paymentController.selectedPaymentMethod.value,
                      );
                    }
                  },
                  child: Text('Place Order'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}