class ServiceModel {
  final int? id;
  final int? businessId;
  final String? title;
  final String? description;
  final double? price;
  final dynamic promotions; // Update with a proper model if needed
  final String? createdAt;
  final String? updatedAt;
  final int? active;
  final Gender? gender;
  ServiceState? state;

  ServiceModel({
    this.id,
    this.businessId,
    this.title,
    this.description,
    this.price,
    this.promotions,
    this.createdAt,
    this.updatedAt,
    this.active,
    this.gender,
    this.state,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['id'] as int?,
      businessId: json['business_id'] as int?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      price: json['price'] != null ? double.parse(json['price']) : null,
      promotions: json['promotions'],
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      active: json['active'] as int?,
      gender: json['gender'] as Gender?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'business_id': businessId,
      'title': title,
      'description': description,
      'price': price,
      'promotions': promotions,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'active': active,
      'gender': gender,
    };
  }
}

enum ServiceState { active, inactive }

enum Gender { male, female }
