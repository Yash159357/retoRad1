import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reto_radiance/models/favorite_models.dart';
import 'package:reto_radiance/provider/shared_preference_provider.dart';
import 'package:reto_radiance/controllers/shared_preference_controller.dart';

final favoriteProvider =
    StateNotifierProvider<FavoriteNotifier, Map<String, FavoriteModel>>((ref) {
  // Use the controller provider directly
  final controller = ref.watch(sharedPreferenceControllerProvider);
  return FavoriteNotifier(controller);
});

class FavoriteNotifier extends StateNotifier<Map<String, FavoriteModel>> {
  final SharedPreferenceController _prefsController;

  FavoriteNotifier(this._prefsController)
      : super(_prefsController.loadFavoriteData());

  void _saveState() {
    _prefsController.saveFavoriteData(state);
  }

  // Function to add a product to the Favorite list.
  void addProductToFavorite({
    required String productName,
    required String productId,
    required List<String> productImage,
    required double productPrice,
    required String category,
    required double discount,
    required String description,
    required bool isSoldOut,
    required List<String> productSize,
    required int quantity,
    required String vendorId,
    required String vendorName,
    // Optional parameters with defaults:
    int rating = 0,
    int totalReviews = 0,
    bool isPopular = false,
    bool isRecommended = false,
  }) {
    state[productId] = FavoriteModel(
      productId: productId,
      productName: productName,
      category: category,
      description: description,
      productImage: productImage,
      productSize: productSize,
      productPrice: productPrice,
      discount: discount,
      quantity: quantity,
      rating: rating,
      totalReviews: totalReviews,
      isPopular: isPopular,
      isRecommended: isRecommended,
      isSoldOut: isSoldOut,
      vendorId: vendorId,
      vendorName: vendorName,
    );

    // Notify listeners by updating the state.
    state = {...state};
    _saveState();
  }

  // Function to remove all products from Favorite.
  void removeAllItem() {
    state.clear();
    state = {...state};
    _saveState();
  }

  // Function to remove a particular product by productId.
  void removeItem(String productId) {
    state.remove(productId);
    state = {...state};
    _saveState();
  }

  void removeProductFromFavorite(String productId) {
    state = {...state..remove(productId)};
    _saveState();
  }

  // Getter to retrieve the current favorite items.
  Map<String, FavoriteModel> get getFavoriteItem => state;
}
