import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reto_radiance/models/product_model.dart';

final productProvider =
    StateNotifierProvider<ProductNotifier, List<ProductModel>>(
      (ref) => ProductNotifier(),
    );

class ProductNotifier extends StateNotifier<List<ProductModel>> {
  ProductNotifier() : super([]);

  Future<void> fetchAllProducts() async {
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection('products').get();

      final products =
          snapshot.docs
              .map((doc) => ProductModel.fromFirestore(doc.data()))
              .toList();
      // print("Products: $products");
      state = products;
    } catch (e) {
      throw Exception('Failed to fetch products: $e');
    }
  }

  // Filter functions
  List<ProductModel> getPopularProducts() {
    return state.where((product) => product.isPopular).toList();
  }

  List<ProductModel> getRecommendedProducts() {
    return state.where((product) => product.isRecommended).toList();
  }
}
