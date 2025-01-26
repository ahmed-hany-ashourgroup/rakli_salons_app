import 'package:rakli_salons_app/features/home/data/models/models/cart_item_model.dart';

class CartResponseModel {
  final bool? success;
  final String? message;
  final CartDataModel? data;
  final dynamic errors;

  CartResponseModel({
    this.success,
    this.message,
    this.data,
    this.errors,
  });

  // Factory method to create a CartResponseModel from JSON
  factory CartResponseModel.fromJson(Map<String, dynamic> json) {
    return CartResponseModel(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      data: json['data'] != null ? CartDataModel.fromJson(json['data']) : null,
      errors: json['errors'],
    );
  }
}

class CartDataModel {
  final int? userId;
  final String? userType;
  final List<CartItemModel>? productItems;
  final double? totalPrice;
  final double? totalPriceAfterPromo;
  final String? updatedAt;
  final String? createdAt;
  final int? id;

  CartDataModel({
    this.userId,
    this.userType,
    this.productItems,
    this.totalPrice,
    this.totalPriceAfterPromo,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  // Factory method to create a CartDataModel from JSON
  factory CartDataModel.fromJson(Map<String, dynamic> json) {
    // Handle the 'product_item' field as either a List or a Map
    final dynamic productItemData = json['product_item'];
    List<CartItemModel>? productItems;

    if (productItemData is List) {
      // If 'product_item' is a List, parse it directly
      productItems =
          productItemData.map((item) => CartItemModel.fromJson(item)).toList();
    } else if (productItemData is Map<String, dynamic>) {
      // If 'product_item' is a Map, convert its values to a List
      productItems = productItemData.values
          .map((item) => CartItemModel.fromJson(item))
          .toList();
    }

    return CartDataModel(
      userId: json['user_id'] as int?,
      userType: json['user_type'] as String?,
      productItems: productItems,
      totalPrice: json['total_price'] != null
          ? double.parse(json['total_price'].toString())
          : null,
      totalPriceAfterPromo: json['total_price_after_promo'] != null
          ? double.parse(json['total_price_after_promo'].toString())
          : null,
      updatedAt: json['updated_at'] as String?,
      createdAt: json['created_at'] as String?,
      id: json['id'] as int?,
    );
  }
}
