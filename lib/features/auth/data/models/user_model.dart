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
    final accountData = json['data']?['account'] ?? json['account'];
    if (accountData != null) {
      id = accountData['id'];
      name = accountData['business_name']; // Map 'business_name' to 'name'
      email = accountData['email'];
      phone = accountData['phone'];
      address = accountData['address'];
      role = accountData['role'];
      verificationCode = accountData['verification_code'];
      createdAt = accountData['created_at'] != null
          ? DateTime.parse(accountData['created_at'])
          : null;
      updatedAt = accountData['updated_at'] != null
          ? DateTime.parse(accountData['updated_at'])
          : null;

      // Handle nested 'photos' object and prepend base URL
      final photosData = accountData['photos'];
      if (photosData != null) {
        photo = photosData['photo'] != null
            ? "http://89.116.110.219/storage/${photosData['photo']}"
            : null;
        tradeLicense = photosData['trade_license'] != null
            ? "http://89.116.110.219/storage/${photosData['trade_license']}"
            : null;
        taxRegistration = photosData['tax_registration'] != null
            ? "http://89.116.110.219/storage/${photosData['tax_registration']}"
            : null;
        cover = photosData['cover'] != null
            ? "http://89.116.110.219/storage/${photosData['cover']}"
            : null;
        idCard = photosData['id_card'] != null
            ? "http://89.116.110.219/storage/${photosData['id_card']}"
            : null;
      }

      latitude = double.tryParse(accountData['latitude'] ?? '');
      longitude = double.tryParse(accountData['longitude'] ?? '');
      method = accountData['method'];
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
