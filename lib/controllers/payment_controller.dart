import 'package:get/get.dart';
import '../models/order.dart';
import 'cart_controller.dart';
import 'auth_controller.dart';

class PaymentController extends GetxController {
  final CartController cartController = Get.find();
  final AuthController authController = Get.find();
  var paymentMethods = ['Credit Card', 'PayPal', 'Bank Transfer'];
  var selectedPaymentMethod = 'Credit Card'.obs;
  var orders = <Order>[].obs;

  void placeOrder(String address, String paymentMethod) {
    if (authController.currentUser == null) {
      Get.snackbar('Error', 'You must be logged in to place an order');
      return;
    }

    if (cartController.cartItems.isEmpty) {
      Get.snackbar('Error', 'Your cart is empty');
      return;
    }

    final order = Order(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      date: DateTime.now(),
      total: cartController.totalPrice,
      items: cartController.cartItems.entries
          .map((e) => {
                'id': e.key.id,
                'name': e.key.name,
                'quantity': e.value,
                'price': e.key.price,
                'imageUrl': e.key.imageUrl,
              })
          .toList(),
      address: address,
      paymentMethod: paymentMethod,
    );

    orders.add(order);
    cartController.clearCart();
    Get.offAllNamed('/order-confirmation');
  }
}