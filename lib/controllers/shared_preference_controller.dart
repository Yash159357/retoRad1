import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:reto_radiance/models/cart_models.dart';
import 'package:reto_radiance/models/favorite_models.dart';
import 'dart:convert';

class SharedPreferenceController {
  final SharedPreferences _prefs;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  SharedPreferenceController(this._prefs);

  String _getUserKey(String baseKey) {
    final user = _auth.currentUser;
    if (user == null || user.uid.isEmpty) {
      throw Exception('User not authenticated');
    }
    return '${baseKey}_${user.uid}';
  }

  Future<void> saveCartData(Map<String, CartModel> cartData) async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        throw Exception('Cannot save cart data: User not authenticated');
      }

      final cartKey = _getUserKey('cartData');
      if (cartKey.isEmpty) {
        throw Exception('Cart key is invalid');
      }

      final cartJsonList =
          cartData.values.map((item) => jsonEncode(item.toJson())).toList();
      if (cartJsonList.isEmpty) {
        throw Exception('Cart data is empty, nothing to save');
      }

      // Ensure SharedPreferences is initialized
      if (_prefs == null) {
        throw Exception('SharedPreferences is not initialized');
      }

      await _prefs.setStringList(cartKey, cartJsonList);
    } catch (e) {
      print('Error saving cart data: $e');
      // rethrow;
    }
  }

  Map<String, CartModel> loadCartData() {
    try {
      final cartKey = _getUserKey('cartData');
      final cartJsonList = _prefs.getStringList(cartKey) ?? [];
      return cartJsonList.fold({}, (map, jsonString) {
        final item = CartModel.fromJson(jsonDecode(jsonString));
        return {...map, item.productId: item};
      });
    } catch (e) {
      print('Error loading cart data: $e');
      return {};
    }
  }

  Future<void> saveFavoriteData(Map<String, FavoriteModel> favoriteData) async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        throw Exception('Cannot save favorite data: User not authenticated');
      }

      final favoriteKey = _getUserKey('favoriteData');
      if (favoriteKey.isEmpty) {
        throw Exception('Favorite key is invalid');
      }

      final favoriteJsonList =
          favoriteData.values.map((item) => jsonEncode(item.toJson())).toList();
      if (favoriteJsonList.isEmpty) {
        throw Exception('Favorite data is empty, nothing to save');
      }

      await _prefs.setStringList(favoriteKey, favoriteJsonList);
    } catch (e) {
      print('Error saving favorite data: $e');
      // rethrow;
    }
  }

  Map<String, FavoriteModel> loadFavoriteData() {
    try {
      final favoriteKey = _getUserKey('favoriteData');
      final favoriteJsonList = _prefs.getStringList(favoriteKey) ?? [];
      return favoriteJsonList.fold({}, (map, jsonString) {
        final item = FavoriteModel.fromJson(jsonDecode(jsonString));
        return {...map, item.productId: item};
      });
    } catch (e) {
      print('Error loading favorite data: $e');
      return {};
    }
  }

  // Add this method to clear user-specific data on logout
  Future<void> clearUserData() async {
    final user = _auth.currentUser;
    if (user != null) {
      await Future.wait([
        _prefs.remove('favoriteData_${user.uid}'),
        _prefs.remove('cartData_${user.uid}'),
      ]);
    }
  }
}
