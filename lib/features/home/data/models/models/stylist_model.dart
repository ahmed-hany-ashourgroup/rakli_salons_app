import 'package:rakli_salons_app/features/home/data/models/models/service_model.dart';

class StylistModel {
  final int? id;
  final String? name;
  final String? imageUrl;
  final String? description;
  final String? category;
  final String? location;
  final double? latitude;
  final double? longitude;
  final double? rating;
  final String? price;
  final int? clients;
  final String? phoneNum;
  final String? email;
  final String? state;
  final String? createdAt;
  final String? updatedAt;
  final Map<String, dynamic>? photos;
  final List<ServiceModel>? services;

  StylistModel({
    this.id,
    this.name,
    this.imageUrl,
    this.description,
    this.category,
    this.location,
    this.latitude,
    this.longitude,
    this.rating,
    this.price,
    this.clients,
    this.phoneNum,
    this.email,
    this.state,
    this.createdAt,
    this.updatedAt,
    this.services,
    this.photos,
  });

  // Factory method to create a StylistModel from JSON
  factory StylistModel.fromJson(Map<String, dynamic> json) {
    // Check if the JSON is from the "getAllStylists" response
    if (json.containsKey('photos')) {
      return StylistModel(
        id: json['id'] as int?,
        name: json['business_name'] as String?,
        imageUrl: json['photos'] != null && json['photos']['photo'] != null
            ? "http://89.116.110.219/storage/${json['photos']['photo']}"
            : null,
        category: json['role'] as String?,
        location: json['address'] as String?,
        latitude:
            json['latitude'] != null ? double.parse(json['latitude']) : null,
        longitude:
            json['longitude'] != null ? double.parse(json['longitude']) : null,
        email: json['email'] as String?,
        services: json['services'] != null
            ? List<ServiceModel>.from(json['business_services']
                .map((service) => ServiceModel.fromJson(service)))
            : null,
        phoneNum: json['phone'] as String?,
        state: json['state'] as String?,
        createdAt: json['created_at'] as String?,
        updatedAt: json['updated_at'] as String?,
        photos: json['photos'] != null
            ? Map<String, dynamic>.from(json['photos'])
            : null,
        rating: null, // Update if average_rating is available in the JSON
        description: null, // Update if description is available
        price: null, // Update if price is available
        clients: null, // Update if clients is available
      );
    }
    // Check if the JSON is from the "getTopRatedStylists" response
    else if (json.containsKey('business_id')) {
      return StylistModel(
        id: json['business_id'] as int?,
        name: json['business_name'] as String?,
        imageUrl: json['photo'] != null
            ? "http://89.116.110.219/storage/${json['photo']}"
            : null,
        category: json['role'] as String?,
        location: json['address'] as String?,
        rating: json['average_rating'] != null
            ? (json['average_rating'] as num).toDouble()
            : null,
      );
    }
    // Default case (fallback)
    return StylistModel();
  }

  // Method to convert a StylistModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'business_name': name,
      'imageUrl': imageUrl,
      'description': description,
      'category': category,
      'location': location,
      'latitude': latitude,
      'longitude': longitude,
      'rating': rating,
      'price': price,
      'clients': clients,
      'phoneNum': phoneNum,
      'email': email,
      'state': state,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'photos': photos,
    };
  }
}
