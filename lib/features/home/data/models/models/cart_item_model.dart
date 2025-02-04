class CartItemModel {
  final int? id;
  final bool? isCollection;
  final int? quantity;
  final String? size;
  final String? price;
  final String? title;
  final String? image;

  CartItemModel({
    this.id,
    this.isCollection,
    this.quantity,
    this.size,
    this.price,
    this.title,
    this.image,
  });

  // Factory method to create a CartItemModel from JSON
  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      id: json['id'] as int?,
      isCollection: json['is_collection'] as bool?,
      quantity: json['quantity'] as int?,
      size: json['size'] as String?,
      price: json['price'] as String ?? '',
      title: json['title'] as String?,
      image: json['image'] as String?,
    );
  }

  // Method to convert a CartItemModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'is_collection': isCollection,
      'quantity': quantity,
      'size': size,
      'price': price,
      'title': title,
      'image': image,
    };
  }
}
