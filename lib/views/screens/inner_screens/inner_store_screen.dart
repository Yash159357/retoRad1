

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// import '../nav_screens/widgets/popularItem.dart';

// class InnerStoreScreen extends StatefulWidget {
//   final String vendorid;

//   const InnerStoreScreen({super.key, required this.vendorid});


//   @override
//   State<InnerStoreScreen> createState() => _InnerStoreScreenState();
// }

// class _InnerStoreScreenState extends State<InnerStoreScreen> {
//   @override
//   Widget build(BuildContext context) {

//     final Stream<QuerySnapshot> productStream = FirebaseFirestore.instance.collection('products').where('vendorId', isEqualTo: widget.vendorid).snapshots();

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Products',
//           style: GoogleFonts.montserrat(
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),

//       body: StreamBuilder<QuerySnapshot>(
//         stream: productStream,
//         builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (snapshot.hasError) {
//             return const Text('Something went wrong');
//           }

//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           }

//           if(snapshot.data!.docs.isEmpty){ //This means there is no product in this category
//             return Center(
//               child: Column(
//                 children: [
//                   Icon(CupertinoIcons.battery_empty), //Add your own button for empty.
//                   const Text('No Product under this Vendor \nCheck Back Later',
//                     textAlign: TextAlign.center, //To Align the Text in the Center
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

//           return GridView.count(
//             physics: ScrollPhysics(), //This will make it Scrollable
//             shrinkWrap: true,
//             crossAxisCount: 3, //How many items we will have in each Row
//             mainAxisSpacing: 15, //Vertical Spacing
//             crossAxisSpacing: 15, //Space between each product horizontally
//             childAspectRatio: 300/500, //Format: width/height

//             children: List.generate(snapshot.data!.size, (index) {
//               final productData = snapshot.data!.docs[index];

//               //Designing our Each Grid Tile
//               return PopularItem(productData: productData);

//             },
//             ),


//           );
//         },
//       ),

//     );
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reto_radiance/models/product_model.dart'; // Add this import
import '../nav_screens/widgets/popularItem.dart';

class InnerStoreScreen extends StatefulWidget {
  final String vendorid;

  const InnerStoreScreen({super.key, required this.vendorid});

  @override
  State<InnerStoreScreen> createState() => _InnerStoreScreenState();
}

class _InnerStoreScreenState extends State<InnerStoreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products',
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: StreamBuilder<List<ProductModel>>(
        stream: _getProductsStream(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final products = snapshot.data ?? [];
          
          if (products.isEmpty) {
            return _buildEmptyState();
          }

          return _buildProductGrid(products);
        },
      ),
    );
  }

  Stream<List<ProductModel>> _getProductsStream() {
    return FirebaseFirestore.instance
        .collection('products')
        .where('vendorId', isEqualTo: widget.vendorid)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => ProductModel.fromFirestore(doc.data()))
            .toList());
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        children: [
          const Icon(CupertinoIcons.battery_empty),
          const Text(
            'No Product under this Vendor \nCheck Back Later',
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

  Widget _buildProductGrid(List<ProductModel> products) {
    return GridView.count(
      physics: const ScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 3,
      mainAxisSpacing: 15,
      crossAxisSpacing: 15,
      childAspectRatio: 300 / 500,
      children: products.map((product) => PopularItem(productData: product)).toList(),
    );
  }
}