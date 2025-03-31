import 'package:reto_radiance/models/cart_models.dart';
import 'package:reto_radiance/models/favorite_models.dart';

class ProductModel {
  final String productId;
  final String productName;
  final String category;
  final String description;
  final List<String> productImage;
  final List<String> productSize;
  final double productPrice;
  final double discount;
  final int quantity;
  final int rating;
  final int totalReviews;
  final bool isPopular;
  final bool isRecommended;
  final bool isSoldOut;
  final String vendorId;
  final String vendorName;

  ProductModel({
    required this.productId,
    required this.productName,
    required this.category,
    required this.description,
    required this.productImage,
    required this.productSize,
    required this.productPrice,
    required this.discount,
    required this.quantity,
    required this.rating,
    required this.totalReviews,
    required this.isPopular,
    required this.isRecommended,
    required this.isSoldOut,
    required this.vendorId,
    required this.vendorName,
  });

  factory ProductModel.fromFirestore(Map<String, dynamic> data) {
    return ProductModel(
      productId: data['productId'] ?? '',
      productName: data['productName'] ?? '',
      category: data['category'] ?? '',
      description: data['description'] ?? '',
      productImage: List<String>.from(data['productImage'] ?? []),
      productSize: List<String>.from(data['productSize'] ?? []),
      productPrice: data['productPrice']?.toDouble() ?? 0,
      discount: data['discount']?.toDouble() ?? 0,
      quantity: data['quantity']?.toInt() ?? 0,
      rating: data['rating']?.toInt() ?? 0,
      totalReviews: data['totalReviews']?.toInt() ?? 0,
      isPopular: data['isPopular'] ?? false,
      isRecommended: data['isRecommended'] ?? false,
      isSoldOut: data['isSoldOut'] ?? false,
      vendorId: data['vendorId'] ?? '',
      vendorName: data['vendorName'] ?? '',
    );
  }
  CartModel toCartModel() {
    return CartModel(
      productId: this.productId,
      productName: this.productName,
      category: this.category,
      description: this.description,
      productImage: this.productImage,
      productSize: this.productSize,
      productPrice: this.productPrice,
      discount: this.discount,
      quantity: this.quantity,
      rating: this.rating,
      totalReviews: this.totalReviews,
      isPopular: this.isPopular,
      isRecommended: this.isRecommended,
      isSoldOut: this.isSoldOut,
      vendorId: this.vendorId,
      vendorName: this.vendorName,
    );
  }
  FavoriteModel toFavModel() {
    return FavoriteModel(
      productId: this.productId,
      productName: this.productName,
      category: this.category,
      description: this.description,
      productImage: this.productImage,
      productSize: this.productSize,
      productPrice: this.productPrice,
      discount: this.discount,
      quantity: this.quantity,
      rating: this.rating,
      totalReviews: this.totalReviews,
      isPopular: this.isPopular,
      isRecommended: this.isRecommended,
      isSoldOut: this.isSoldOut,
      vendorId: this.vendorId,
      vendorName: this.vendorName,
    );
  }
  
}
