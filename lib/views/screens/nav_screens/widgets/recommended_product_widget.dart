// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reto_radiance/models/product_model.dart';
import 'package:reto_radiance/views/screens/nav_screens/widgets/product_item_widget.dart';

class RecommendedProductWidget extends StatefulWidget {
  const RecommendedProductWidget({
    super.key,
    required this.recommendedProducts,
  });
  final List<ProductModel> recommendedProducts;

  @override
  State<RecommendedProductWidget> createState() =>
      RecommendedProductWidgetState();
}

class RecommendedProductWidgetState extends State<RecommendedProductWidget> {
  // void onSearch(String query) {
  //   setState(() {
  //     _searchQuery = query.toLowerCase();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // print(6);
    if (widget.recommendedProducts.isEmpty) {
      return const Center(
        child: Text(
          'No items found',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      );
    }
    return SizedBox(
      height: 300,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.recommendedProducts.length,
        itemBuilder: (context, index) {
          final productData = widget.recommendedProducts[index];
          return ProductItemWidget(productData: productData);
        },
      ),
    );

    // final Stream<QuerySnapshot> productsStream =
    //     FirebaseFirestore.instance
    //         .collection('products')
    //         .where('isRecommended', isEqualTo: true)
    //         .snapshots();

    // return StreamBuilder<QuerySnapshot>(
    //   stream: productsStream,
    //   builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    //     if (snapshot.hasError) {
    //       return const Text('Something went wrong');
    //     }

    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       return const Center(child: CircularProgressIndicator());
    //     }

    //     final products =
    //         snapshot.data!.docs.where((product) {
    //           final productName =
    //               product['productName'].toString().toLowerCase();
    //           return productName.contains(widget.searchQuery);
    //         }).toList();

    //     if (products.isEmpty) {
    //       return const Center(
    //         child: Text(
    //           'No items found',
    //           style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
    //         ),
    //       );
    //     }

    //     return SizedBox(
    //       height: 250,
    //       child: ListView.builder(
    //         scrollDirection: Axis.horizontal,
    //         itemCount: products.length,
    //         itemBuilder: (context, index) {
    //           final productData = products[index];
    //           return ProductItemWidget(productData: productData);
    //         },
    //       ),
    //     );
    //   },
    // );
  }
}
