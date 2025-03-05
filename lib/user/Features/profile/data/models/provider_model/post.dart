class Post {
  String? providerId;
  List<String>? images;
  String? title;
  String? content;
  int? price;
  bool? isMainService;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? id;

  Post({
    this.providerId,
    this.images,
    this.title,
    this.content,
    this.price,
    this.isMainService,
    this.createdAt,
    this.updatedAt,
    this.id,
  });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        providerId: json['providerID'] as String?,
        images: (json['images'] as List<dynamic>?)?.cast<String>(),
        title: json['title'] as String?,
        content: json['content'] as String?,
        price: json['price'] as int?,
        isMainService: json['isMainService'] as bool?,
        createdAt: json['createdAt'] == null
            ? null
            : DateTime.parse(json['createdAt'] as String),
        updatedAt: json['updatedAt'] == null
            ? null
            : DateTime.parse(json['updatedAt'] as String),
        id: json['_id'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'providerID': providerId,
        'images': images,
        'title': title,
        'content': content,
        'price': price,
        'isMainService': isMainService,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        '_id': id,
      };
}
