import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../controllers/cart_controller.dart';
import '../../controllers/auth_controller.dart';
import '../../models/motorbike.dart';

class CartScreen extends StatelessWidget {
final CartController cartController = Get.find();
final AuthController authController = Get.find();

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: Text('Your Cart', style: TextStyle(color: Colors.black)),
actions: [
Obx(() => cartController.cartItems.isEmpty
? SizedBox()
    : IconButton(
icon: Icon(Icons.delete),
onPressed: () => cartController.clearCart(),
)),
],
),
body: Obx(
() => cartController.cartItems.isEmpty
? Center(
child: Column(
mainAxisAlignment: MainAxisAlignment.center,
children: [
Icon(Icons.shopping_cart, size: 100, color: Colors.grey),
SizedBox(height: 16),
Text(
'Your cart is empty',
style: TextStyle(
fontSize: 20,
color: Colors.grey,
),
),
SizedBox(height: 8),
Text(
'Browse our motorbikes and add some items',
style: TextStyle(color: Colors.grey),
),
SizedBox(height: 24),
ElevatedButton(
onPressed: () => Get.offAllNamed('/home'),
child: Text('Continue Shopping'),
),
],
),
)
    : Column(
children: [
Expanded(
child: ListView.builder(
padding: EdgeInsets.all(16),
itemCount: cartController.cartItems.length,
itemBuilder: (context, index) {
final motorbike =
cartController.cartItems.keys.elementAt(index);
final quantity = cartController.cartItems[motorbike]!;
return Card(
elevation: 2,
margin: EdgeInsets.symmetric(vertical: 8),
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(12),
),
child: ListTile(
contentPadding: EdgeInsets.all(12),
leading: ClipRRect(
borderRadius: BorderRadius.circular(8),
child: CachedNetworkImage(
imageUrl: motorbike.imageUrl,
width: 60,
height: 60,
fit: BoxFit.cover,
errorWidget: (context, url, error) =>
Icon(Icons.motorcycle),
),
),
title: Text(motorbike.name),
subtitle: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text('\$${motorbike.price.toStringAsFixed(2)} each'),
SizedBox(height: 4),
Row(
children: [
IconButton(
icon: Icon(Icons.remove_circle_outline,
size: 20),
onPressed: () =>
cartController.removeFromCart(motorbike),
),
Text('$quantity', style: TextStyle(fontSize: 16)),
IconButton(
icon: Icon(Icons.add_circle_outline, size: 20),
onPressed: () =>
cartController.addToCart(motorbike),
),
],
),
],
),
trailing: Text(
'\$${(motorbike.price * quantity).toStringAsFixed(2)}',
style: TextStyle(
fontWeight: FontWeight.bold,
fontSize: 16,
),
),
),
);
},
),
),
Container(
padding: EdgeInsets.all(20),
decoration: BoxDecoration(
color: Theme.of(context).cardColor,
boxShadow: [
BoxShadow(
color: Colors.black12,
blurRadius: 10,
offset: Offset(0, -5),
),
],
borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
),
child: Column(
children: [
Row(
mainAxisAlignment: MainAxisAlignment.spaceBetween,
children: [
Text(
'Subtotal:',
style: TextStyle(fontSize: 16),
),
Text(
'\$${cartController.totalPrice.toStringAsFixed(2)}',
style: TextStyle(
fontSize: 16,
fontWeight: FontWeight.bold,
),
),
],
),
Divider(height: 24),
Row(
mainAxisAlignment: MainAxisAlignment.spaceBetween,
children: [
Text(
'Total:',
style: TextStyle(
fontSize: 20,
fontWeight: FontWeight.bold,
),
),
Text(
'\$${cartController.totalPrice.toStringAsFixed(2)}',
style: TextStyle(
fontSize: 20,
fontWeight: FontWeight.bold,
color: Colors.blue,
),
),
],
),
SizedBox(height: 16),
SizedBox(
width: double.infinity,
child: ElevatedButton(
onPressed: () {
if (authController.isLoggedIn) {
Get.toNamed('/checkout');
} else {
Get.toNamed('/login');
Get.snackbar('Login Required',
'Please login to proceed to checkout');
}
},
child: Text('Proceed to Checkout'),
),
),
],
),
),
],
),
),
);
}
}
