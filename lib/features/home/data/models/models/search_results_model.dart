import 'package:rakli_salons_app/features/home/data/models/models/product_model.dart';
import 'package:rakli_salons_app/features/home/data/models/models/salon_model.dart';
import 'package:rakli_salons_app/features/home/data/models/models/service_model.dart';
import 'package:rakli_salons_app/features/home/data/models/models/stylist_model.dart';

class SearchResults {
  final List<ProductModel> products;
  final List<SalonModel> salons;
  final List<StylistModel> freelancers;
  final List<ServiceModel> services;

  SearchResults({
    required this.products,
    required this.salons,
    required this.freelancers,
    required this.services,
  });

  factory SearchResults.fromJson(Map<String, dynamic> json, String category) {
    // Safely handle null or missing data
    final data = json['data'] ?? {};

    // Extract the list of items based on the category
    List<dynamic> itemsData = [];

    switch (category) {
      case 'products':
        // For products, the data is nested under 'products'
        itemsData = data['products']['data'] ?? [];
        break;
      case 'salon':
      case 'freelancer':
      case 'services':
        // For other categories, the data is directly under 'data'
        itemsData = data['data'] ?? [];
        break;
      default:
        itemsData = [];
    }

    // Parse the items based on the category
    switch (category) {
      case 'products':
        return SearchResults(
          products: _parseList(itemsData, ProductModel.fromJson),
          salons: [],
          freelancers: [],
          services: [],
        );
      case 'salon':
        return SearchResults(
          products: [],
          salons: _parseList(itemsData, SalonModel.fromJson),
          freelancers: [],
          services: [],
        );
      case 'freelancer':
        return SearchResults(
          products: [],
          salons: [],
          freelancers: _parseList(itemsData, StylistModel.fromJson),
          services: [],
        );
      case 'services':
        return SearchResults(
          products: [],
          salons: [],
          freelancers: [],
          services: _parseList(itemsData, ServiceModel.fromJson),
        );
      default:
        return SearchResults(
          products: [],
          salons: [],
          freelancers: [],
          services: [],
        );
    }
  }

  // Helper method to safely parse lists
  static List<T> _parseList<T>(
      List<dynamic> data, T Function(Map<String, dynamic>) fromJson) {
    if (data.isEmpty) return [];

    return data.map((e) => fromJson(e as Map<String, dynamic>)).toList();
  }
}
