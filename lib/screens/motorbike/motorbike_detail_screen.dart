import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../controllers/cart_controller.dart';
import '../../controllers/auth_controller.dart';
import '../../models/motorbike.dart';

class MotorbikeDetailScreen extends StatelessWidget {
  final CartController cartController = Get.find();
  final AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    final Motorbike motorbike = Get.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Motorbike Details', style: TextStyle(color: Colors.black)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 250,
              color: Colors.grey[200],
              child: Center(
                child: _buildImageWidget(motorbike.imageUrl),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    motorbike.name,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber),
                      SizedBox(width: 4),
                      Text('${motorbike.rating}'),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    '₨${motorbike.price.toStringAsFixed(2)}', // Updated to PKR symbol
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      _buildSpecItem(Icons.speed, motorbike.topSpeed),
                      SizedBox(width: 16),
                      _buildSpecItem(Icons.engineering, motorbike.engineSize),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    motorbike.description,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (authController.isLoggedIn) {
                          cartController.addToCart(motorbike);
                          Get.back();
                        } else {
                          Get.toNamed('/login');
                          Get.snackbar('Login Required',
                              'Please login to add items to cart');
                        }
                      },
                      child: Text('Add to Cart'),
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

  Widget _buildImageWidget(String imageUrl) {
    if (imageUrl.startsWith('assets/')) {
      return Image.asset(
        imageUrl,
        width: double.infinity,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) => Container(
          color: Colors.grey[200],
          child: Center(
            child: Icon(Icons.motorcycle, size: 100, color: Colors.grey[400]),
          ),
        ),
      );
    } else {
      return CachedNetworkImage(
        imageUrl: imageUrl,
        width: double.infinity,
        fit: BoxFit.contain,
        errorWidget: (context, url, error) => Container(
          color: Colors.grey[200],
          child: Center(
            child: Icon(Icons.motorcycle, size: 100, color: Colors.grey[400]),
          ),
        ),
      );
    }
  }

  Widget _buildSpecItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.blue),
        SizedBox(width: 8),
        Text(text, style: TextStyle(fontSize: 16)),
      ],
    );
  }
}