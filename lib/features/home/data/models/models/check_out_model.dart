class CheckoutItemModel {
  final int? id;
  final String? type;
  final String? image;
  final String? title;
  final double? price;
  final String? size;
  final int? quantity;

  CheckoutItemModel({
    this.id,
    this.type,
    this.image,
    this.title,
    this.price,
    this.size,
    this.quantity,
  });

  // Factory method to create a CheckoutItemModel from JSON
  factory CheckoutItemModel.fromJson(Map<String, dynamic> json) {
    return CheckoutItemModel(
      id: json['id'] as int?,
      type: json['type'] as String?,
      image: json['image'] as String?,
      title: json['title'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      size: json['size'] as String?,
      quantity: json['quantity'] as int?,
    );
  }

  // Method to convert a CheckoutItemModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'image': image,
      'title': title,
      'price': price,
      'size': size,
      'quantity': quantity,
    };
  }
}

class CheckoutDataModel {
  final int? userId;
  final String? userType;
  final String? paymentType;
  final List<CheckoutItemModel>? items;
  final double? totalPrice;
  final String? updatedAt;
  final String? createdAt;
  final int? id;

  CheckoutDataModel({
    this.userId,
    this.userType,
    this.paymentType,
    this.items,
    this.totalPrice,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  // Factory method to create a CheckoutDataModel from JSON
  factory CheckoutDataModel.fromJson(Map<String, dynamic> json) {
    return CheckoutDataModel(
      userId: json['user_id'] as int?,
      userType: json['user_type'] as String?,
      paymentType: json['payment_type'] as String?,
      items: json['id_item'] != null
          ? (json['id_item'] as List)
              .map((item) => CheckoutItemModel.fromJson(item))
              .toList()
          : null,
      totalPrice: json['total_price'] != null
          ? double.parse(json['total_price'].toString())
          : null,
      updatedAt: json['updated_at'] as String?,
      createdAt: json['created_at'] as String?,
      id: json['id'] as int?,
    );
  }

  // Method to convert a CheckoutDataModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'user_type': userType,
      'payment_type': paymentType,
      'id_item': items?.map((item) => item.toJson()).toList(),
      'total_price': totalPrice,
      'updated_at': updatedAt,
      'created_at': createdAt,
      'id': id,
    };
  }
}

class CheckoutResponseModel {
  final bool? success;
  final String? message;
  final CheckoutDataModel? data;
  final dynamic errors;

  CheckoutResponseModel({
    this.success,
    this.message,
    this.data,
    this.errors,
  });

  // Factory method to create a CheckoutResponseModel from JSON
  factory CheckoutResponseModel.fromJson(Map<String, dynamic> json) {
    return CheckoutResponseModel(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      data: json['data'] != null
          ? CheckoutDataModel.fromJson(json['data'])
          : null,
      errors: json['errors'],
    );
  }

  // Method to convert a CheckoutResponseModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data?.toJson(),
      'errors': errors,
    };
  }
}
