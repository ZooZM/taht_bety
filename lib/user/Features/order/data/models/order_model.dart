class OrderModel {
  final String id;
  final String status;
  final String description;
  final double price;
  final List<String> postIds;

  OrderModel({
    required this.id,
    required this.status,
    required this.description,
    required this.price,
    required this.postIds,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['_id'],
      status: json['status'],
      description: json['description'],
      price: (json['price'] as num).toDouble(),
      postIds: List<String>.from(json['postID'] ?? []),
    );
  }
}
