// // //This page will create the product design which will appear in tiles in Home Screen.

// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:reto_radiance/models/product_model.dart';
// import 'package:reto_radiance/provider/cart_provider.dart';
// import 'package:reto_radiance/provider/favorite_provider.dart';
// import 'package:reto_radiance/views/screens/inner_screens/product_detail_screen.dart';

// class ProductItemWidget extends ConsumerStatefulWidget {
//   final ProductModel productData;

//   const ProductItemWidget({super.key, required this.productData});

//   @override
//   _ProductItemWidgetState createState() => _ProductItemWidgetState();
// }

// class _ProductItemWidgetState extends ConsumerState<ProductItemWidget> {
//   @override
//   Widget build(BuildContext context) {
//     final cartProviderData = ref.read(
//       cartProvider.notifier,
//     ); //Accessing details and state from 'cart_provider' page and for that only we converted to ConsumerStatefulWidget which is only available in Flutter Riverpod.

//     final favoriteProviderData = ref.read(favoriteProvider.notifier);

//     ref.watch(favoriteProvider);
//     return InkWell(
//       onTap: () {
//         //Whenever we will click on this product small tile we will be taken to the product detail screen of that particular product.
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) {
//               return ProductDetailScreen(
//                 productData: widget.productData,
//               ); //We have a 'productData' variable here which is used to fetch product details from our Firebase and we have a productData variable in 'product_detail_screen' page as well which will take the datas from the variable of this page and pass it to our 'product_detail_screen' page where we will show product details elaborately.
//             },
//           ),
//         );
//       },
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Container(
//           //This is the main tile or grid where our product will be displayed in our Home Screen
//           width: 146,
//           height: 245,
//           clipBehavior: Clip.antiAlias,
//           decoration: BoxDecoration(),
//           child: Stack(
//             //In Stack everything is displayed on top of another.
//             clipBehavior: Clip.none,
//             children: [
//               Positioned(
//                 left: 0,
//                 top: 0,
//                 child: Container(
//                   width: 146,
//                   height: 245,
//                   clipBehavior: Clip.antiAlias,
//                   decoration: BoxDecoration(
//                     color: const Color.fromARGB(255, 254, 245, 245),
//                     borderRadius: BorderRadius.circular(4),
//                     boxShadow: const [
//                       BoxShadow(
//                         color: Color(0x0f040828),
//                         spreadRadius: 0,
//                         offset: Offset(0, 18),
//                         blurRadius: 30,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),

//               Positioned(
//                 left: 7,
//                 top: 130,
//                 child: Text(
//                   widget
//                       .productData
//                       .productName, //Accessing our Product Name from Firebase
//                   style: GoogleFonts.lato(
//                     color: Color(0xFF1E3354),
//                     fontSize: 15,
//                     fontWeight: FontWeight.bold,
//                     letterSpacing: 0.3,
//                   ),
//                 ),
//               ),

//               Positioned(
//                 left: 7,
//                 top: 177,
//                 child: Text(
//                   widget
//                       .productData
//                       .category, //Displaying the category of our Recommended Product
//                   style: GoogleFonts.lato(
//                     color: Color(0xFF7F8E9D),
//                     fontSize: 12,
//                     letterSpacing: 0.2,
//                   ),
//                 ),
//               ),

//               Positioned(
//                 left: 10,
//                 top: 200,
//                 child: Text(
//                   '₹${widget.productData.discount}', //Displaying the discounted product price of our Recommended Product. I guess the second '$' is for concatenating 2 strings. I replaced the first '$' with '₹', now let's see what happens.
//                   style: GoogleFonts.lato(
//                     color: const Color(
//                       0xFF1E3354,
//                     ), //Never use 'const' before 'GoogleFonts'
//                     fontSize: 18,
//                     fontWeight: FontWeight.w600,
//                     letterSpacing: 0.4,
//                   ),
//                 ),
//               ),

//               Positioned(
//                 left: 80,
//                 top: 203,
//                 child: Text(
//                   '₹${widget.productData.productPrice}', //Displaying the original product price of our Recommended Product. The second '$' is for concatenating 2 strings.
//                   style: const TextStyle(
//                     color: Colors.grey,
//                     fontSize: 14,
//                     letterSpacing: 0.3,
//                     fontWeight: FontWeight.bold,
//                     decoration:
//                         TextDecoration
//                             .lineThrough, //This will make a struck or cut (by drawing a line in middle) in our Text, because we want to highlight our discounted price and want our customers to notice that and cut our original price like we normally do in our marketing.
//                   ),
//                 ),
//               ),

//               //Section for displaying the Product Image of our Recommended Product
//               Positioned(
//                 left: 9,
//                 top: 9,
//                 child: Container(
//                   width: 128,
//                   height: 108,

//                   clipBehavior: Clip.antiAlias,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(3),
//                   ),

//                   child: Stack(
//                     //This Stack is mainly for the Product Image
//                     clipBehavior: Clip.none,
//                     children: [
//                       Positioned(
//                         left: -1,
//                         top: -1,
//                         child: Container(
//                           width: 130,
//                           height: 110,
//                           decoration: BoxDecoration(
//                             color: Color.fromARGB(255, 255, 255, 255),
//                             border: Border.all(width: 0.8, color: Colors.white),
//                             borderRadius: BorderRadius.circular(4),
//                           ),
//                         ),
//                       ),

//                       Positioned(
//                         left: 14,
//                         top: 4,
//                         child: Opacity(
//                           opacity: 0.5,
//                           child: Container(
//                             width: 100,
//                             height: 100,
//                             clipBehavior: Clip.antiAlias,
//                             decoration: BoxDecoration(
//                               color: const Color.fromARGB(255, 250, 177, 121),
//                               borderRadius: BorderRadius.circular(50),
//                             ),
//                           ),
//                         ),
//                       ),

//                       //Finally Displaying the Image
//                       Positioned(
//                         left: 10,
//                         top: -10,
//                         child: CachedNetworkImage(
//                           imageUrl:
//                               widget
//                                   .productData
//                                   .productImage[0], //There may be many Product Images but we want to display the first one so we are mentioning '0'
//                           width:
//                               108, //Width of every product image in our displayed tile
//                           height:
//                               107, //Height of every product image in our displayed tile
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),

//               //Section to show how many Quantities of this particular product has been sold
//               Positioned(
//                 left: 76,
//                 top: 155,
//                 child: Text(
//                   widget.productData.totalReviews == 0
//                       ? ''
//                       : 'SOLD: ${widget.productData.totalReviews.toString()}', //Displaying the category of our Recommended Product
//                   style: GoogleFonts.lato(
//                     color: const Color(0xFF7F8E9D),
//                     fontSize: 12,
//                     // letterSpacing: 0.2,
//                   ),
//                 ),
//               ),

//               //Section to show Ratings of this particular product.
//               Positioned(
//                 left: 23,
//                 top: 155,
//                 child: Text(
//                   //Displaying the rating of our Recommended Product
//                   widget.productData.rating == 0
//                       ? ''
//                       : widget.productData.rating
//                           .toString(), //If product rating is 0 then show nothing else show the product rating
//                   style: GoogleFonts.lato(
//                     color: const Color(0xFF7F8E9D),
//                     fontSize: 12,
//                     // letterSpacing: 0.2,
//                   ),
//                 ),
//               ),

//               //Star Icon beside Product Rating
//               widget.productData.rating == 0
//                   ? const SizedBox()
//                   : const Positioned(
//                     //If product rating is 0 then show nothing else show the star icon.
//                     left: 8,
//                     top: 158,
//                     child: Icon(Icons.star, color: Colors.amber, size: 12),
//                   ),

//               //Box or Container where our Wishlist or Favourite Button for a particular product will be shown.
//               // Positioned(
//               //   left: 104,
//               //   top: 15,
//               //   child: Container(
//               //     width: 27,
//               //     height: 27,
//               //     decoration: BoxDecoration(
//               //       color: const Color(0xFFFA634D),
//               //       borderRadius: BorderRadius.circular(14),
//               //       boxShadow: const [
//               //         BoxShadow(
//               //           color: Color(0x33FF2000),
//               //           spreadRadius: 0,
//               //           offset: Offset(0, 7),
//               //           blurRadius: 15,
//               //         ),
//               //       ],
//               //     ),
//               //   ),
//               // ),

//               //Section to show Wishlist or Favourite button for a particular product.
//               Positioned(
//                 right: 5,
//                 top: 5,
//                 child: IconButton(
//                   onPressed: () {
//                     if (favoriteProviderData.getFavoriteItem.containsKey(
//                       widget.productData.productId,
//                     )) {
//                       // If product is already in favorites, remove it
//                       favoriteProviderData.removeProductFromFavorite(
//                         widget.productData.productId,
//                       );

//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(
//                           margin: const EdgeInsets.all(15),
//                           behavior: SnackBarBehavior.floating,
//                           backgroundColor: Colors.grey,
//                           content: Text(
//                             'Removed ${widget.productData.productName} from Wishlist!',
//                           ),
//                         ),
//                       );
//                     } else {
//                       // If not in favorites, add it
//                       favoriteProviderData.addProductToFavorite(
//                         productId: widget.productData.productId,
//                         productName: widget.productData.productName,
//                         category: widget.productData.category,
//                         description: widget.productData.description,
//                         productImage: widget.productData.productImage,
//                         productSize: widget.productData.productSize,
//                         productPrice: widget.productData.productPrice,
//                         discount: widget.productData.discount,
//                         quantity: widget.productData.quantity,
//                         rating: widget.productData.rating,
//                         totalReviews: widget.productData.totalReviews,
//                         isPopular: widget.productData.isPopular,
//                         isRecommended: widget.productData.isRecommended,
//                         isSoldOut: widget.productData.isSoldOut,
//                         vendorId: widget.productData.vendorId,
//                         vendorName: widget.productData.vendorName,
//                       );

//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(
//                           margin: const EdgeInsets.all(15),
//                           behavior: SnackBarBehavior.floating,
//                           backgroundColor: Colors.grey,
//                           content: Text(
//                             'Added ${widget.productData.productName} to Wishlist!',
//                           ),
//                         ),
//                       );
//                     }
//                   },

//                   icon:
//                       favoriteProviderData.getFavoriteItem.containsKey(
//                             widget.productData.productId,
//                           )
//                           ? const Icon(
//                             Icons.favorite,
//                             color: Colors.red,
//                           ) // If in favorites, show filled heart
//                           : const Icon(
//                             Icons.favorite_border,
//                             color: Colors.red,
//                           ), // If not, show empty heart
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


// This page will create the product design which will appear in tiles in Home Screen.

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reto_radiance/models/product_model.dart';
import 'package:reto_radiance/provider/cart_provider.dart';
import 'package:reto_radiance/provider/favorite_provider.dart';
import 'package:reto_radiance/views/screens/inner_screens/product_detail_screen.dart';

class ProductItemWidget extends ConsumerStatefulWidget {
  final ProductModel productData;

  const ProductItemWidget({super.key, required this.productData});

  @override
  _ProductItemWidgetState createState() => _ProductItemWidgetState();
}

class _ProductItemWidgetState extends ConsumerState<ProductItemWidget> {
  @override
  Widget build(BuildContext context) {
    final cartProviderData = ref.read(cartProvider.notifier);
    final favoriteProviderData = ref.read(favoriteProvider.notifier);

    ref.watch(favoriteProvider);

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return ProductDetailScreen(
                productData: widget.productData,
              );
            },
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(12.0), // Increased padding for better spacing
        child: Container(
          width: 160, // Increased width
          height: 270, // Increased height
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 254, 245, 245),
            borderRadius: BorderRadius.circular(8), // Slightly rounded corners
            boxShadow: const [
              BoxShadow(
                color: Color(0x0f040828),
                spreadRadius: 0,
                offset: Offset(0, 10),
                blurRadius: 20,
              ),
            ],
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // Product Image
              Positioned(
                left: 16,
                top: 10,
                child: Container(
                  width: 128,
                  height: 128,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(width: 1, color: Colors.grey.shade300),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: widget.productData.productImage[0],
                    width: 128,
                    height: 128,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              // Product Name
              Positioned(
                left: 10,
                top: 150,
                child: Text(
                  widget.productData.productName,
                  style: GoogleFonts.lato(
                    color: const Color(0xFF1E3354),
                    fontSize: 16, // Increased font size
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
              ),

              // Product Category
              Positioned(
                left: 10,
                top: 180,
                child: Text(
                  widget.productData.category,
                  style: GoogleFonts.lato(
                    color: const Color(0xFF7F8E9D),
                    fontSize: 14, // Increased font size
                    letterSpacing: 0.3,
                  ),
                ),
              ),

              // Discounted Price
              Positioned(
                left: 10,
                top: 210,
                child: Text(
                  '₹${widget.productData.discount}',
                  style: GoogleFonts.lato(
                    color: const Color(0xFF1E3354),
                    fontSize: 20, // Increased font size
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                  ),
                ),
              ),

              // Original Price
              Positioned(
                left: 90,
                top: 215,
                child: Text(
                  '₹${widget.productData.productPrice}',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    letterSpacing: 0.3,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
              ),

              // Sold Count
              Positioned(
                left: 100,
                top: 160,
                child: Text(
                  widget.productData.totalReviews == 0
                      ? ''
                      : 'SOLD: ${widget.productData.totalReviews}',
                  style: GoogleFonts.lato(
                    color: const Color(0xFF7F8E9D),
                    fontSize: 12,
                  ),
                ),
              ),

              // Rating
              Positioned(
                left: 20,
                top: 160,
                child: Row(
                  children: [
                    if (widget.productData.rating != 0)
                      const Icon(Icons.star, color: Colors.amber, size: 14),
                    if (widget.productData.rating != 0)
                      const SizedBox(width: 4),
                    Text(
                      widget.productData.rating == 0
                          ? ''
                          : widget.productData.rating.toString(),
                      style: GoogleFonts.lato(
                        color: const Color(0xFF7F8E9D),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),

              // Wishlist Button
              Positioned(
                right: 10,
                top: 10,
                child: IconButton(
                  onPressed: () {
                    if (favoriteProviderData.getFavoriteItem.containsKey(
                      widget.productData.productId,
                    )) {
                      favoriteProviderData.removeProductFromFavorite(
                        widget.productData.productId,
                      );

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          margin: const EdgeInsets.all(15),
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.grey,
                          content: Text(
                            'Removed ${widget.productData.productName} from Wishlist!',
                          ),
                        ),
                      );
                    } else {
                      favoriteProviderData.addProductToFavorite(
                        productId: widget.productData.productId,
                        productName: widget.productData.productName,
                        category: widget.productData.category,
                        description: widget.productData.description,
                        productImage: widget.productData.productImage,
                        productSize: widget.productData.productSize,
                        productPrice: widget.productData.productPrice,
                        discount: widget.productData.discount,
                        quantity: widget.productData.quantity,
                        rating: widget.productData.rating,
                        totalReviews: widget.productData.totalReviews,
                        isPopular: widget.productData.isPopular,
                        isRecommended: widget.productData.isRecommended,
                        isSoldOut: widget.productData.isSoldOut,
                        vendorId: widget.productData.vendorId,
                        vendorName: widget.productData.vendorName,
                      );

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          margin: const EdgeInsets.all(15),
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.grey,
                          content: Text(
                            'Added ${widget.productData.productName} to Wishlist!',
                          ),
                        ),
                      );
                    }
                  },
                  icon: favoriteProviderData.getFavoriteItem.containsKey(
                    widget.productData.productId,
                  )
                      ? const Icon(Icons.favorite, color: Colors.red)
                      : const Icon(Icons.favorite_border, color: Colors.red),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}