import 'package:collection/collection.dart';

class Coordinates {
	String? type;
	List<double>? coordinates;

	Coordinates({this.type, this.coordinates});

	factory Coordinates.fromJson(Map<String, dynamic> json) => Coordinates(
				type: json['type'] as String?,
				coordinates: json['coordinates'] as List<double>?,
			);

	Map<String, dynamic> toJson() => {
				'type': type,
				'coordinates': coordinates,
			};

	@override
	bool operator ==(Object other) {
		if (identical(other, this)) return true;
		if (other is! Coordinates) return false;
		final mapEquals = const DeepCollectionEquality().equals;
		return mapEquals(other.toJson(), toJson());
	}

	@override
	int get hashCode => type.hashCode ^ coordinates.hashCode;
}
