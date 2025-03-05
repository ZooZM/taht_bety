import 'package:hive/hive.dart';

class BasketItem {
  final String postId;
  final int numberOfPieces;

  BasketItem({required this.postId, required this.numberOfPieces});
}

class BasketStorage {
  static final Box<BasketItem> _box = Hive.box<BasketItem>('basketBox');

  static Future<void> addToBasket({
    required String postId,
    required int numberOfPieces,
  }) async {
    final item = BasketItem(postId: postId, numberOfPieces: numberOfPieces);
    await _box.put(postId, item);
  }

  static BasketItem? getBasketItem(String postId) {
    return _box.get(postId);
  }

  static Future<void> removeFromBasket(String postId) async {
    await _box.delete(postId);
  }

  static List<BasketItem> getAllBasketItems() {
    return _box.values.toList();
  }
}
