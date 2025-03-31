

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reto_radiance/models/cart_models.dart';
import 'package:reto_radiance/controllers/shared_preference_controller.dart';
import 'package:reto_radiance/provider/shared_preference_provider.dart';
import 'package:reto_radiance/models/product_model.dart';

final cartProvider =
StateNotifierProvider<CartNotifier, Map<String, CartModel>>((ref) {
  // Change this to use the controller provider
  final controller = ref.watch(sharedPreferenceControllerProvider);
  return CartNotifier(controller);
});

//StateNotifier will help us to keep track of CartNotifier data,i.e., the products we are moving to cart, the products we are removing from cart,etc. It keeps track by updating the UI accordingly.
class CartNotifier extends StateNotifier<Map<String, CartModel>> {
  final SharedPreferenceController _prefsHelper;

  CartNotifier(this._prefsHelper) : super(_prefsHelper.loadCartData());

  void _saveState() {
    _prefsHelper.saveCartData(state);
  }

  void addProductToCart({
    required ProductModel product,
    required BuildContext context,
  }) {
    if (product.isSoldOut) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          margin: const EdgeInsets.all(15),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.grey,
          content: Text('${product.productName} is out of stock.'),
        ),
      );
      return;
    }

    state = state.containsKey(product.productId)
        ? {
            ...state,
            product.productId: state[product.productId]!.copyWith(
              quantity: state[product.productId]!.quantity + 1,
            ),
          }
        : {
            ...state,
            product.productId: CartModel(
              productId: product.productId,
              productName: product.productName,
              category: product.category,
              description: product.description,
              productImage: product.productImage,
              productSize: product.productSize,
              productPrice: product.productPrice,
              discount: product.discount,
              quantity: 1,
              rating: product.rating,
              totalReviews: product.totalReviews,
              isPopular: product.isPopular,
              isRecommended: product.isRecommended,
              isSoldOut: product.isSoldOut,
              vendorId: product.vendorId,
              vendorName: product.vendorName,
            ),
          };

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        margin: const EdgeInsets.all(15),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.grey,
        content: Text('Added to Cart: ${product.productName}'),
      ),
    );
    _saveState();
  }

  // Add copyWith method to CartModel
  // Add this inside your CartModel class:
  // CartModel copyWith({int? quantity}) => CartModel(
  //   productId: productId,
  //   productName: productName,
  //   category: category,
  //   description: description,
  //   productImage: productImage,
  //   productSize: productSize,
  //   productPrice: productPrice,
  //   discount: discount,
  //   quantity: quantity ?? this.quantity,
  //   rating: rating,
  //   totalReviews: totalReviews,
  //   isPopular: isPopular,
  //   isRecommended: isRecommended,
  //   isSoldOut: isSoldOut,
  //   vendorId: vendorId,
  //   vendorName: vendorName,
  // );

  void removeItem(String productId) {
    state = {...state..remove(productId)};
    _saveState();
  }

  void incrementItem(String productId) {
    state = {
      ...state,
      productId: state[productId]!.copyWith(
        quantity: state[productId]!.quantity + 1
      ),
    };
    _saveState();
  }

  void decrementItem(String productId) {
    if (state.containsKey(productId) && state[productId]!.quantity > 1) {
      final currentQuantity = state[productId]!.quantity;
      state = {
        ...state,
        productId: state[productId]!.copyWith(
          quantity: currentQuantity > 1 ? currentQuantity - 1 : 1
        ),
      };
      } 
    _saveState();
  }

  double calculateTotalAmount() {
    return state.values.fold(0.0, (total, item) {
      return total + (item.quantity * item.discount);
    });
  }

  void clearCartData() {
    state = {};
    _saveState();
  }

  Map<String, CartModel> get getCartItem => state;
}
// this will help us to get the CartItem from the CartProvider. We can use this in our CartScreen to get the CartItem and show it in the UI.