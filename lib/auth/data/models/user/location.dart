import 'coordinates.dart';

class Location {
  Coordinates? coordinates;
  String? address;
  bool? isFavorite;

  Location({this.coordinates, this.address, this.isFavorite});

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        coordinates: json['coordinates'] == null
            ? null
            : Coordinates.fromJson(json['coordinates'] as Map<String, dynamic>),
        address: json['address'] as String?,
        isFavorite: json['isFavorite'] as bool?,
      );

  Map<String, dynamic> toJson() => {
        'coordinates': coordinates?.toJson(),
        'address': address,
        'isFavorite': isFavorite,
      };
}
