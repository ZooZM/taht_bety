import 'coordinates.dart';

class Location {
  Coordinates? coordinates;
  String? address;
  String? id;

  Location({this.coordinates, this.address, this.id});

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        coordinates: json['coordinates'] == null
            ? null
            : Coordinates.fromJson(json['coordinates'] as Map<String, dynamic>),
        address: json['address'] as String?,
        id: json['id'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'coordinates': coordinates?.toJson(),
        'address': address,
        'id': id,
      };
}
