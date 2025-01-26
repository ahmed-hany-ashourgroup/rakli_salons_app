import 'package:rakli_salons_app/features/home/data/models/models/calender_model.dart';
import 'package:rakli_salons_app/features/home/data/models/models/product_model.dart';
import 'package:rakli_salons_app/features/home/data/models/models/protofolio_model.dart';
import 'package:rakli_salons_app/features/home/data/models/models/service_model.dart';

class SalonModel {
  final int? id;
  final String? businessName;
  final String? email;
  final String? address;
  final double? latitude;
  final double? longitude;
  final String? role;
  final String? phone;
  final String? state;
  final String? createdAt;
  final String? updatedAt;
  final Map<String, dynamic>? photos;
  final double? rating;
  final String? description;
  final String? image;
  final List<ProductModel>? products;
  final List<ServiceModel>? services;
  final PortfolioModel? portfolio;
  final List<dynamic>? media; // Update with a proper model if needed
  final CalendarModel? calendar;

  SalonModel({
    this.id,
    this.businessName,
    this.email,
    this.address,
    this.latitude,
    this.longitude,
    this.role,
    this.phone,
    this.state,
    this.createdAt,
    this.updatedAt,
    this.photos,
    this.rating,
    this.description,
    this.image,
    this.products,
    this.services,
    this.portfolio,
    this.media,
    this.calendar,
  });

  // Factory method to create a SalonModel from JSON
  factory SalonModel.fromJson(Map<String, dynamic> json) {
    return SalonModel(
      id: json['id'] as int? ?? json['business_id'] as int?,
      businessName: json['business_name'] as String?,
      email: json['email'] as String?,
      address: json['address'] as String?,
      latitude: json['latitude'] != null
          ? double.parse(json['latitude'].toString())
          : null,
      longitude: json['longitude'] != null
          ? double.parse(json['longitude'].toString())
          : null,
      role: json['role'] as String?,
      phone: json['phone'] as String?,
      state: json['state'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      photos: json['photos'] != null
          ? Map<String, dynamic>.from(json['photos'])
          : null,
      image: json['photos'] != null && json['photos']['photo'] != null
          ? "http://89.116.110.219/storage/${json['photos']['photo']}"
          : null,
      rating: null, // Update if average_rating is available in the JSON
      description: null, // Update if description is available in the JSON
      products: json['product'] != null
          ? (json['product'] as List)
              .map((product) => ProductModel.fromJson(product))
              .toList()
          : null,
      services: json['business_services'] != null
          ? (json['business_services'] as List)
              .map((service) => ServiceModel.fromJson(service))
              .toList()
          : null,
      portfolio: json['portfolio'] != null && json['portfolio'].isNotEmpty
          ? PortfolioModel.fromJson(
              json['portfolio'][0]) // Assuming only one portfolio
          : null,
      media: json['media']
          as List<dynamic>?, // Update with a proper model if needed
      calendar: json['calendar'] != null
          ? CalendarModel.fromJson(json['calendar'])
          : null,
    );
  }

  // Method to convert a SalonModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'business_name': businessName,
      'email': email,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'role': role,
      'phone': phone,
      'state': state,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'photos': photos,
      'rating': rating,
      'description': description,
      'image': image,
      'product': products?.map((product) => product.toJson()).toList(),
      'business_services':
          services?.map((service) => service.toJson()).toList(),
      'portfolio': portfolio?.toJson(),
      'media': media,
      'calendar': calendar?.toJson(),
    };
  }
}
