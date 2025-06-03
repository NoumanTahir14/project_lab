import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../controllers/cart_controller.dart';
import '../../controllers/auth_controller.dart';
import '../../models/motorbike.dart';

class MotorbikeListScreen extends StatefulWidget {
  @override
  _MotorbikeListScreenState createState() => _MotorbikeListScreenState();
}

class _MotorbikeListScreenState extends State<MotorbikeListScreen> {
  final CartController cartController = Get.find();
  final AuthController authController = Get.find();
  final RxString searchQuery = ''.obs;
  final RxList<Motorbike> filteredMotorbikes = RxList<Motorbike>();

  final List<Motorbike> motorbikes = [
    Motorbike(
      id: '1',
      name: 'DUCATI-250',
      description: 'Sporty street bike with agile handling and excellent fuel efficiency. Perfect for city commuting and weekend rides.',
      price: 750000,
      imageUrl: 'assets/images/OW_DUCATI_250.jpg',
      rating: 4.7,
      engineSize: "250cc",
      topSpeed: "120 km/h",
    ),
    Motorbike(
      id: '2',
      name: 'BMW S1000RR',
      description: 'Premium touring bike with comfortable ride and advanced suspension system. Designed for long distance journeys with ample storage space.',
      price: 9600000,
      imageUrl: 'assets/images/S100RR.jpg',
      rating: 4.8,
      engineSize: "1000cc",
      topSpeed: "299 km/h",
    ),
    Motorbike(
      id: '3',
      name: 'KAWASAKI-NINJA-650',
      description: 'Classic cruiser with vintage styling and modern reliability. Features a low seat height for easy handling and a distinctive exhaust note.',
      price: 8400000,
      imageUrl: 'assets/images/KAWASAKI_Ninja_650.jpg',
      rating: 4.3,
      engineSize: "650cc",
      topSpeed: "240 km/h",
    ),
    Motorbike(
      id: '4',
      name: 'YAMAHA-R15',
      description: 'Race-inspired performance bike with aerodynamic design. Features a liquid-cooled engine and sporty riding position for maximum control.',
      price: 700000,
      imageUrl: 'assets/images/YAHMAHA_R15.jpg',
      rating: 4.9,
      engineSize: "150cc",
      topSpeed: "135 km/h",
    ),
    Motorbike(
      id: '5',
      name: 'HONDA-CBR500R',
      description: 'Perfect balance of performance and comfort. Ideal for both beginners and experienced riders with its smooth power delivery.',
      price: 1520000,
      imageUrl: 'assets/images/HHONDA_CBR500R.jpg',
      rating: 4.6,
      engineSize: "500cc",
      topSpeed: "185 km/h",
    ),
    Motorbike(
      id: '6',
      name: 'HONDA CD-70',
      description: 'Sporty yet practical middleweight motorcycle with comfortable ergonomics and plenty of power for highway riding.',
      price: 160000,
      imageUrl: 'assets/images/Honda_CD70.jpg',
      rating: 4.7,
      engineSize: "70cc",
      topSpeed: "90 km/h",
    ),
  ];

  @override
  void initState() {
    super.initState();
    filteredMotorbikes.addAll(motorbikes);
    ever(searchQuery, (value) {
      if (value.isEmpty) {
        filteredMotorbikes.assignAll(motorbikes);
      } else {
        filteredMotorbikes.assignAll(motorbikes.where((motorbike) =>
        motorbike.name.toLowerCase().contains(value.toLowerCase()) ||
            motorbike.description.toLowerCase().contains(value.toLowerCase())));
      }
    });
  }

  Widget _buildImageWidget(String imageUrl) {
    if (imageUrl.startsWith('assets/')) {
      return Image.asset(
        imageUrl,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _buildErrorWidget(),
      );
    } else {
      return CachedNetworkImage(
        imageUrl: imageUrl,
        width: double.infinity,
        fit: BoxFit.cover,
        placeholder: (context, url) => Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(color: Colors.white),
        ),
        errorWidget: (context, url, error) => _buildErrorWidget(),
      );
    }
  }

  Widget _buildErrorWidget() {
    return Container(
      color: Colors.grey[200],
      child: Center(
        child: Icon(Icons.motorcycle, size: 50, color: Colors.grey[400]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Center(
            child: TextField(
              onChanged: (value) => searchQuery.value = value,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search motorbikes...',
                border: InputBorder.none,
              ),
            ),
          ),
        ),
      ),
      body: Obx(() => Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.75,
          ),
          itemCount: filteredMotorbikes.length,
          itemBuilder: (context, index) {
            final motorbike = filteredMotorbikes[index];
            return GestureDetector(
              onTap: () => Get.toNamed('/motorbike', arguments: motorbike),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                        child: _buildImageWidget(motorbike.imageUrl),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            motorbike.name,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(Icons.star, color: Colors.amber, size: 16),
                              SizedBox(width: 4),
                              Text('${motorbike.rating}'),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '\RS${motorbike.price.toStringAsFixed(2)}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.add_shopping_cart, size: 20),
                                onPressed: () {
                                  if (authController.isLoggedIn) {
                                    cartController.addToCart(motorbike);
                                  } else {
                                    Get.toNamed('/login');
                                    Get.snackbar(
                                      'Login Required',
                                      'Please login to add items to cart',
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      )),
    );
  }
}