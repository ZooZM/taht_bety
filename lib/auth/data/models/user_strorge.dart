import 'package:hive/hive.dart';
import 'package:taht_bety/auth/data/models/curuser.dart';

class UserStorage {
  static final Box<CurUser> _box = Hive.box<CurUser>('curUserBox');

  static Future<void> saveUserData({
    required String token,
    required String userId,
    required String lat,
    required String long,
  }) async {
    final user = CurUser(token: token, userId: userId, lat: lat, long: long);
    await _box.put('currentUser', user);
  }

  static CurUser? getUserData() {
    return _box.get('currentUser');
  }

  static Future<void> deleteUserData() async {
    await _box.delete('currentUser');
  }
}
