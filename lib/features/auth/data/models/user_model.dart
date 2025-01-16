class UserModel {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? password;
  String? address;
  String? verificationCode;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? token;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.verificationCode,
    this.createdAt,
    this.updatedAt,
    this.password,
    this.token,
    this.address,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    final userData = json['data']?['user'] ?? json['user'];
    if (userData != null) {
      id = userData['id'];
      name = userData['name'];
      email = userData['email'];
      phone = userData['phone'];
      verificationCode = userData['verification_code'];
      createdAt = userData['created_at'] != null
          ? DateTime.parse(userData['created_at'])
          : null;
      updatedAt = userData['updated_at'] != null
          ? DateTime.parse(userData['updated_at'])
          : null;
    }
    // Check both possible token locations
    token = json['data']?['token'] ?? json['token'];
  }

  Map<String, dynamic> toJson() {
    return {
      'user': {
        'id': id,
        'name': name,
        'email': email,
        'phone': phone,
        'verification_code': verificationCode,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      },
      'token': token,
    };
  }
}
