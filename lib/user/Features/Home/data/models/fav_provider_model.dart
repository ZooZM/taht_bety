import 'package:hive/hive.dart';

part 'fav_provider_model.g.dart';

@HiveType(typeId: 3)
class FavProviderModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String providerType;

  @HiveField(3)
  final String imageUrl;

  @HiveField(4)
  final double? distance;

  FavProviderModel({
    required this.id,
    required this.name,
    required this.providerType,
    required this.imageUrl,
    required this.distance,
  });
}
