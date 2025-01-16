import 'package:latlong2/latlong.dart';

class SalonModel {
  final String? name;
  final String? address;
  final String? phone;
  final String? image;
  final LatLng? location;
  final String? category;
  final double? rating;
  final String? description;

  SalonModel({
    this.name,
    this.address,
    this.category,
    this.description,
    this.rating,
    this.phone,
    this.image,
    this.location,
  });
}
