import 'location.dart';

class ProviderListModel {
  String? name;
  String? photo;
  String? userId;
  String? providerId;
  List<Location>? locations;
  double? distance;
  String? providerType;
  int? reviewsCount; // عدد المراجعات
  double? avgRating; // متوسط التقييم

  ProviderListModel({
    this.name,
    this.photo,
    this.userId,
    this.providerId,
    this.locations,
    this.distance,
    this.providerType,
    this.reviewsCount,
    this.avgRating,
  });

  factory ProviderListModel.fromJson(Map<String, dynamic> json) {
    return ProviderListModel(
      name: json['name'] as String?,
      photo: json['photo'] as String?,
      userId: json['userId'] as String?,
      providerId: json['providerId'] as String?,
      locations: (json['locations'] as List<dynamic>?)
          ?.map((e) => Location.fromJson(e as Map<String, dynamic>))
          .toList(),
      distance: (json['distance'] as num?)?.toDouble(),
      providerType: json['providerType'] as String?,
      reviewsCount: json['reviewsCount'] as int?, // استخراج عدد المراجعات
      avgRating:
          (json['avgRating'] as num?)?.toDouble(), // استخراج متوسط التقييم
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'photo': photo,
        'userId': userId,
        'providerId': providerId,
        'locations': locations?.map((e) => e.toJson()).toList(),
        'distance': distance,
        'providerType': providerType,
        'reviewsCount': reviewsCount, // إضافة عدد المراجعات إلى JSON
        'avgRating': avgRating, // إضافة متوسط التقييم إلى JSON
      };

  ProviderListModel copyWith({
    String? name,
    String? photo,
    String? userId,
    String? providerId,
    List<Location>? locations,
    double? distance,
    String? providerType,
    int? reviewsCount,
    double? avgRating,
  }) {
    return ProviderListModel(
      name: name ?? this.name,
      photo: photo ?? this.photo,
      userId: userId ?? this.userId,
      providerId: providerId ?? this.providerId,
      locations: locations ?? this.locations,
      distance: distance ?? this.distance,
      providerType: providerType ?? this.providerType,
      reviewsCount: reviewsCount ?? this.reviewsCount,
      avgRating: avgRating ?? this.avgRating,
    );
  }
}
