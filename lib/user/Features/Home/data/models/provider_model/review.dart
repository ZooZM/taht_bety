import 'package:collection/collection.dart';

import 'user.dart';

class Review {
  String? id;
  String? review;
  int? rating;
  User? user;
  String? provider;
  DateTime? createdAt;
  int? v;
  String? rId;

  Review({
    this.id,
    this.review,
    this.rating,
    this.user,
    this.provider,
    this.createdAt,
    this.v,
    this.rId,
  });

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        id: json['_id'] as String?,
        review: json['review'] as String?,
        rating: json['rating'] as int?,
        user: json['user'] == null
            ? null
            : User.fromJson(json['user'] as Map<String, dynamic>),
        provider: json['provider'] as String?,
        createdAt: json['createdAt'] == null
            ? null
            : DateTime.parse(json['createdAt'] as String),
        v: json['__v'] as int?,
        rId: json['id'] as String?,
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'review': review,
        'rating': rating,
        'user': user?.toJson(),
        'provider': provider,
        'createdAt': createdAt?.toIso8601String(),
        '__v': v,
        'id': id,
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Review) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      id.hashCode ^
      review.hashCode ^
      rating.hashCode ^
      user.hashCode ^
      provider.hashCode ^
      createdAt.hashCode ^
      v.hashCode ^
      id.hashCode;
}
