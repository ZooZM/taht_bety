import 'package:collection/collection.dart';

class User {
	String? id;
	String? name;
	String? email;

	User({this.id, this.name, this.email});

	factory User.fromJson(Map<String, dynamic> json) => User(
				id: json['_id'] as String?,
				name: json['name'] as String?,
				email: json['email'] as String?,
			);

	Map<String, dynamic> toJson() => {
				'_id': id,
				'name': name,
				'email': email,
			};

	@override
	bool operator ==(Object other) {
		if (identical(other, this)) return true;
		if (other is! User) return false;
		final mapEquals = const DeepCollectionEquality().equals;
		return mapEquals(other.toJson(), toJson());
	}

	@override
	int get hashCode => id.hashCode ^ name.hashCode ^ email.hashCode;
}
