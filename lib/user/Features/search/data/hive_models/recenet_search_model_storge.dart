import 'package:hive/hive.dart';
import 'package:taht_bety/constants.dart';
import 'recent_search_model.dart';

class RecentSearchModelStorage {
  static final Box<RecentSearchModel> _box =
      Hive.box<RecentSearchModel>(kRecentSearchBox);

  static Future<void> addSearch({required String name}) async {
    final search = RecentSearchModel(
      id: (DateTime.now().microsecondsSinceEpoch ~/ 1000) % 0xFFFFFFFF,
      name: name,
      timestamp: DateTime.now(),
    );

    await _box.put(search.id, search);
  }

  static List<RecentSearchModel> getAllSearches() {
    return _box.values.toList()
      ..sort((a, b) => b.timestamp.compareTo(a.timestamp));
  }

  static Future<void> deleteSearch(int id) async {
    await _box.delete(id);
  }

  static Future<void> clearAllSearches() async {
    await _box.clear();
  }
}
