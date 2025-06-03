
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/cart_controller.dart';
import '../controllers/auth_controller.dart';
import 'motorbike/motorbike_list_screen.dart';
import 'cart/cart_screen.dart';
import 'profile_screen.dart';

class MainWrapper extends StatefulWidget {
@override
_MainWrapperState createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
final CartController cartController = Get.find();
final AuthController authController = Get.find();
int _currentIndex = 0; // Track the current tab index manually

@override
Widget build(BuildContext context) {
return Scaffold(
body: Navigator(
key: Get.nestedKey(1),
initialRoute: '/motorbikes',
onGenerateRoute: (settings) {
if (settings.name == '/motorbikes') {
return GetPageRoute(
page: () => MotorbikeListScreen(),
transition: Transition.fadeIn,
);
} else if (settings.name == '/cart') {
return GetPageRoute(
page: () => CartScreen(),
transition: Transition.fadeIn,
);
} else if (settings.name == '/profile') {
return GetPageRoute(
page: () => ProfileScreen(),
transition: Transition.fadeIn,
);
}
return null;
},
),
bottomNavigationBar: Obx(() => BottomNavigationBar(
currentIndex: _currentIndex,
onTap: (index) => _handleNavigation(index),
items: [
BottomNavigationBarItem(
icon: Icon(Icons.home),
label: 'Home',
),
BottomNavigationBarItem(
icon: Stack(
children: [
Icon(Icons.shopping_cart),
if (cartController.totalItems > 0)
Positioned(
right: 0,
child: Container(
padding: EdgeInsets.all(2),
decoration: BoxDecoration(
color: Colors.red,
borderRadius: BorderRadius.circular(10),
),
constraints: BoxConstraints(
minWidth: 16,
minHeight: 16,
),
child: Text(
'${cartController.totalItems}',
style: TextStyle(
color: Colors.white,
fontSize: 10,
),
textAlign: TextAlign.center,
),
),
),
],
),
label: 'Cart',
),
BottomNavigationBarItem(
icon: Icon(authController.isLoggedIn ? Icons.person : Icons.login),
label: authController.isLoggedIn ? 'Profile' : 'Login',
),
],
)),
);
}

void _handleNavigation(int index) {
setState(() {
_currentIndex = index;
});
switch (index) {
case 0:
Get.offNamedUntil('/motorbikes', (route) => false, id: 1);
break;
case 1:
if (authController.isLoggedIn) {
Get.offNamedUntil('/cart', (route) => false, id: 1);
} else {
Get.toNamed('/login');
Get.snackbar('Login Required', 'Please login to view your cart');
setState(() {
_currentIndex = 0; // Reset to Home tab if not logged in
});
}
break;
case 2:
if (authController.isLoggedIn) {
Get.offNamedUntil('/profile', (route) => false, id: 1);
} else {
Get.toNamed('/login');
setState(() {
_currentIndex = 0; // Reset to Home tab if not logged in
});
}
break;
}
}
}
