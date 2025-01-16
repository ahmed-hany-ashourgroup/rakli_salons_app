class ProductModel {
  final String? name;
  final String? description;
  final double? price;
  final String? image;
  final double? rating;

  ProductModel({
    this.name,
    this.description,
    this.price,
    this.rating,
    this.image,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      name: json['name'],
      description: json['description'],
      price: json['price'],
      image: json['image'],
    );
  }
}
