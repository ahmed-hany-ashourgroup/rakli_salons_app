import 'package:rakli_salons_app/features/auth/data/models/user_model.dart';

class OrderModel {
  final int? id;
  final int? userId;
  final String? userType;
  final String? paymentType;
  final List<OrderItemModel>? items;
  final double? totalPrice;
  final String? createdAt;
  final String? updatedAt;
  final String? state;
  final BuisnessUserModel? user;

  OrderModel({
    this.id,
    this.userId,
    this.userType,
    this.paymentType,
    this.items,
    this.totalPrice,
    this.createdAt,
    this.updatedAt,
    this.state,
    this.user,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'] as int?,
      userId: json['user_id'] as int?,
      userType: json['user_type'] as String?,
      paymentType: json['payment_type'] as String?,
      items: json['id_item'] != null
          ? (json['id_item'] as List)
              .map((item) => OrderItemModel.fromJson(item))
              .toList()
          : null,
      totalPrice: json['total_price'] != null
          ? double.parse(json['total_price'].toString())
          : null,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      state: json['state'] as String?,
      user: json['user'] != null
          ? BuisnessUserModel.fromJson(json['user'])
          : null,
    );
  }
}

class OrderItemModel {
  final int? id;
  final String? size;
  final String? type;
  final String? image;
  final double? price;
  final String? title;
  final int? quantity;

  OrderItemModel({
    this.id,
    this.size,
    this.type,
    this.image,
    this.price,
    this.title,
    this.quantity,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      id: json['id'] as int?,
      size: json['size'] as String?,
      type: json['type'] as String?,
      image: json['image'] as String?,
      price:
          json['price'] != null ? double.parse(json['price'].toString()) : null,
      title: json['title'] as String?,
      quantity: json['quantity'] as int?,
    );
  }
}
