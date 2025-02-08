import 'package:hive/hive.dart';
part 'curuser.g.dart';

@HiveType(typeId: 0)
class CurUser extends HiveObject {
  @HiveField(0)
  String token;
  @HiveField(1)
  String userId;
  @HiveField(2)
  String lat;
  @HiveField(3)
  String long;
  CurUser({
    required this.token,
    required this.userId,
    required this.lat,
    required this.long,
  });
}
