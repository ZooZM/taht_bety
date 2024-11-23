import 'package:collection/collection.dart';
import 'locations.dart';
import 'review.dart';

class ProviderModel {
  List<Locations>? locations;
  List<dynamic>? posts;
  String? id;
  String? providerType;
  List<String>? pId;
  String? subscriptionType;
  int? subscriptionPercentage;
  DateTime? lastPhotoAt;
  DateTime? subscriptionStartDate;
  bool? isActive;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? criminalRecord;
  String? providerId;
  List<Review>? reviews;

  ProviderModel({
    this.locations,
    this.posts,
    this.id,
    this.providerType,
    this.pId,
    this.subscriptionType,
    this.subscriptionPercentage,
    this.lastPhotoAt,
    this.subscriptionStartDate,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.criminalRecord,
    this.providerId,
    this.reviews,
  });

  factory ProviderModel.fromJson(Map<String, dynamic> json) => ProviderModel(
        locations: json['locations'] == null
            ? null
            : (json['locations'] as List<dynamic>)
                .map((e) => Locations.fromJson(e as Map<String, dynamic>))
                .toList(),
        posts: (json['posts'] as List<dynamic>?)
            ?.map((item) =>
                item is double ? item : double.tryParse(item.toString()) ?? 0.0)
            .toList(),
        id: json['_id'] as String?,
        providerType: json['providerType'] as String?,
        pId: (json['id'] as List<dynamic>?)?.map((e) => e as String).toList(),
        subscriptionType: json['subscriptionType'] as String?,
        subscriptionPercentage: json['subscriptionPercentage'] as int?,
        lastPhotoAt: json['lastPhotoAt'] == null
            ? null
            : DateTime.parse(json['lastPhotoAt'] as String),
        subscriptionStartDate: json['subscriptionStartDate'] == null
            ? null
            : DateTime.parse(json['subscriptionStartDate'] as String),
        isActive: json['isActive'] as bool?,
        createdAt: json['createdAt'] == null
            ? null
            : DateTime.parse(json['createdAt'] as String),
        updatedAt: json['updatedAt'] == null
            ? null
            : DateTime.parse(json['updatedAt'] as String),
        criminalRecord: json['criminalRecord'] as String?,
        providerId: json['providerID'] as String?,
        reviews: (json['reviews'] as List<dynamic>?)
            ?.map((e) => Review.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'locations': locations?.map((e) => e.toJson()).toList(),
        'posts': posts,
        '_id': id,
        'providerType': providerType,
        'id': id,
        'subscriptionType': subscriptionType,
        'subscriptionPercentage': subscriptionPercentage,
        'lastPhotoAt': lastPhotoAt?.toIso8601String(),
        'subscriptionStartDate': subscriptionStartDate?.toIso8601String(),
        'isActive': isActive,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        'criminalRecord': criminalRecord,
        'providerID': providerId,
        'reviews': reviews?.map((e) => e.toJson()).toList(),
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! ProviderModel) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      locations.hashCode ^
      posts.hashCode ^
      id.hashCode ^
      providerType.hashCode ^
      id.hashCode ^
      subscriptionType.hashCode ^
      subscriptionPercentage.hashCode ^
      lastPhotoAt.hashCode ^
      subscriptionStartDate.hashCode ^
      isActive.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode ^
      criminalRecord.hashCode ^
      providerId.hashCode ^
      reviews.hashCode;
}
