// business_registration_model.dart
class BuisnessUserModel {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? password;
  String? address;
  String? role;
  String? verificationCode;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? token;
  String? photo;
  String? cover;
  String? tradeLicense;
  String? taxRegistration;
  String? idCard;
  double? latitude;
  double? longitude;
  String? method;

  BuisnessUserModel({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.password,
    this.address,
    this.role,
    this.verificationCode,
    this.createdAt,
    this.updatedAt,
    this.token,
    this.photo,
    this.cover,
    this.tradeLicense,
    this.taxRegistration,
    this.idCard,
    this.latitude,
    this.longitude,
    this.method,
  });

  BuisnessUserModel.fromJson(Map<String, dynamic> json) {
    final userData = json['data']?['user'] ?? json['user'];
    if (userData != null) {
      id = userData['id'];
      name = userData['name'];
      email = userData['email'];
      phone = userData['phone'];
      address = userData['address'];
      role = userData['role'];
      verificationCode = userData['verification_code'];
      createdAt = userData['created_at'] != null
          ? DateTime.parse(userData['created_at'])
          : null;
      updatedAt = userData['updated_at'] != null
          ? DateTime.parse(userData['updated_at'])
          : null;
      photo = userData['photo'];
      cover = userData['cover'];
      tradeLicense = userData['trade_license'];
      taxRegistration = userData['tax_registration'];
      idCard = userData['id_card'];
      latitude = userData['latitude']?.toDouble();
      longitude = userData['longitude']?.toDouble();
      method = userData['method'];
    }
    token = json['data']?['token'] ?? json['token'];
  }

  Map<String, dynamic> toJson() {
    return {
      'business_name': name,
      'email': email,
      'password': password,
      'phone': phone,
      'address': address,
      'role': role,
      'latitude': latitude,
      'longitude': longitude,
      'method': method,
    };
  }
}
