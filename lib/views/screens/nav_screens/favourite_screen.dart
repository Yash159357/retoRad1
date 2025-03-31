// //This page is almost similar to our 'cart_screen' page

import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reto_radiance/models/product_model.dart';
import 'package:reto_radiance/provider/cart_provider.dart';
import 'package:reto_radiance/provider/favorite_provider.dart';
import 'package:reto_radiance/views/screens/inner_screens/product_detail_screen.dart';

import '../main_screen.dart';

class FavouriteScreen extends ConsumerWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteData = ref.read(favoriteProvider.notifier);

    final wishItemData = ref.watch(favoriteProvider);

    return Scaffold(
      //Start of APP BAR
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          MediaQuery.of(context).size.height * 0.20,
        ), //The App Bar will take 20% of the screen size
        child: Container(
          width:
              MediaQuery.of(context)
                  .size
                  .width, //The App Bar will take complete width of the screen size, although it is width of container but it will denote the width of App Bar only.
          height: 100, //Height of the container
          clipBehavior: Clip.hardEdge,
          decoration: const BoxDecoration(
            color: const Color(0xFFC080E8),
            // image: DecorationImage(
            //   image: AssetImage('assets/icons/cartb.png',), //Cart Icon
            //   fit: BoxFit.cover, //This will actually make our App Bar cover the entire screen width
            // ),
          ),

          child: Stack(
            children: [
              Positioned(
                left: 302,
                top: 52,
                child: Stack(
                  children: [
                    Image.asset(
                      'assets/icons/not.png', //Chat Icon
                      width: 36, //Width of Chat Icon
                      height: 36, //Height of Chat Icon
                    ),

                    //Badge basically is a Functional Icon showing the total number of items added which will be placed beside our Cart Icon
                    Positioned(
                      top: 2,
                      right: 8,
                      child: badges.Badge(
                        badgeStyle: badges.BadgeStyle(
                          badgeColor: const Color.fromARGB(255, 255, 255, 255),
                        ),
                        badgeContent: Text(
                          wishItemData.length
                              .toString(), //Showing the total number of items added in Cart in text
                          style: GoogleFonts.lato(
                            color: const Color.fromARGB(255, 0, 0, 0),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              //TITLE OF OUR NAVBAR
              Positioned(
                left: 61,
                top: 51,
                child: Text(
                  'My Wishlist',
                  style: GoogleFonts.lato(
                    fontSize: 25,
                    color: const Color.fromARGB(255, 0, 0, 0),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ), //End of APP BAR

      body:
          wishItemData.isEmpty
              ? Center(
                //If our CART is EMPTY then run this Center Widget
                child: Column(
                  mainAxisAlignment:
                      MainAxisAlignment
                          .center, //Taking the below Text to the Center of the Screen vertically.
                  children: [
                    Text(
                      'Your WISHLIST is Empty \n You can add Product to Your WISHLIST by \n clicking the Button Below!', //'\n' takes us to next line.
                      textAlign:
                          TextAlign
                              .center, //This will align our above text to center horizontally
                      style: GoogleFonts.roboto(
                        fontSize: 17,
                        letterSpacing: 1,
                        // color: Colors.white,
                        // fontWeight: FontWeight.w600,
                      ),
                    ),

                    TextButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              //Navigating the user to Home Screen if he/she press this button
                              return MainScreen(index: 1);
                            },
                          ),
                          (route) => false,
                        );
                      },

                      child: Text(
                        'Add Now',
                        style: GoogleFonts.lato(
                          fontSize: 17,
                          letterSpacing: 1,
                          // color: Colors.white,
                          // fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              )
              : ListView.builder(
                itemCount: wishItemData.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final wishData = wishItemData.values.toList()[index];

                  return Padding(
                    padding: const EdgeInsets.all(8),
                    child: Container(
                      width: 275,
                      height: 96,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 247, 212, 188),
                        border: Border.all(color: const Color(0xFFEFF0F2)),
                        borderRadius: BorderRadius.circular(9),
                      ),
                      child: Row(
                        children: [
                          // Product Image Section
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 14,
                              top: 9,
                              bottom: 9,
                            ),
                            child: Container(
                              width: 78,
                              height: 78,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 251, 240, 240),
                                borderRadius: BorderRadius.circular(9),
                              ),
                              child: Center(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    wishData.productImage[0],
                                    fit: BoxFit.cover,
                                    width: 70,
                                    height: 70,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          // Product Info Section
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 14,
                                horizontal: 8,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    wishData.productName,
                                    style: GoogleFonts.lato(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                  Text(
                                    '₹${wishData.discount.toStringAsFixed(2)}',
                                    style: GoogleFonts.lato(
                                      fontWeight: FontWeight.w600,
                                      height: 1.4,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          // Action Buttons Section
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                IconButton(
                                  icon: const Icon(
                                    Icons.remove_red_eye,
                                    size: 28,
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (context) => ProductDetailScreen(
                                              productData: ProductModel(
                                                productId: wishData.productId,
                                                productName:
                                                    wishData.productName,
                                                category: wishData.category,
                                                description:
                                                    wishData.description,
                                                productImage:
                                                    wishData.productImage,
                                                productSize:
                                                    wishData.productSize,
                                                productPrice:
                                                    wishData.productPrice,
                                                discount: wishData.discount,
                                                quantity: wishData.quantity,
                                                rating: wishData.rating,
                                                totalReviews:
                                                    wishData.totalReviews,
                                                isPopular: wishData.isPopular,
                                                isRecommended:
                                                    wishData.isRecommended,
                                                isSoldOut: wishData.isSoldOut,
                                                vendorId: wishData.vendorId,
                                                vendorName: wishData.vendorName,
                                              ),
                                            ),
                                      ),
                                    );
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.shopping_cart,
                                    size: 28,
                                  ),
                                  onPressed: () {
                                    // Add to cart functionality
                                    ref.read(cartProvider.notifier).addProductToCart(
                                      //Accessing and passing out real time product details to addProductToCart function present in 'cart_provider' page and will add the product accordingly as per our logic mentioned there in if else block there within this function.
                                      product: ProductModel(
                                        productId: wishData.productId,
                                        productName: wishData.productName,
                                        category: wishData.category,
                                        description: wishData.description,
                                        productImage: wishData.productImage,
                                        productSize: wishData.productSize,
                                        productPrice: wishData.productPrice,
                                        discount: wishData.discount,
                                        quantity: wishData.quantity,
                                        rating: wishData.rating,
                                        totalReviews: wishData.totalReviews,
                                        isPopular: wishData.isPopular,
                                        isRecommended: wishData.isRecommended,
                                        isSoldOut: wishData.isSoldOut,
                                        vendorId: wishData.vendorId,
                                        vendorName: wishData.vendorName,
                                      ),
                                      context: context,
                                    );
                                  },
                                ),
                                IconButton(
                                  icon: Image.asset(
                                    'assets/icons/delete2.png',
                                    width: 28,
                                    height: 28,
                                  ),
                                  onPressed: () {
                                    favoriteData.removeItem(wishData.productId);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      //
      //
      //: ListView.builder(
      //     itemCount: wishItemData.length,
      //     shrinkWrap: true,
      //     itemBuilder: (context, index) {
      //       final wishData = wishItemData.values.toList()[index];

      //       return Padding(
      //         padding: EdgeInsets.all(8),
      //         child: Center(
      //           child: Container(
      //             width: 335,
      //             height: 96,
      //             clipBehavior: Clip.antiAlias,
      //             decoration: BoxDecoration(),
      //             child: SizedBox(
      //               width:
      //               double
      //                   .infinity, //Other than MediaQuery it is another way to taking the entire screen width.
      //               child: Stack(
      //                 clipBehavior: Clip.none,
      //                 children: [
      //                   Positioned(
      //                     left: 0,
      //                     top: 0,
      //                     child: Container(
      //                       width: 336,
      //                       height: 97,
      //                       clipBehavior: Clip.antiAlias,
      //                       decoration: BoxDecoration(
      //                         color: const Color.fromARGB(
      //                           255,
      //                           247,
      //                           212,
      //                           188,
      //                         ),
      //                         border: Border.all(
      //                           color: Color(0xFFEFF0F2),
      //                         ),
      //                         borderRadius: BorderRadius.circular(9),
      //                       ),
      //                     ),
      //                   ),

      //                   Positioned(
      //                     left: 14,
      //                     top: 9,
      //                     child: Container(
      //                       width: 78,
      //                       height: 78,
      //                       clipBehavior: Clip.antiAlias,
      //                       decoration: BoxDecoration(
      //                         color: Color.fromARGB(255, 251, 240, 240),
      //                         borderRadius: BorderRadius.circular(9),
      //                       ),
      //                     ),
      //                   ),

      //                   //Displaying Product Price which is the Discounted Price
      //                   Positioned(
      //                     left: 260,
      //                     top: 16,
      //                     child: Text(
      //                       '₹${wishData.productPrice.toStringAsFixed(2)}', //IMPORTANT: Showing the discounted price as we passed discounted price in product price from 'product_detail_screen' when we were doing Favorite Button on pressed function and we are doing because discounted price is the price of the product that the user will pay and the same thing is done in Cart and Product Detail page as well.
      //                       style: GoogleFonts.lato(
      //                         // fontSize: 16,
      //                         // letterSpacing: 1,
      //                         color: Colors.black,
      //                         fontWeight: FontWeight.w600,
      //                         height: 1.4, //Height of the text
      //                       ),
      //                     ),
      //                   ),

      //                   //Displaying Product Name
      //                   Positioned(
      //                     left: 101,
      //                     top: 14,
      //                     child: SizedBox(
      //                       width: 162,
      //                       child: Text(
      //                         wishData.productName,
      //                         style: GoogleFonts.lato(
      //                           fontSize: 16,
      //                           // letterSpacing: 1,
      //                           color: Colors.black,
      //                           fontWeight: FontWeight.bold,
      //                           // height: 1.4, //Height of the text
      //                         ),
      //                       ),
      //                     ),
      //                   ),

      //                   //Displaying Product Image
      //                   Positioned(
      //                     left: 23,
      //                     top: 14,
      //                     child: Image.network(
      //                       wishData.imageUrl[0],
      //                       width: 58,
      //                       height: 67,
      //                       fit: BoxFit.cover,
      //                     ),
      //                   ),

      //                   //Delete Icon
      //                   Positioned(
      //                     left: 284,
      //                     top: 47,
      //                     child: InkWell(
      //                       onTap: () {
      //                         favoriteData.removeItem(
      //                           wishData.productId,
      //                         ); //We are using 'removeItem()' function defined in 'favorite_provider' page.
      //                       }, //SUGGESTION: We have one more function name 'removeAllItem()' defined in 'favorite_provider' page where it empties the entire Wishlist section, you can also add one button in App Bar and add this functionality of clearing entire wishlist as well if you want.

      //                       child: Image.asset(
      //                         'assets/icons/delete2.png',
      //                         width: 28,
      //                         height: 28,
      //                         fit: BoxFit.cover,
      //                       ),
      //                     ),
      //                   ),

      //                   Positioned(
      //                     left: 224,
      //                     top: 47,
      //                     child: InkWell(
      //                       onTap: () {
      //                         //When we click on this button our product will get added to cart
      //                       }, //SUGGESTION: We have one more function name 'removeAllItem()' defined in 'favorite_provider' page where it empties the entire Wishlist section, you can also add one button in App Bar and add this functionality of clearing entire wishlist as well if you want.

      //                       child: Icon(Icons.shopping_cart),
      //                     ),
      //                   ),
      //                 ],
      //               ),
      //             ),
      //           ),
      //         ),
      //       );
      //     },
      //   ),
    );
  }
}
