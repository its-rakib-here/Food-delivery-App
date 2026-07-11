class CartModel{

  final String id;
  final String productId;
  final Map<String,dynamic> productData;
  int quantity;
  final String userId;

  CartModel({
    required this.id,
    required this.productId,
    required this.productData,
    required this.quantity,
    required this.userId,
  });

  factory CartModel.fromMap(Map<String,dynamic>map){
    return CartModel(
      id: map['id'],
      productId: map['productId'],
      productData: map['productData'],
      quantity: map['quantity'],
      userId: map['userId'],
    );
  }

  Map<String,dynamic> toMap(){
    return {
      'id':id,
      'productId':productId,
      'productData':productData,
      'quantity':quantity,
      'userId':userId,
    };
  }



}