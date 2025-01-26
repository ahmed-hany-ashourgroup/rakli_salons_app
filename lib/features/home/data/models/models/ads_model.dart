class AdsModel {
  final int id;
  final String title;
  final String image;
  final String createdAt;
  final String updatedAt;

  const AdsModel({
    required this.id,
    required this.title,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory method to create an AdsModel from JSON
  factory AdsModel.fromJson(Map<String, dynamic> json) {
    return AdsModel(
      id: json['id'] as int,
      title: json['title'] as String,
      image: json['image'] != null
          ? 'http://89.116.110.219/storage/${json['image']}'
          : '',
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
    );
  }

  // Method to convert an AdsModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'image': image,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
