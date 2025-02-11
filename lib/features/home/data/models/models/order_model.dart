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
  final String? gift;

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
    this.gift,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    List<OrderItemModel> parseItems(dynamic itemsData) {
      List<OrderItemModel> result = [];
      if (itemsData is List) {
        result =
            itemsData.map((item) => OrderItemModel.fromJson(item)).toList();
      } else if (itemsData is Map) {
        result = itemsData.values
            .map((item) => OrderItemModel.fromJson(item))
            .toList();
      }
      return result;
    }

    return OrderModel(
      id: json['id'],
      userId: json['user_id'],
      userType: json['user_type'],
      paymentType: json['payment_type'],
      items: json['id_item'] != null ? parseItems(json['id_item']) : null,
      totalPrice: json['total_price'] != null
          ? double.parse(json['total_price'].toString())
          : null,
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      state: json['state'],
      gift: json['gift'],
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
      id: json['id'],
      size: json['size'],
      type: json['type'],
      image: json['image'],
      price:
          json['price'] != null ? double.parse(json['price'].toString()) : null,
      title: json['title'],
      quantity: json['quantity'],
    );
  }
}
