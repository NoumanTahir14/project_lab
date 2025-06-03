class Motorbike {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final double rating;
  final String engineSize;
  final String topSpeed;

  Motorbike({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.rating = 4.5,
    required this.engineSize,
    required this.topSpeed,
  });
}