// //
// //
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:flutter/cupertino.dart';
// // import 'package:flutter/material.dart';
// // import 'package:reto_radiance/models/category_models.dart';
// //
// // import '../nav_screens/widgets/popularItem.dart';
// //
// // class CategoryProductScreen extends StatelessWidget {
// //   final CategoryModel categoryModel;
// //
// //   const CategoryProductScreen({super.key, required this.categoryModel});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     //Fetching only those products with same category name. 'isEqualTo' is used for matching only.
// //     final Stream<QuerySnapshot> productStream =
// //     FirebaseFirestore.instance
// //         .collection('products')
// //         .where('category', isEqualTo: categoryModel.categoryName)
// //         .snapshots();
// //
// //     return Scaffold(
// //       //Start of APP BAR
// //       appBar: AppBar(
// //         backgroundColor: Color.fromARGB(255, 255, 255, 255),
// //         title: Text(
// //           categoryModel.categoryName,
// //           style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
// //         ),
// //       ),
// //
// //       //END of APP BAR
// //       body: StreamBuilder<QuerySnapshot>(
// //         stream: productStream,
// //         builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
// //           if (snapshot.hasError) {
// //             return const Text('Something went wrong');
// //           }
// //
// //           if (snapshot.connectionState == ConnectionState.waiting) {
// //             return const Center(child: CircularProgressIndicator());
// //           }
// //
// //           if (snapshot.data!.docs.isEmpty) {
// //             //This means there is no product in this category
// //             return Center(
// //               child: Column(
// //                 children: [
// //                   Icon(
// //                     CupertinoIcons.battery_empty,
// //                   ), //Add your own button for empty.
// //                   const Text(
// //                     'No Product under this Category \nCheck Back Later',
// //                     textAlign:
// //                     TextAlign.center, //To Align the Text in the Center
// //                     style: TextStyle(
// //                       fontSize: 18,
// //                       // color: Colors.white,
// //                       fontWeight: FontWeight.bold,
// //                       letterSpacing: 1.7,
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             );
// //           }
// //
// //           return Padding(
// //             padding: const EdgeInsets.all(10.0),
// //             child: GridView.count(
// //               physics: ScrollPhysics(), //This will make it Scrollable
// //               shrinkWrap: true,
// //               crossAxisCount: 3, //How many items we will have in each Row
// //               mainAxisSpacing: 15, //Vertical Spacing
// //               crossAxisSpacing: 15, //Space between each product horizontally
// //               childAspectRatio: 300 / 500, //Format: width/height
// //
// //               children: List.generate(snapshot.data!.size, (index) {
// //                 final productData = snapshot.data!.docs[index];
// //
// //                 //Designing our Each Grid Tile
// //                 return PopularItem(productData: productData);
// //               }),
// //             ),
// //           );
// //         },
// //       ),
// //     );
// //   }
// // }





// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:reto_radiance/models/category_models.dart';

// import '../nav_screens/widgets/popularItem.dart';

// class CategoryProductScreen extends StatelessWidget {
//   final CategoryModel categoryModel;

//   const CategoryProductScreen({super.key, required this.categoryModel});

//   @override
//   Widget build(BuildContext context) {
//     //Fetching only those products with same category name. 'isEqualTo' is used for matching only.
//     final Stream<QuerySnapshot> productStream =
//     FirebaseFirestore.instance
//         .collection('products')
//         .where('category', isEqualTo: categoryModel.categoryName)
//         .snapshots();

//     return Scaffold(
//       //Start of APP BAR
//       appBar: AppBar(
//         backgroundColor: Color.fromARGB(255, 255, 255, 255),
//         title: Text(
//           categoryModel.categoryName,
//           style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
//         ),
//       ),

//       //END of APP BAR
//       body: StreamBuilder<QuerySnapshot>(
//         stream: productStream,
//         builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (snapshot.hasError) {
//             return const Text('Something went wrong');
//           }

//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           if (snapshot.data!.docs.isEmpty) {
//             //This means there is no product in this category
//             return Center(
//               child: Column(
//                 children: [
//                   Icon(
//                     CupertinoIcons.battery_empty,
//                   ), //Add your own button for empty.
//                   const Text(
//                     'No Product under this Category \nCheck Back Later',
//                     textAlign:
//                     TextAlign.center, //To Align the Text in the Center
//                     style: TextStyle(
//                       fontSize: 18,
//                       // color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                       letterSpacing: 1.7,
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           }

//           return Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: GridView.count(
//               physics: ScrollPhysics(), //This will make it Scrollable
//               shrinkWrap: true,
//               crossAxisCount: 2, //How many items we will have in each Row
//               mainAxisSpacing: 15, //Vertical Spacing
//               crossAxisSpacing: 15, //Space between each product horizontally
//               childAspectRatio: 300 / 400, //Format: width/height

//               children: List.generate(snapshot.data!.size, (index) {
//                 final productData = snapshot.data!.docs[index];

//                 //Designing our Each Grid Tile
//                 return PopularItem(productData: productData);
//               }),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reto_radiance/models/category_models.dart';
import 'package:reto_radiance/models/product_model.dart';
import 'package:reto_radiance/provider/product_provider.dart';
import '../nav_screens/widgets/popularItem.dart';

class CategoryProductScreen extends ConsumerStatefulWidget {
  final CategoryModel categoryModel;

  const CategoryProductScreen({super.key, required this.categoryModel});

  @override
  ConsumerState<CategoryProductScreen> createState() => _CategoryProductScreenState();
}

class _CategoryProductScreenState extends ConsumerState<CategoryProductScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(productProvider.notifier).fetchAllProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final products = ref.watch(productProvider);
    final filteredProducts = products.where(
      (product) => product.category == widget.categoryModel.categoryName
    ).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          widget.categoryModel.categoryName,
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        ),
      ),
      body: _buildBody(filteredProducts),
    );
  }

  Widget _buildBody(List<ProductModel> products) {
    if (products.isEmpty) {
      return _buildEmptyState();
    }

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GridView.count(
        physics: const ScrollPhysics(),
        shrinkWrap: true,
        crossAxisCount: 2,
        mainAxisSpacing: 15,
        crossAxisSpacing: 15,
        childAspectRatio: 300 / 400,
        children: products.map((product) => PopularItem(productData: product)).toList(),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        children: [
          const Icon(CupertinoIcons.battery_empty),
          const Text(
            'No Product under this Category \nCheck Back Later',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.7,
            ),
          ),
        ],
      ),
    );
  }
}