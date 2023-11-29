// preferences_repository.dart
import 'package:shared_preferences/shared_preferences.dart';

abstract interface class IPreferencesRepository {

  Future<bool> getFavoriteStatus(int bookId);

  Future<void> setFavoriteStatus(int bookId, bool isFavorite);
}

class PreferencesRepository implements IPreferencesRepository{
  static const String favoriteKeyPrefix = 'favorite_';

  @override
  Future<bool> getFavoriteStatus(int bookId) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('$favoriteKeyPrefix$bookId') ?? false;
  }

  @override
  Future<void> setFavoriteStatus(int bookId, bool isFavorite) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('$favoriteKeyPrefix$bookId', isFavorite);
  }
}
