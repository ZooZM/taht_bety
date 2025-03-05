import 'package:hive/hive.dart';

part 'basket_model.g.dart';

@HiveType(typeId: 0)
class BasketModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String postId;

  @HiveField(2)
  final int count;
  @HiveField(3)
  final String providerId;

  BasketModel({
    required this.id,
    required this.postId,
    required this.count,
    required this.providerId,
  });
}
