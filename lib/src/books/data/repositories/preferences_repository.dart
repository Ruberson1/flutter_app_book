import 'package:shared_preferences/shared_preferences.dart';

abstract class IPreferencesRepository {
  Future<List<int>> getFavoriteBookIds();
  Future<void> addFavoriteBookId(int bookId);
  Future<void> removeFavoriteBookId(int bookId);
}

class PreferencesRepository implements IPreferencesRepository {
  static const String favoriteKeyPrefix = 'favorite_';

  @override
  Future<List<int>> getFavoriteBookIds() async {
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys();
    final favoriteKeys = keys.where((key) => key.startsWith(favoriteKeyPrefix));

    final favoriteBookIds =
        favoriteKeys.map((key) => int.parse(key.substring(favoriteKeyPrefix.length))).toList();

    return favoriteBookIds;
  }

  @override
  Future<void> addFavoriteBookId(int bookId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('$favoriteKeyPrefix$bookId', true);
  }

  @override
  Future<void> removeFavoriteBookId(int bookId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('$favoriteKeyPrefix$bookId');
  }
}
