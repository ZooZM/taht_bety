import 'location.dart';

class UserModel {
  String? id;
  String? email;
  String? name;
  String? role;
  bool? active;
  List<Location>? locations;
  List<String>? favoriteProviders;
  String? token;

  UserModel({
    this.id,
    this.email,
    this.name,
    this.role,
    this.active,
    this.locations,
    this.favoriteProviders,
    this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['_id'] as String?,
        email: json['email'] as String?,
        name: json['name'] as String?,
        role: json['role'] as String?,
        active: json['active'] as bool?,
        locations: (json['locations'] as List<dynamic>?)
            ?.map((e) => Location.fromJson(e as Map<String, dynamic>))
            .toList(),
        favoriteProviders:
            (json['favoriteProviders'] as List<dynamic>?)?.cast<String>(),
        token: json['token'] as String?,
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'email': email,
        'name': name,
        'role': role,
        'active': active,
        'locations': locations?.map((e) => e.toJson()).toList(),
        'favoriteProviders': favoriteProviders,
        'token': token,
      };
}
