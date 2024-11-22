import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlaceModel {
  final int id;
  final String name;
  final LatLng latLng;

  PlaceModel({required this.id, required this.name, required this.latLng});
}

List<PlaceModel> placList = [
  PlaceModel(
      id: 1,
      name: 'ورشة كاوتش',
      latLng: const LatLng(30.157617634800218, 31.341722775916637)),
  PlaceModel(
      id: 2,
      name: 'ملعب نادي المرج',
      latLng: const LatLng(30.15111547730863, 31.340273357434395)),
];
