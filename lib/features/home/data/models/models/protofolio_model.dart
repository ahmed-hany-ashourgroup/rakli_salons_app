class PortfolioModel {
  final int? id;
  final int? businessId;
  final String? instagramLink;
  final String? tiktokLink;
  final String? facebookLink;
  final String? youtubeLink;
  final String? bio;
  final String? createdAt;
  final String? updatedAt;

  PortfolioModel({
    this.id,
    this.businessId,
    this.instagramLink,
    this.tiktokLink,
    this.facebookLink,
    this.youtubeLink,
    this.bio,
    this.createdAt,
    this.updatedAt,
  });

  factory PortfolioModel.fromJson(Map<String, dynamic> json) {
    return PortfolioModel(
      id: json['id'] as int?,
      businessId: json['business_id'] as int?,
      instagramLink: json['instagram_link'] as String?,
      tiktokLink: json['tiktok_link'] as String?,
      facebookLink: json['facebook_link'] as String?,
      youtubeLink: json['youtube_link'] as String?,
      bio: json['bio'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'business_id': businessId,
      'instagram_link': instagramLink,
      'tiktok_link': tiktokLink,
      'facebook_link': facebookLink,
      'youtube_link': youtubeLink,
      'bio': bio,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
