import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reto_radiance/provider/cart_provider.dart';
import 'package:reto_radiance/views/screens/authentication_screens/login_screen.dart';
import 'package:reto_radiance/views/screens/inner_screens/checkout_screen.dart';
import 'package:reto_radiance/views/screens/main_screen.dart';

class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({super.key});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final cartData = ref.watch(
      cartProvider,
    ); //This will watch our data and will do the changes like we are adding product or removing product.

    final _cartProvider = ref.read(cartProvider.notifier);

    final totalAmount = ref.read(cartProvider.notifier).calculateTotalAmount();

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
                          cartData.length
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
                  'My Cart',
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
      // appBar: PreferredSize(
      //   preferredSize: Size.fromHeight(
      //     MediaQuery.of(context).size.height * 0.20,
      //   ), //The App Bar will take 20% of the screen size
      //   child: Container(
      //     width:
      //     MediaQuery.of(context)
      //         .size
      //         .width, //The App Bar will take complete width of the screen size, although it is width of container but it will denote the width of App Bar only.
      //     height: 118, //Height of the container
      //     clipBehavior: Clip.hardEdge,
      //     decoration: const BoxDecoration(
      //       image: DecorationImage(
      //         image: AssetImage('assets/icons/cartb.png'), //Cart Icon
      //         fit:
      //         BoxFit
      //             .cover, //This will actually make our App Bar cover the entire screen width
      //       ),
      //     ),

      //     child: Stack(
      //       children: [
      //         Positioned(
      //           left: 322,
      //           top: 52,
      //           child: Stack(
      //             children: [
      //               Image.asset(
      //                 'assets/icons/not.png', //Chat Icon
      //                 width: 26, //Width of Chat Icon
      //                 height: 26, //Height of Chat Icon
      //               ),

      //               //Badge basically is a Functional Icon showing the total number of items added which will be placed beside our Cart Icon
      //               Positioned(
      //                 top: 0,
      //                 right: 0,
      //                 child: badges.Badge(
      //                   badgeStyle: badges.BadgeStyle(
      //                     badgeColor: Colors.yellow.shade800,
      //                   ),
      //                   badgeContent: Text(
      //                     cartData.length
      //                         .toString(), //Showing the total number of items added in Cart in text
      //                     style: GoogleFonts.lato(
      //                       color: Colors.white,
      //                       fontWeight: FontWeight.bold,
      //                     ),
      //                   ),
      //                 ),
      //               ),
      //             ],
      //           ),
      //         ),

      //         //TITLE OF OUR NAVBAR
      //         Positioned(
      //           left: 61,
      //           top: 51,
      //           child: Text(
      //             'My Cart',
      //             style: GoogleFonts.lato(
      //               fontSize: 18,
      //               color: Colors.white,
      //               fontWeight: FontWeight.w600,
      //             ),
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // ), //End of APP BAR
      body: Container(
        // decoration: BoxDecoration(
        //   gradient: LinearGradient(
        //     colors: [Color(0xFFfffae4), Color(0xFFffb78b)],
        //   ),
        // ),
        child:
            cartData.isEmpty
                ? Center(
                  //If our CART is EMPTY then run this Center Widget
                  child: Column(
                    mainAxisAlignment:
                        MainAxisAlignment
                            .center, //Taking the below Text to the Center of the Screen vertically.
                    children: [
                      Text(
                        'Your Shopping CART is Empty \n You can add Product to Your CART by \n clicking the Button Below!', //'\n' takes us to next line.
                        textAlign:
                            TextAlign
                                .center, //This will align our above text to center horizontally
                        style: GoogleFonts.roboto(
                          fontSize: 17,
                          letterSpacing: 1,
                          // color: Colors.white,
                          fontWeight: FontWeight.w600,
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
                          'Shop Now',
                          style: GoogleFonts.lato(
                            fontSize: 17,
                            letterSpacing: 1,
                            // color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
                //     : ListView.builder( //If the CART is NOT EMPTY then run this ListView Widget
                //     shrinkWrap: true,
                //     physics: const ScrollPhysics(),
                //     itemCount: cartData.length, //Number of items present in our Cart
                //     itemBuilder: (context, index) {
                //
                //       final cartItem = cartData.values.toList()[index];
                //
                //       return Center(child: Text(cartItem.productName,)); //We are displaying the name of the product added in our cart but we can also access and add other datas related to that product as well and create our own design as well.
                //
                //     }
                // ),
                : Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        //If the CART is NOT EMPTY then run this Widget
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            //SECTION TO SHOW NUMBER OF ITEMS IN CART
                            Center(
                              child: Container(
                                margin: EdgeInsets.all(5),
                                width: MediaQuery.of(context).size.width,
                                height: 40,
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(150, 246, 213, 163),
                                  // borderRadius:
                                ),
                                child: Row(
                                  children: [
                                    Spacer(),
                                    Container(
                                      width: 7,
                                      height: 7,
                                      clipBehavior: Clip.hardEdge,
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      'Number of Item(s) in Cart: ${cartData.length}',
                                      style: GoogleFonts.lato(
                                        fontSize: 16,
                                        // letterSpacing: 1,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Spacer(),
                                  ],
                                ),

                                // Stack(
                                //   clipBehavior: Clip.none,
                                //   children: [
                                //     Positioned(
                                //       left: 0,
                                //       top: 0,
                                //       child: Container(
                                //         width: MediaQuery.of(context).size.width,
                                //         height: 49,
                                //         clipBehavior: Clip.hardEdge,
                                //         decoration: BoxDecoration(
                                //           color: Color(0xFFD7DDFF),
                                //         ),
                                //       ),
                                //     ),
                                //     Positioned(
                                //       left: 44,
                                //       top: 19,
                                //       child: Container(
                                //         width: 10,
                                //         height: 10,
                                //         clipBehavior: Clip.hardEdge,
                                //         decoration: BoxDecoration(
                                //           color: Colors.black,
                                //           borderRadius: BorderRadius.circular(5),
                                //         ),
                                //       ),
                                //     ),

                                //     //TEXT TO SHOW NUMBER OF ITEMS IN CART
                                //     Positioned(
                                //       left: 69,
                                //       top: 14,
                                //       child: Text(
                                //         'Number of Item(s) in Cart: ${cartData.length}',
                                //         style: GoogleFonts.lato(
                                //           fontSize: 16,
                                //           // letterSpacing: 1,
                                //           color: Colors.black,
                                //           fontWeight: FontWeight.bold,
                                //         ),
                                //       ),
                                //     ),
                                //   ],
                                // ),
                              ),
                            ),

                            //SECTION WHERE WE WILL SHOW DETAILS OF OUR ADDED ITEM(S)
                            ListView.builder(
                              itemCount: cartData.length,
                              shrinkWrap: true,
                              // physics: const ScrollPhysics(),
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                final cartItem =
                                    cartData.values
                                        .toList()[index]; //Accessing details of every added item in Cart.

                                return Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 4,
                                    horizontal: 12,
                                  ),
                                  child: Card(
                                    color: const Color.fromARGB(
                                      210,
                                      248,
                                      186,
                                      94,
                                    ),
                                    child: SizedBox(
                                      // height: 200,
                                      height: 160,
                                      //Height of the box inside which we will show the details of the item added.
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          //Inside this box we will display image of the Product which is added to Cart.
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              child: SizedBox(
                                                height: 120, //150,
                                                //Height and Width of the box inside which our image will be displayed but as our image will take up the entire box so changing these dimensions will change the height and width of our image as well.
                                                width: 90, //100,
                                                child: Image.network(
                                                  cartItem
                                                      .productImage[0], //As a single product may have multiple images but we want to display only the first image so we are mentioning '[0]'.
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),

                                          Expanded(
                                            flex: 3,
                                            child: Padding(
                                              padding: EdgeInsets.all(10),
                                              child: Column(
                                                // mainAxisAlignment:
                                                //     MainAxisAlignment
                                                //         .spaceEvenly, //To have equal spacing vertically among all our widgets.
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  //Here we will display name of the Product which is added to Cart.
                                                  Text(
                                                    cartItem.productName,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 2,
                                                    style: GoogleFonts.lato(
                                                      fontSize: 18,

                                                      // letterSpacing: 1,
                                                      // color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w900,
                                                    ),
                                                  ),

                                                  //Here we will display category name of the Product which is added to Cart.
                                                  Text(
                                                    cartItem.category,
                                                    style: GoogleFonts.lato(
                                                      fontSize: 14,
                                                      // letterSpacing: 1,
                                                      color:
                                                          Colors
                                                              .blueGrey
                                                              .shade700,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  //Here we will display price of the Product which is added to Cart.(IMPORTANT: Discounted Price will be shown as Customer will pay the Discounted Price Only).
                                                  Text(
                                                    '₹${cartItem.discount.toStringAsFixed(2)}',
                                                    style: GoogleFonts.lato(
                                                      fontSize: 18,
                                                      // letterSpacing: 1,
                                                      // color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w900,
                                                    ),
                                                  ),

                                                  // Row(
                                                  //   children: [
                                                  //     Container(
                                                  //       height: 40,
                                                  //       width: 120,
                                                  //       decoration: BoxDecoration(
                                                  //         color: Color(0xFF102DE1),
                                                  //       ),
                                                  //       child: Row(
                                                  //         children: [
                                                  //           //Icon to Remove Quantity of product
                                                  //           IconButton(
                                                  //             onPressed: () {
                                                  //               _cartProvider
                                                  //                   .decrementItem(
                                                  //                     cartItem
                                                  //                         .productId,
                                                  //                   ); //Decrementing the product quantity by calling the 'decrementItem()' function present in 'cart_provider' page.
                                                  //             },

                                                  //             icon: Icon(
                                                  //               CupertinoIcons
                                                  //                   .minus,
                                                  //               color: Colors.white,
                                                  //             ),
                                                  //           ),

                                                  //           //To show the quantity of a particular product added to Cart
                                                  //           Text(
                                                  //             cartItem.quantity
                                                  //                 .toString(),
                                                  //             style: GoogleFonts.lato(
                                                  //               // fontSize: 16,
                                                  //               // letterSpacing: 1,
                                                  //               color: Colors.white,
                                                  //               // fontWeight: FontWeight.bold,
                                                  //             ),
                                                  //           ),

                                                  //           //Icon to Add Quantity of product
                                                  //           IconButton(
                                                  //             onPressed: () {
                                                  //               _cartProvider
                                                  //                   .incrementItem(
                                                  //                     cartItem
                                                  //                         .productId,
                                                  //                   ); //Incrementing the product quantity by calling the 'incrementItem()' function present in 'cart_provider' page.
                                                  //             },

                                                  //             icon: Icon(
                                                  //               CupertinoIcons.plus,
                                                  //               color: Colors.white,
                                                  //             ),
                                                  //           ),
                                                  //         ],
                                                  //       ),
                                                  //     ),

                                                  //     //Icon to DELETE the Product
                                                  //     IconButton(
                                                  //       onPressed: () {
                                                  //         _cartProvider.removeItem(
                                                  //           cartItem.productId,
                                                  //         ); //Removing the product by calling the 'removeItem()' function present in 'cart_provider' page.
                                                  //       },

                                                  //       icon: Icon(
                                                  //         CupertinoIcons.delete,
                                                  //         color: Colors.red,
                                                  //       ),
                                                  //     ),
                                                  //   ],
                                                  // ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Spacer(),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              IconButton(
                                                onPressed: () {
                                                  _cartProvider.removeItem(
                                                    cartItem.productId,
                                                  ); //Removing the product by calling the 'removeItem()' function present in 'cart_provider' page.
                                                },
                                                icon: Icon(
                                                  CupertinoIcons.delete,
                                                  color: Colors.black87,
                                                ),
                                              ),
                                              Spacer(),
                                              Row(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  //Icon to Remove Quantity of product
                                                  IconButton(
                                                    onPressed: () {
                                                      _cartProvider.decrementItem(
                                                        cartItem.productId,
                                                      ); //Decrementing the product quantity by calling the 'decrementItem()' function present in 'cart_provider' page.
                                                    },

                                                    icon: Icon(
                                                      CupertinoIcons.minus,
                                                      size: 14,
                                                      color: Colors.black87,
                                                    ),
                                                  ),

                                                  //To show the quantity of a particular product added to Cart
                                                  Text(
                                                    cartItem.quantity
                                                        .toString(),
                                                    style: GoogleFonts.lato(
                                                      fontSize: 14,
                                                      // letterSpacing: 1,
                                                      color: Colors.black87,
                                                      // fontWeight: FontWeight.bold,
                                                    ),
                                                  ),

                                                  //Icon to Add Quantity of product
                                                  IconButton(
                                                    onPressed: () {
                                                      _cartProvider.incrementItem(
                                                        cartItem.productId,
                                                      ); //Incrementing the product quantity by calling the 'incrementItem()' function present in 'cart_provider' page.
                                                    },

                                                    icon: Icon(
                                                      CupertinoIcons.plus,
                                                      size: 14,
                                                      color: Colors.black87,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(25, 248, 186, 94),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(10),
                        ),
                      ),
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 8),
                            height: 3,
                            width: 20,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.horizontal(
                                left: Radius.circular(10),
                                right: Radius.circular(10),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Spacer(),
                              Text(
                                "Total Price: ",
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              Spacer(flex: 2),
                              Text(
                                '₹${totalAmount.toStringAsFixed(2)}',
                                style: TextStyle(
                                  fontSize: 18,
                                  // letterSpacing: 1,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              Spacer(),
                            ],
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              final user = FirebaseAuth.instance.currentUser;
                              if (user != null) {
                                // User is logged in, navigate to CheckoutScreen
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return CheckoutScreen(
                                        totalPrice: totalAmount,
                                      );
                                    },
                                  ),
                                );
                              } else {
                                // User is not logged in, navigate to LoginScreen
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginScreen(),
                                  ),
                                );
                              }
                            },
                            style: ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll(
                                totalAmount == 0.0
                                    ? Colors.grey
                                    : Color.fromARGB(210, 248, 186, 94),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Spacer(),
                                Text(
                                  'CheckOut',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16,
                                    // letterSpacing: 1,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                Spacer(),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
      ),

      //CHECKOUT BUTTON SECTION
      // bottomNavigationBar: Container(
      //   width: 416,
      //   height: 89,
      //   clipBehavior: Clip.hardEdge,
      //   decoration:
      //       const BoxDecoration(), //Whenever we are using Container Widget always write BoxDecoration even when we are not using it else it will ask us to use SizedBox and may affect the performance of the App.
      //   child: Stack(
      //     clipBehavior: Clip.none,
      //     children: [
      //       Align(
      //         alignment: Alignment.center,
      //         child: Container(
      //           width: 416,
      //           height: 89,
      //           clipBehavior: Clip.hardEdge,
      //           decoration: BoxDecoration(
      //             color: Colors.white,
      //             border: Border.all(color: Color(0xFFC4C4C4)),
      //           ),
      //         ),
      //       ),

      //       Align(
      //         alignment: Alignment(-0.92, -0.26),

      //         child: Text(
      //           'Sub Total :',
      //           style: GoogleFonts.roboto(
      //             fontSize: 16,
      //             // letterSpacing: 1,
      //             color: const Color(0xFFA1A1A1),
      //             fontWeight: FontWeight.bold,
      //           ),
      //         ),
      //       ),

      //       //Displaying the Total Amount the Customer has to Pay
      //       Align(
      //         alignment: const Alignment(-0.33, -0.35), //Position Format: (x,y)

      //         child: Text(
      //           '\₹${totalAmount.toStringAsFixed(2)}',
      //           style: GoogleFonts.roboto(
      //             fontSize: 24,
      //             // letterSpacing: 1,
      //             color: const Color(0xFFFF6464),
      //             fontWeight: FontWeight.w500,
      //           ),
      //         ),
      //       ),

      //       //CheckOut Button
      //       Align(
      //         alignment: const Alignment(0.83, -1), //Position Format: (x,y)

      //         child: InkWell(
      //           onTap: () {
      //             Navigator.push(
      //               context,
      //               MaterialPageRoute(
      //                 builder: (context) {
      //                   return checkoutScreen();
      //                 },
      //               ),
      //             );
      //           },

      //           child: Container(
      //             width: 166,
      //             height: 71,
      //             clipBehavior: Clip.hardEdge,
      //             decoration: BoxDecoration(
      //               //Color of our Checkout Button
      //               color:
      //                   totalAmount == 0.0
      //                       ? Colors.grey
      //                       : Colors
      //                           .green, //If our Total Amount is 0 that means no product is added and our Button Color will be grey and if our Total Amount is not zero it means there is some product in our Cart and our Button Color will change to green.
      //             ),

      //             child: Center(
      //               child: Row(
      //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                 children: [
      //                   Text(
      //                     'CheckOut',
      //                     style: GoogleFonts.roboto(
      //                       fontSize: 16,
      //                       // letterSpacing: 1,
      //                       color: Colors.white,
      //                       fontWeight: FontWeight.w500,
      //                     ),
      //                   ),

      //                   Icon(Icons.arrow_forward_ios, color: Colors.white),
      //                 ],
      //               ),
      //             ),
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
      // ), //END OF CHECKOUT BUTTON SECTION
    );
  }
}
