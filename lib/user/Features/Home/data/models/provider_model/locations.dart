import 'package:collection/collection.dart';

import 'coordinates.dart';

class Locations {
	Coordinates? coordinates;

	Locations({this.coordinates});

	factory Locations.fromJson(Map<String, dynamic> json) => Locations(
				coordinates: json['coordinates'] == null
						? null
						: Coordinates.fromJson(json['coordinates'] as Map<String, dynamic>),
			);

	Map<String, dynamic> toJson() => {
				'coordinates': coordinates?.toJson(),
			};

	@override
	bool operator ==(Object other) {
		if (identical(other, this)) return true;
		if (other is! Locations) return false;
		final mapEquals = const DeepCollectionEquality().equals;
		return mapEquals(other.toJson(), toJson());
	}

	@override
	int get hashCode => coordinates.hashCode;
}
