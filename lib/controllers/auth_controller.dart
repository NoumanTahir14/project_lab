import 'package:get/get.dart';
import '../models/user.dart';

class AuthController extends GetxController {
  final Rx<User?> _currentUser = Rx<User?>(null);
  User? get currentUser => _currentUser.value;
  bool get isLoggedIn => _currentUser.value != null;

  void login(String email, String password) {
    // Simulate API call
    Future.delayed(Duration(seconds: 1), () {
      _currentUser.value = User(
        id: 'user_${DateTime.now().millisecondsSinceEpoch}',
        email: email,
        name: email.split('@').first,
      );
      Get.offAllNamed('/home');
      Get.snackbar('Success', 'Logged in successfully');
    });
  }

  void signup(String email, String password, String name) {
    // Simulate API call
    Future.delayed(Duration(seconds: 1), () {
      _currentUser.value = User(
        id: 'user_${DateTime.now().millisecondsSinceEpoch}',
        email: email,
        name: name,
      );
      Get.offAllNamed('/home');
      Get.snackbar('Success', 'Account created successfully');
    });
  }

  void logout() {
    _currentUser.value = null;
    Get.offAllNamed('/home');
    Get.snackbar('Logged out', 'You have been logged out');
  }
}