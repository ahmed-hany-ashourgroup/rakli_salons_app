class AddToCartRequestModel {
  final int? id;
  final int? quantity;
  final String? size;
  final double? price;
  final bool? isCollection;

  AddToCartRequestModel({
    this.id,
    this.quantity,
    this.size,
    this.price,
    this.isCollection,
  });

  // Convert the model to JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> productItem = {
      'id': id,
      'quantity': quantity,
      'price': price,
      'is_collection': isCollection,
    };

    // Add 'size' only if isCollection is false
    if (isCollection == false) {
      productItem['size'] = size;
    }

    return {
      'product_item': productItem,
    };
  }
}
