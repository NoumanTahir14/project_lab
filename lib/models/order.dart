class Order {
  final String id;
  final DateTime date;
  final double total;
  final List<Map<String, dynamic>> items;
  final String address;
  final String paymentMethod;

  Order({
    required this.id,
    required this.date,
    required this.total,
    required this.items,
    required this.address,
    required this.paymentMethod,
  });
}