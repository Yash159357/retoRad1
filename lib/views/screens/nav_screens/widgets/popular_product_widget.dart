// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reto_radiance/models/product_model.dart';
import 'package:reto_radiance/views/screens/nav_screens/widgets/product_item_widget.dart';

class PopularProductWidget extends StatefulWidget {
  const PopularProductWidget({super.key, required this.popularProducts});
  final List<ProductModel> popularProducts;

  @override
  State<PopularProductWidget> createState() => PopularProductWidgetState();
}

class PopularProductWidgetState extends State<PopularProductWidget> {
  @override
  Widget build(BuildContext context) {
    // print(6);
    if (widget.popularProducts.isEmpty) {
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
        itemCount: widget.popularProducts.length,
        itemBuilder: (context, index) {
          final productData = widget.popularProducts[index];
          return ProductItemWidget(productData: productData);
        },
      ),
    );
    // return StreamBuilder<QuerySnapshot>(
    //   stream:
    //       FirebaseFirestore.instance
    //           .collection('products')
    //           .where('isPopular', isEqualTo: true)
    //           .snapshots(),
    //   builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    //     if (snapshot.hasError) {
    //       return const Text('Something went wrong');
    //     }

    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       return const Center(child: CircularProgressIndicator());
    //     }

    //     final filteredProducts =
    //         snapshot.data!.docs.where((product) {
    //           final productName =
    //               product['productName'].toString().toLowerCase();
    //           return productName.contains(_searchQuery);
    //         }).toList();

    //     if (filteredProducts.isEmpty) {
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
    //         itemCount: filteredProducts.length,
    //         itemBuilder: (context, index) {
    //           final productData = filteredProducts[index];
    //           return ProductItemWidget(productData: productData);
    //         },
    //       ),
    //     );
    //   },
    // );
  }
}
