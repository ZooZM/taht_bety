class Review {
  String? id;
  String? review;
  int? rating;
  String? user;
  String? provider;
  DateTime? createdAt;
  DateTime? updatedAt;

  Review({
    this.id,
    this.review,
    this.rating,
    this.user,
    this.provider,
    this.createdAt,
    this.updatedAt,
  });

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        id: json['_id'] as String?,
        review: json['review'] as String?,
        rating: json['rating'] as int?,
        user: json['user'] as String?,
        provider: json['provider'] as String?,
        createdAt: json['createdAt'] == null
            ? null
            : DateTime.parse(json['createdAt'] as String),
        updatedAt: json['updatedAt'] == null
            ? null
            : DateTime.parse(json['updatedAt'] as String),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'review': review,
        'rating': rating,
        'user': user,
        'provider': provider,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
      };
}
