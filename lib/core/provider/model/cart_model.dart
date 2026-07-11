class CartModel {
  final int? id;
  final DateTime? createdAt;
  final String productId;
  final Map<String, dynamic> productData;
  int quantity;
  final String userId;

  CartModel({
    this.id,
    this.createdAt,
    required this.productId,
    required this.productData,
    required this.quantity,
    required this.userId,
  });

  factory CartModel.fromMap(Map<String, dynamic> map) {
    return CartModel(
      id: map['id'] as int?,
      createdAt: map['created_at'] == null
          ? null
          : DateTime.parse(map['created_at']),
      productId: map['product_id'] as String,
      productData: Map<String, dynamic>.from(map['product_data']),
      quantity: map['quantity'] as int,
      userId: map['user_id'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'product_id': productId,
      'product_data': productData,
      'quantity': quantity,
    };
  }
}