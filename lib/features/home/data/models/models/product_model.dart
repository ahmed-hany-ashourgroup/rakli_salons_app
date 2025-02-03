class ProductModel {
  final int? id;
  final String? image;
  final String? title;
  final String? description;
  final int? collectionId;
  final int? createdBy;
  final String? creatorType;
  final String? price;
  final String? size;
  final String? category;
  final String? createdAt;
  final String? updatedAt;

  ProductModel({
    this.id,
    this.image,
    this.title,
    this.description,
    this.collectionId,
    this.createdBy,
    this.creatorType,
    this.price,
    this.size,
    this.category,
    this.createdAt,
    this.updatedAt,
  });

  // Factory method to create a ProductModel from JSON
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as int?,
      image: json['image'] != null
          ? "http://89.116.110.219/storage/${json['image']}"
          : null,
      title: json['title'] as String?,
      description: json['description'] as String?,
      collectionId: json['collection_id'] as int?,
      createdBy: json['created_by'] as int?,
      creatorType: json['creator_type'] as String?,
      price: json['price']?.toString(),
      size: json['size']?.toString(),
      category: json['category'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }

  // Method to convert a ProductModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': image,
      'title': title,
      'description': description,
      'collection_id': collectionId,
      'created_by': createdBy,
      'creator_type': creatorType,
      'price': price,
      'size': size,
      'category': category,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
