import 'dart:convert';

import 'package:rakli_salons_app/core/utils/logger.dart';

class ProductModel {
  final int? id;
  final String? name;
  final String? description;
  final String? image;
  final double? rating;
  final int? collectionId;
  final String? createdAt;
  final String? updatedAt;
  final int? createdBy;
  final String? creatorType;
  final List<Map<String, dynamic>>? details; // Details list
  final num? price; // Price fetched from details
  final num? size; // Size fetched from details
  final bool isCollection; // Flag to differentiate collections and products

  ProductModel({
    this.id,
    this.name,
    this.description,
    this.image,
    this.rating,
    this.collectionId,
    this.createdAt,
    this.updatedAt,
    this.createdBy,
    this.creatorType,
    this.details,
    this.price,
    this.size,
    this.isCollection = false, // Default to false
  });

  // Factory method to create a ProductModel from JSON
  factory ProductModel.fromJson(Map<String, dynamic> json,
      {bool isCollection = false}) {
    // Parse the 'details' field if it's a string
    List<Map<String, dynamic>>? parsedDetails;
    if (json['details'] != null) {
      if (json['details'] is String) {
        // Parse the JSON string into a List<Map<String, dynamic>>
        try {
          parsedDetails =
              List<Map<String, dynamic>>.from(jsonDecode(json['details']));
        } catch (e) {
          Logger.error("Failed to parse 'details': $e");
        }
      } else if (json['details'] is List) {
        // If it's already a List, cast it directly
        parsedDetails = List<Map<String, dynamic>>.from(json['details']);
      }
    }

    // Fetch the first entry from the details list (if available)
    final firstDetail = parsedDetails != null && parsedDetails.isNotEmpty
        ? parsedDetails[0]
        : null;

    return ProductModel(
      id: json['id'] as int? ?? json['product_id'] as int?,
      name: json['title'] as String?,
      description: json['description'] as String?,
      image: "http://89.116.110.219/storage/${json['image']}",
      rating: json['average_rating'] != null
          ? (json['average_rating'] as num).toDouble()
          : null,
      collectionId: json['collection_id'] as int?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      createdBy: json['created_by'] as int?,
      creatorType: json['creator_type'] as String?,
      details: parsedDetails,
      price: firstDetail != null
          ? (firstDetail['price'] as num).toDouble()
          : json['price'] != null
              ? num.parse(json['price'].toString())
              : null, // Fetch price from details or directly from JSON
      size: firstDetail != null
          ? firstDetail['size'] as int?
          : null, // Fetch size from details
      isCollection: isCollection, // Set the isCollection flag
    );
  }

  // Method to convert a ProductModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': name,
      'description': description,
      'image': image,
      'rating': rating,
      'collection_id': collectionId,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'created_by': createdBy,
      'creator_type': creatorType,
      'details': details,
      'price': price,
      'size': size,
      'isCollection': isCollection,
    };
  }
}
