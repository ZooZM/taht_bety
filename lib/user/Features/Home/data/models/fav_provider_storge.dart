import 'package:hive/hive.dart';
import 'fav_provider_model.dart';

class FavProviderStorage {
  static const String _boxName = 'favProvidersBox';
  static Box<FavProviderModel>? _box;

  /// تهيئة Hive وفتح الصندوق
  static Future<void> init() async {
    if (!Hive.isAdapterRegistered(3)) {
      Hive.registerAdapter(FavProviderModelAdapter()); // تسجيل الـ Adapter
    }
    _box = await Hive.openBox<FavProviderModel>(_boxName);
  }

  /// فتح صندوق Hive (إذا لم يكن مفتوحًا)
  static Future<Box<FavProviderModel>> _openBox() async {
    if (_box == null) {
      await init();
    }
    return _box!;
  }

  /// إضافة مزود جديد أو تحديثه إذا كان موجودًا
  static Future<void> saveProvider(FavProviderModel provider) async {
    final box = await _openBox();
    await box.put(provider.id, provider); // استخدام id كمفتاح
  }

  /// استرجاع مزود باستخدام id
  static Future<FavProviderModel?> getProvider(String id) async {
    final box = await _openBox();
    return box.get(id);
  }

  /// استرجاع جميع المزودين
  static Future<List<FavProviderModel>> getAllProviders() async {
    final box = await _openBox();
    return box.values.toList();
  }

  /// حذف مزود باستخدام id
  static Future<void> deleteProvider(String id) async {
    final box = await _openBox();
    await box.delete(id);
  }

  /// حذف جميع المزودين
  static Future<void> clearProviders() async {
    final box = await _openBox();
    await box.clear();
  }

  /// التحقق مما إذا كان مزود موجودًا في المفضلة
  static Future<bool> isFavorite(String id) async {
    final box = await _openBox();
    return box.containsKey(id);
  }
}
