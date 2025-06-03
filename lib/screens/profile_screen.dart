import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class ProfileScreen extends StatelessWidget {
  final AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile', style: TextStyle(color: Colors.black)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (authController.currentUser != null) ...[
              CircleAvatar(
                radius: 50,
                child: Text(
                  authController.currentUser!.name.substring(0, 1),
                  style: TextStyle(fontSize: 40),
                ),
              ),
              SizedBox(height: 20),
              Text(
                authController.currentUser!.name,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(authController.currentUser!.email),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () => Get.toNamed('/order-history'),
                child: Text('View Order History'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  authController.logout();
                  Get.offNamedUntil('/home', (route) => false);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[50],
                  foregroundColor: Colors.red,
                ),
                child: Text('Logout'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}