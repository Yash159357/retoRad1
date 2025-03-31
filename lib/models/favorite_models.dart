

//Details of Product we will show in Favorite Screen

class FavoriteModel {
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


  FavoriteModel({
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
  // conversion to json for local storage
  Map<String, dynamic> toJson() => {
  'productId': productId,
  'productName': productName,
  'category': category,
  'description': description,
  'productImage': productImage,
  'productSize': productSize,
  'productPrice': productPrice,
  'discount': discount,
  'quantity': quantity,
  'rating': rating,
  'totalReviews': totalReviews,
  'isPopular': isPopular,
  'isRecommended': isRecommended,
  'isSoldOut': isSoldOut,
  'vendorId': vendorId,
  'vendorName': vendorName,
};

  // conversion from storage to convert it into cartmodel instances
  factory FavoriteModel.fromJson(Map<String, dynamic> data) => FavoriteModel(
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
