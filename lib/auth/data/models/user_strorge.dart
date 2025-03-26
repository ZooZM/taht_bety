import 'package:hive/hive.dart';
import 'package:taht_bety/auth/data/models/curuser.dart';
import 'package:taht_bety/constants.dart';

class UserStorage {
  static late final Box<CurUser> _box;
  static Future<void> init() async {
    if (!Hive.isBoxOpen(kCurUserBox)) {
      _box = await Hive.openBox<CurUser>(kCurUserBox);
    } else {
      _box = Hive.box<CurUser>(kCurUserBox);
    }
  }

  static Future<void> saveUserData({
    required String? token,
    required String? userId,
    required String? lat,
    required String? long,
    required String? name,
    required String? email,
    required String? photo,
    required String? phoneNamber,
  }) async {
    final user = CurUser(
      token: token ?? "unknown",
      userId: userId ?? "unknown",
      lat: lat ?? "0.0",
      long: long ?? "0.0",
      name: name ?? "unknown",
      email: email ?? "unknown@example.com",
      photo: photo ?? "default_photo_url",
      phoneNamber: phoneNamber ?? "unknown",
    );

    await _box.put(kCurUserBox, user);
  }

  static CurUser getUserData() {
    return _box.get(kCurUserBox) ??
        CurUser(
          token: '',
          userId: '',
          lat: '',
          long: '',
          name: 'unknown',
          email: 'unknown@example.com',
          photo: 'default_photo_url',
          phoneNamber: 'unknown',
        );
  }

  static Future<void> deleteUserData() async {
    await _box.delete(kCurUserBox);
  }
}
