import 'location.dart';

class ProviderListModel {
  String? name;
  String? photo;
  String? userId;
  String? providerId;
  List<Location>? locations;
  double? distance;
  String? providerType;

  ProviderListModel({
    this.name,
    this.photo,
    this.userId,
    this.providerId,
    this.locations,
    this.distance,
    this.providerType,
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
      };

  ProviderListModel copyWith({
    String? name,
    String? photo,
    String? userId,
    String? providerId,
    List<Location>? locations,
    double? distance,
    String? providerType,
  }) {
    return ProviderListModel(
      name: name ?? this.name,
      photo: photo ?? this.photo,
      userId: userId ?? this.userId,
      providerId: providerId ?? this.providerId,
      locations: locations ?? this.locations,
      distance: distance ?? this.distance,
      providerType: providerType ?? this.providerType,
    );
  }
}
