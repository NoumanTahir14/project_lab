import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/motorbike.dart';

class CartController extends GetxController {
var cartItems = <Motorbike, int>{}.obs;
var isLoading = false.obs;

void addToCart(Motorbike motorbike) {
if (cartItems.containsKey(motorbike)) {
cartItems[motorbike] = cartItems[motorbike]! + 1;
} else {
cartItems[motorbike] = 1;
}
Get.snackbar(
"Added to Cart",
"${motorbike.name} was added!",
snackPosition: SnackPosition.BOTTOM,
backgroundColor: Colors.blue.withOpacity(0.9),
colorText: Colors.white,
);
}

void removeFromCart(Motorbike motorbike) {
if (cartItems[motorbike]! > 1) {
cartItems[motorbike] = cartItems[motorbike]! - 1;
} else {
cartItems.remove(motorbike);
}
}

void clearCart() {
cartItems.clear();
}

double get totalPrice => cartItems.entries.fold(
0, (sum, item) => sum + (item.key.price * item.value));

int get totalItems => cartItems.values.fold(0, (sum, qty) => sum + qty);
}
