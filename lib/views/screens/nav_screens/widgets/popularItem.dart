//
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
//
// import '../../inner_screens/product_detail_screen.dart';
//
// class PopularItem extends StatelessWidget {
//   const PopularItem({super.key, required this.productData});
//
//   final QueryDocumentSnapshot<Object?> productData;
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) {
//               return ProductDetailScreen(productData: productData);
//             },
//           ),
//         );
//       },
//
//       child: Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10),
//           color: const Color.fromARGB(255, 252, 220, 189),
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             const SizedBox(height: 10),
//
//             ClipRRect(
//               //We are using this so that our Product Image can be Circular
//               borderRadius: BorderRadius.circular(6),
//               child: Container(
//                 width: 87,
//                 height: 81,
//                 decoration: BoxDecoration(
//                   color: const Color.fromARGB(255, 255, 255, 255),
//                   borderRadius: BorderRadius.circular(5),
//                 ),
//
//                 child: Image.network(
//                   productData['productImage'][0], //Displaying only the first image of the Product.
//                   width: 71,
//                   height: 71,
//                   fit: BoxFit.contain,
//                 ),
//               ),
//             ),
//
//             const SizedBox(height: 10),
//
//             Text(
//               '₹${productData['discount']}', //Displaying the discounted price as this is the price that the customer will pay for the product
//               style: const TextStyle(
//                 fontSize: 17,
//                 color: Color(0xFF1E3354),
//                 fontWeight: FontWeight.w600,
//                 letterSpacing: 0.4,
//               ),
//             ),
//             const SizedBox(height: 5),
//
//             Center(
//               child: Text(
//                 productData['productName'], //Displaying the Product Name.
//                 style: const TextStyle(
//                   fontSize: 14,
//                   color: Color.fromARGB(255, 0, 0, 0),
//                   fontWeight: FontWeight.w600,
//                   letterSpacing: 0.4,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }








// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reto_radiance/models/product_model.dart';

import '../../inner_screens/product_detail_screen.dart';

class PopularItem extends StatelessWidget {
  const PopularItem({super.key, required this.productData});

  final ProductModel productData;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return ProductDetailScreen(productData: productData);
            },
          ),
        );
      },

      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color.fromARGB(255, 252, 220, 189),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),

            ClipRRect(
              //We are using this so that our Product Image can be Circular
              borderRadius: BorderRadius.circular(6),
              child: Container(
                width: 107,
                height: 101,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(5),
                ),

                child: Image.network(
                  productData.productImage[0], //Displaying only the first image of the Product.
                  width: 91,
                  height: 101,
                  fit: BoxFit.contain,
                ),
              ),
            ),

            const SizedBox(height: 10),
            Text(
              '₹${productData.productPrice}', //Displaying the original product price of our Recommended Product. The second '$' is for concatenating 2 strings.
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 14,
                letterSpacing: 0.3,
                fontWeight: FontWeight.bold,
                decoration:
                TextDecoration
                    .lineThrough, //This will make a struck or cut (by drawing a line in middle) in our Text, because we want to highlight our discounted price and want our customers to notice that and cut our original price like we normally do in our marketing.
              ),
            ),

            const SizedBox(height: 5),
            Text(
              '₹${productData.discount}', //Displaying the discounted price as this is the price that the customer will pay for the product
              style: const TextStyle(
                fontSize: 20,
                color: Color(0xFF1E3354),
                fontWeight: FontWeight.w600,
                letterSpacing: 0.4,
              ),
            ),

            const SizedBox(height: 5),
            Center(
              child: Text(
                productData.productName, //Displaying the Product Name.
                style: const TextStyle(
                  fontSize: 18,
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
