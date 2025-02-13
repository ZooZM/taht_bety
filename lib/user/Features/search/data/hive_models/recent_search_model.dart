import 'package:hive_flutter/hive_flutter.dart';
part 'recent_search_model.g.dart';

@HiveType(typeId: 1)
class RecentSearchModel {
  @HiveField(0)
  int id;
  @HiveField(1)
  String name;
  @HiveField(2)
  DateTime timestamp;

  RecentSearchModel(
      {required this.id, required this.name, required this.timestamp});
}
