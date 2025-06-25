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
  @HiveField(4)
  String name;
  @HiveField(5)
  String email;
  @HiveField(6)
  String photo;
  @HiveField(7)
  String phoneNumber;
  @HiveField(8)
  List<String> favProviders;
  @HiveField(9)
  String address;
  CurUser({
    required this.token,
    required this.userId,
    required this.lat,
    required this.long,
    required this.name,
    required this.email,
    required this.photo,
    required this.phoneNumber,
    required this.favProviders,
    required this.address,
  });
}
