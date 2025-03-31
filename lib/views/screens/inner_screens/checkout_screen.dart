//
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:reto_radiance/provider/cart_provider.dart';
// import 'package:reto_radiance/views/screens/inner_screens/payement_screen.dart';
// import 'package:reto_radiance/views/screens/inner_screens/shipping_address_screen.dart';
// import 'package:reto_radiance/views/screens/main_screen.dart';
// import 'package:uuid/uuid.dart';
//
// class CheckoutScreen extends ConsumerStatefulWidget {
//   const CheckoutScreen({super.key, required this.totalPrice});
//   final double totalPrice;
//
//   @override
//   _CheckoutScreenState createState() => _CheckoutScreenState();
// }
//
// class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
//   String _selectedPaymentMethod = 'stripe';
//   final TextEditingController _couponController = TextEditingController();
//   var _isApplied = false;
//   double discount = 0;
//
//   // Define your coupon codes and discounts
//   final Map<String, double> couponCodes = {
//     'RETO10': 0.10,
//     'SUMMER25': 0.25,
//     'WELCOME15': 0.15,
//   };
//
//   bool isLoading = false;
//
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//
//   String state = '';
//   String city = '';
//   String locality = '';
//   String pinCode = '';
//
//   @override
//   void initState() {
//     super.initState();
//     getUserData();
//   }
//
//   void getUserData() {
//     Stream<DocumentSnapshot> userDataStream =
//     _firestore
//         .collection('customers')
//         .doc(_auth.currentUser!.uid)
//         .snapshots();
//
//     userDataStream.listen((DocumentSnapshot userData) {
//       if (userData.exists) {
//         setState(() {
//           state = userData.get('state');
//           city = userData.get('city');
//           locality = userData.get('locality');
//           pinCode = userData.get('pinCode');
//         });
//       }
//     });
//   }
//
//   // Controller for the coupon text field
//
//   Widget buildCouponRow() {
//     final couponColor = Color.fromARGB(210, 248, 186, 94);
//
//     final InputDecoration couponDecoration = InputDecoration(
//       contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(8),
//         borderSide: BorderSide(color: couponColor, width: 1.5),
//       ),
//       enabledBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(8),
//         borderSide: BorderSide(color: couponColor, width: 1.5),
//       ),
//       focusedBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(8),
//         borderSide: BorderSide(color: couponColor, width: 2.0),
//       ),
//       hintText: 'Enter coupon code',
//       hintStyle: TextStyle(color: Colors.grey[600]),
//     );
//
//     final ButtonStyle elevatedButtonStyle = ElevatedButton.styleFrom(
//       backgroundColor: couponColor,
//       foregroundColor: Colors.white,
//       elevation: 2,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//       padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
//     );
//
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         SizedBox(
//           width: 150,
//           child: TextField(
//             controller: _couponController,
//             decoration: couponDecoration,
//             style: TextStyle(fontSize: 14),
//           ),
//         ),
//         SizedBox(width: 8),
//         ElevatedButton(
//           style: elevatedButtonStyle,
//           onPressed: () {
//             final code = _couponController.text.trim();
//             if (couponCodes.containsKey(code)) {
//               // Apply discount logic here
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(
//                   content: Text('${couponCodes[code]}% discount applied!'),
//                   duration: Duration(milliseconds: 750),
//                 ),
//               );
//               setState(() {
//                 discount = couponCodes[code]!;
//                 _isApplied = true;
//               });
//             } else {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(
//                   content: Text('Invalid coupon code'),
//                   duration: Duration(milliseconds: 750),
//                 ),
//               );
//               setState(() {
//                 discount = 0;
//                 _isApplied = false;
//               });
//             }
//           },
//           child: Text(
//             'Apply',
//             style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
//           ),
//         ),
//       ],
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final cartProviderData = ref.read(cartProvider);
//
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         surfaceTintColor: Colors.transparent,
//         title: const Text(
//           'CheckOut',
//           style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
//         ),
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: const Icon(Icons.arrow_back, size: 28, weight: 1000),
//         ),
//       ),
//       backgroundColor: const Color.fromARGB(255, 250, 225, 188),
//       body: SingleChildScrollView(
//         physics: BouncingScrollPhysics(),
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
//           child: Center(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 // Shipping Address Section
//                 InkWell(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => const ShippingAddressScreen(),
//                       ),
//                     );
//                   },
//                   child: SizedBox(
//                     width: 335,
//                     height: 74,
//                     child: Stack(
//                       clipBehavior: Clip.none,
//                       children: [
//                         Positioned(
//                           top: 0,
//                           left: 0,
//                           child: Container(
//                             width: 335,
//                             height: 74,
//                             clipBehavior: Clip.hardEdge,
//                             decoration: BoxDecoration(
//                               color: const Color.fromARGB(255, 255, 246, 233),
//                               border: Border.all(
//                                 color: const Color(0xFFEFF0F2),
//                               ),
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                           ),
//                         ),
//                         Positioned(
//                           left: 70,
//                           top: 17,
//                           child: SizedBox(
//                             width: 215,
//                             height: 41,
//                             child: Stack(
//                               clipBehavior: Clip.none,
//                               children: [
//                                 Positioned(
//                                   left: -1,
//                                   top: -1,
//                                   child: SizedBox(
//                                     width: 219,
//                                     child: Column(
//                                       mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                       mainAxisSize: MainAxisSize.min,
//                                       children: [
//                                         Align(
//                                           alignment: Alignment.centerLeft,
//                                           child: Text(
//                                             (state == "")
//                                                 ? 'Add Address'
//                                                 : 'Update Address',
//                                             style: TextStyle(
//                                               fontSize: 14,
//                                               color: Colors.black,
//                                               fontWeight: FontWeight.w600,
//                                               height: 1.4,
//                                             ),
//                                           ),
//                                         ),
//                                         const SizedBox(height: 5),
//                                         Align(
//                                           alignment: Alignment.centerLeft,
//                                           child: Text(
//                                             'Enter City',
//                                             style: TextStyle(
//                                               fontSize: 12,
//                                               color: const Color(0xFF7F808C),
//                                               fontWeight: FontWeight.w600,
//                                               height: 1.4,
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         Positioned(
//                           left: 16,
//                           top: 16,
//                           child: SizedBox.square(
//                             dimension: 42,
//                             child: Stack(
//                               clipBehavior: Clip.none,
//                               children: [
//                                 Positioned(
//                                   left: 0,
//                                   top: 0,
//                                   child: Container(
//                                     width: 43,
//                                     height: 43,
//                                     clipBehavior: Clip.hardEdge,
//                                     decoration: BoxDecoration(
//                                       color: const Color(0xFFFBF7F5),
//                                       borderRadius: BorderRadius.circular(100),
//                                     ),
//                                     child: Stack(
//                                       clipBehavior: Clip.hardEdge,
//                                       children: [
//                                         Positioned(
//                                           left: 11,
//                                           top: 11,
//                                           child: Image.asset(
//                                             'assets/icons/location.png',
//                                             width: 20,
//                                             height: 20,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         Positioned(
//                           left: 305,
//                           top: 25,
//                           child: Image.asset(
//                             'assets/icons/edit2.png',
//                             width: 20,
//                             height: 20,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 15),
//                 const Text(
//                   'Your Item(s)',
//                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
//                 ),
//                 const SizedBox(height: 15),
//                 // Items List Section
//                 Container(
//                   decoration: BoxDecoration(
//                     border: Border.all(color: Colors.grey.withAlpha(150)),
//                     borderRadius: BorderRadius.circular(20),
//                     color: const Color.fromARGB(255, 255, 246, 233),
//                   ),
//                   padding: const EdgeInsets.all(8),
//                   height: MediaQuery.of(context).size.height * 0.36,
//                   child: ListView.separated(
//                     shrinkWrap: true,
//                     physics: const ScrollPhysics(),
//                     itemBuilder: (context, index) {
//                       final cartItem = cartProviderData.values.toList()[index];
//                       return InkWell(
//                         onTap: () {},
//                         child: Container(
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               ClipRRect(
//                                 borderRadius: BorderRadius.circular(8),
//                                 child: Container(
//                                   width: 70,
//                                   height: 70,
//                                   clipBehavior: Clip.hardEdge,
//                                   decoration: const BoxDecoration(
//                                     color: Color(0xFFBCC5FF),
//                                   ),
//                                   child: Image.network(
//                                     cartItem.imageUrl[0],
//                                     fit: BoxFit.cover,
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(width: 6),
//                               Column(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 mainAxisSize: MainAxisSize.min,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   const SizedBox(height: 10),
//                                   Text(
//                                     cartItem.productName,
//                                     style: const TextStyle(
//                                       color: Colors.black87,
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.w600,
//                                     ),
//                                   ),
//                                   Text(
//                                     cartItem.categoryName,
//                                     style: const TextStyle(
//                                       color: Colors.black54,
//                                       fontSize: 12,
//                                       fontWeight: FontWeight.w600,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               const Spacer(),
//                               Column(
//                                 children: [
//                                   const SizedBox(height: 10),
//                                   Text(
//                                     "₹${(cartItem.discount * cartItem.quantity).toStringAsFixed(2)}",
//                                     style: const TextStyle(
//                                       color: Colors.black87,
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.w600,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                     separatorBuilder: (context, index) {
//                       return Divider(
//                         color: Colors.grey.shade300,
//                         indent: 5,
//                         endIndent: 5,
//                       );
//                     },
//                     itemCount: cartProviderData.length,
//                   ),
//                 ),
//                 const SizedBox(height: 14),
//                 buildCouponRow(),
//                 SizedBox(height: 10),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     Text(
//                       "Total Price: ",
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     Row(
//                       children: [
//                         Text(
//                           "₹${widget.totalPrice.toStringAsFixed(2)}",
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight:
//                             (_isApplied
//                                 ? FontWeight.normal
//                                 : FontWeight.bold),
//                             decoration:
//                             (_isApplied
//                                 ? TextDecoration.lineThrough
//                                 : TextDecoration.none),
//                           ),
//                         ),
//                         if (_isApplied)
//                           Text(
//                             "₹${(widget.totalPrice * (1.0 - discount)).toStringAsFixed(2)}",
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                       ],
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 4),
//                 // Payment Options Section
//                 Divider(color: Colors.black12),
//                 const SizedBox(height: 8),
//
//                 const Text(
//                   'Choose Payment Method',
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(height: 4),
//                 RadioListTile<String>(
//                   title: const Text('Cash on Delivery'),
//                   value: 'cashOnDelivery',
//                   groupValue: _selectedPaymentMethod,
//                   onChanged: (String? value) {
//                     setState(() {
//                       _selectedPaymentMethod = value!;
//                     });
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//       // Place Order Button Section
//       bottomSheet:
//       state == ""
//           ? Padding(
//         padding: const EdgeInsets.all(25.0),
//         child: TextButton(
//           onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => const ShippingAddressScreen(),
//               ),
//             );
//           },
//           child: const Text('Add Address'),
//         ),
//       )
//           : Padding(
//         padding: const EdgeInsets.all(25.0),
//         child: InkWell(
//           onTap: () async {
//             if (_selectedPaymentMethod == 'stripe') {
//               // Pay With Stripe
//               // Navigator.push(
//               //   context,
//               //   MaterialPageRoute(
//               //     builder: (context) {
//               //       // return RazorPayPage(
//               //       //   amount: widget.totalPrice * (1 - discount),
//               //       //   discount: discount,
//               //       // );
//               //     },
//               //   ),
//               // );
//             } else {
//               final bool? confirm = await showDialog<bool>(
//                 context: context,
//                 barrierDismissible: false,
//                 builder:
//                     (BuildContext context) => AlertDialog(
//                   title: const Text("Confirm Order"),
//                   content: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Text(
//                         "You are choosing Cash on Delivery method.",
//                       ),
//                       const SizedBox(height: 10),
//                       RichText(
//                         text: const TextSpan(
//                           style: TextStyle(
//                             color: Colors.black,
//                             fontSize: 12,
//                           ),
//                           children: [
//                             TextSpan(
//                               text:
//                               "By confirming, you agree that ",
//                             ),
//                             TextSpan(
//                               text: "fraudulent or fake orders ",
//                               style: TextStyle(color: Colors.red),
//                             ),
//                             TextSpan(
//                               text:
//                               "may lead to legal proceedings under Section 420 of IPC ",
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                   actions: [
//                     TextButton(
//                       onPressed:
//                           () => Navigator.pop(context, false),
//                       child: const Text("CANCEL"),
//                     ),
//                     ElevatedButton(
//                       onPressed: () => Navigator.pop(context, true),
//                       child: const Text("CONFIRM"),
//                     ),
//                   ],
//                 ),
//               );
//
//               if (confirm != true) return;
//
//               setState(() {
//                 isLoading = true;
//               });
//
//               final cartItems =
//               ref
//                   .read(cartProvider.notifier)
//                   .getCartItem
//                   .values
//                   .toList();
//               final userDoc =
//               await _firestore
//                   .collection('customers')
//                   .doc(_auth.currentUser!.uid)
//                   .get();
//
//               final CollectionReference orderRefer = _firestore
//                   .collection('orders');
//               final batch = _firestore.batch();
//
//               for (var item in cartItems) {
//                 final orderId = const Uuid().v4();
//                 final orderRef = orderRefer.doc(orderId);
//
//                 batch.set(orderRef, {
//                   'orderId': orderId,
//                   'productName': item.productName,
//                   'productId': item.productId,
//                   'size': item.productSize,
//                   'quantity': item.quantity,
//                   'price':
//                   ((item.quantity * item.discount) *
//                       (1 - discount)),
//                   'category': item.categoryName,
//                   'productImage': item.imageUrl[0],
//                   'name': userDoc.get('name'),
//                   'email': userDoc.get('email'),
//                   'number': userDoc.get('number'),
//                   'customerId': _auth.currentUser!.uid,
//                   'state': userDoc.get('state'),
//                   'city': userDoc.get('city'),
//                   'locality': userDoc.get('locality'),
//                   'pinCode': userDoc.get('pinCode'),
//                   'deliveredCount': 0,
//                   'delivered': false,
//                   'processing': true,
//                   'vendorId': item.vendorId,
//                 });
//               }
//
//               await batch.commit().whenComplete(() {
//                 ref.read(cartProvider.notifier).clearCartData();
//                 Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => const MainScreen(),
//                   ),
//                 );
//
//                 setState(() {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(
//                       backgroundColor: Colors.grey,
//                       content: Text('Order Has Been Placed'),
//                     ),
//                   );
//                   isLoading = false;
//                 });
//               });
//             }
//           },
//           child: Container(
//             height: 50,
//             width: MediaQuery.of(context).size.width - 50,
//             decoration: BoxDecoration(
//               color: const Color.fromARGB(210, 248, 186, 94),
//               borderRadius: BorderRadius.circular(15),
//             ),
//             child: Center(
//               child:
//               isLoading
//                   ? const CircularProgressIndicator(
//                 color: Colors.white,
//               )
//                   : const Text(
//                 'PLACE YOUR ORDER',
//                 style: TextStyle(
//                   fontSize: 17,
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                   height: 1.4,
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reto_radiance/provider/cart_provider.dart';
import 'package:reto_radiance/views/screens/inner_screens/payement_screen.dart';
import 'package:reto_radiance/views/screens/inner_screens/shipping_address_screen.dart';
import 'package:reto_radiance/views/screens/main_screen.dart';
import 'package:uuid/uuid.dart';

class CheckoutScreen extends ConsumerStatefulWidget {
  const CheckoutScreen({super.key, required this.totalPrice});
  final double totalPrice;

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  String _selectedPaymentMethod = 'stripe';
  final TextEditingController _couponController = TextEditingController();
  var _isApplied = false;
  double discount = 0;

  // Define your coupon codes and discounts
  final Map<String, double> couponCodes = {
    'RETO10': 0.10,
    'SUMMER25': 0.25,
    'WELCOME15': 0.15,
  };

  bool isLoading = false;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String state = '';
  String city = '';
  String locality = '';
  String pinCode = '';

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  void getUserData() {
    Stream<DocumentSnapshot> userDataStream =
        _firestore
            .collection('customers')
            .doc(_auth.currentUser!.uid)
            .snapshots();

    userDataStream.listen((DocumentSnapshot userData) {
      if (userData.exists) {
        setState(() {
          state = userData.get('state');
          city = userData.get('city');
          locality = userData.get('locality');
          pinCode = userData.get('pinCode');
        });
      }
    });
  }

  // Controller for the coupon text field

  Widget buildCouponRow() {
    final couponColor = Color.fromARGB(210, 248, 186, 94);

    final InputDecoration couponDecoration = InputDecoration(
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: couponColor, width: 1.5),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: couponColor, width: 1.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: couponColor, width: 2.0),
      ),
      hintText: 'Enter coupon code',
      hintStyle: TextStyle(color: Colors.grey[600]),
    );

    final ButtonStyle elevatedButtonStyle = ElevatedButton.styleFrom(
      backgroundColor: couponColor,
      foregroundColor: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
    );

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 150,
          child: TextField(
            controller: _couponController,
            decoration: couponDecoration,
            style: TextStyle(fontSize: 14),
          ),
        ),
        SizedBox(width: 8),
        ElevatedButton(
          style: elevatedButtonStyle,
          onPressed: () {
            final code = _couponController.text.trim();
            if (couponCodes.containsKey(code)) {
              // Apply discount logic here
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${couponCodes[code]}% discount applied!'),
                  duration: Duration(milliseconds: 750),
                ),
              );
              setState(() {
                discount = couponCodes[code]!;
                _isApplied = true;
              });
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Invalid coupon code'),
                  duration: Duration(milliseconds: 750),
                ),
              );
              setState(() {
                discount = 0;
                _isApplied = false;
              });
            }
          },
          child: Text(
            'Apply',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final cartProviderData = ref.read(cartProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        title: const Text(
          'CheckOut',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, size: 28, weight: 1000),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 250, 225, 188),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Shipping Address Section
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ShippingAddressScreen(),
                      ),
                    );
                  },
                  child: SizedBox(
                    width: 335,
                    height: 74,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Positioned(
                          top: 0,
                          left: 0,
                          child: Container(
                            width: 335,
                            height: 74,
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 255, 246, 233),
                              border: Border.all(
                                color: const Color(0xFFEFF0F2),
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 70,
                          top: 17,
                          child: SizedBox(
                            width: 215,
                            height: 41,
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Positioned(
                                  left: -1,
                                  top: -1,
                                  child: SizedBox(
                                    width: 219,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            (state == "")
                                                ? 'Add Address'
                                                : 'Update Address',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                              height: 1.4,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            'Enter City',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: const Color(0xFF7F808C),
                                              fontWeight: FontWeight.w600,
                                              height: 1.4,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          left: 16,
                          top: 16,
                          child: SizedBox.square(
                            dimension: 42,
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Positioned(
                                  left: 0,
                                  top: 0,
                                  child: Container(
                                    width: 43,
                                    height: 43,
                                    clipBehavior: Clip.hardEdge,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFFBF7F5),
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: Stack(
                                      clipBehavior: Clip.hardEdge,
                                      children: [
                                        Positioned(
                                          left: 11,
                                          top: 11,
                                          child: Image.asset(
                                            'assets/icons/location.png',
                                            width: 20,
                                            height: 20,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          left: 305,
                          top: 25,
                          child: Image.asset(
                            'assets/icons/edit2.png',
                            width: 20,
                            height: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                const Text(
                  'Your Item(s)',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 15),
                // Items List Section
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.withAlpha(150)),
                    borderRadius: BorderRadius.circular(20),
                    color: const Color.fromARGB(255, 255, 246, 233),
                  ),
                  padding: const EdgeInsets.all(8),
                  height: MediaQuery.of(context).size.height * 0.36,
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    itemBuilder: (context, index) {
                      final cartItem = cartProviderData.values.toList()[index];
                      return InkWell(
                        onTap: () {},
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Container(
                                  width: 70,
                                  height: 70,
                                  clipBehavior: Clip.hardEdge,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFBCC5FF),
                                  ),
                                  child: Image.network(
                                    cartItem.productImage[0],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 6),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 10),
                                  Text(
                                    cartItem.productName,
                                    style: const TextStyle(
                                      color: Colors.black87,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    cartItem.category,
                                    style: const TextStyle(
                                      color: Colors.black54,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Column(
                                children: [
                                  const SizedBox(height: 10),
                                  Text(
                                    "₹${(cartItem.discount * cartItem.quantity).toStringAsFixed(2)}",
                                    style: const TextStyle(
                                      color: Colors.black87,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Divider(
                        color: Colors.grey.shade300,
                        indent: 5,
                        endIndent: 5,
                      );
                    },
                    itemCount: cartProviderData.length,
                  ),
                ),
                const SizedBox(height: 14),
                buildCouponRow(),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Total Price: ",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "₹${widget.totalPrice.toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight:
                                (_isApplied
                                    ? FontWeight.normal
                                    : FontWeight.bold),
                            decoration:
                                (_isApplied
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none),
                          ),
                        ),
                        SizedBox(width: 10),
                        if (_isApplied)
                          Text(
                            "₹${(widget.totalPrice * (1.0 - discount)).toStringAsFixed(2)}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                // Payment Options Section
                Divider(color: Colors.black12),
                const SizedBox(height: 8),

                const Text(
                  'Choose Payment Method',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                RadioListTile<String>(
                  title: const Text('Cash on Delivery'),
                  value: 'cashOnDelivery',
                  groupValue: _selectedPaymentMethod,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedPaymentMethod = value!;
                    });
                  },
                ),

                SizedBox(height: 200),
              ],
            ),
          ),
        ),
      ),
      // Place Order Button Section
      bottomSheet:
          state == ""
              ? Padding(
                padding: const EdgeInsets.all(25.0),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ShippingAddressScreen(),
                      ),
                    );
                  },
                  child: const Text('Add Address'),
                ),
              )
              : Padding(
                padding: const EdgeInsets.all(25.0),
                child: InkWell(
                  onTap: () async {
                    if (_selectedPaymentMethod == 'stripe') {
                      // Pay With Stripe
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) {
                      //       // return RazorPayPage(
                      //       //   amount: widget.totalPrice * (1 - discount),
                      //       //   discount: discount,
                      //       // );
                      //     },
                      //   ),
                      // );
                    } else {
                      final bool? confirm = await showDialog<bool>(
                        context: context,
                        barrierDismissible: false,
                        builder:
                            (BuildContext context) => AlertDialog(
                              title: const Text("Confirm Order"),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "You are choosing Cash on Delivery method.",
                                  ),
                                  const SizedBox(height: 10),
                                  RichText(
                                    text: const TextSpan(
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                      ),
                                      children: [
                                        TextSpan(
                                          text:
                                              "By confirming, you agree that ",
                                        ),
                                        TextSpan(
                                          text: "fraudulent or fake orders ",
                                          style: TextStyle(color: Colors.red),
                                        ),
                                        TextSpan(
                                          text:
                                              "may lead to legal proceedings under Section 420 of IPC ",
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              actions: [
                                TextButton(
                                  onPressed:
                                      () => Navigator.pop(context, false),
                                  child: const Text("CANCEL"),
                                ),
                                ElevatedButton(
                                  onPressed: () => Navigator.pop(context, true),
                                  child: const Text("CONFIRM"),
                                ),
                              ],
                            ),
                      );

                      if (confirm != true) return;

                      setState(() {
                        isLoading = true;
                      });

                      final cartItems =
                          ref
                              .read(cartProvider.notifier)
                              .getCartItem
                              .values
                              .toList();
                      final userDoc =
                          await _firestore
                              .collection('customers')
                              .doc(_auth.currentUser!.uid)
                              .get();

                      final CollectionReference orderRefer = _firestore
                          .collection('orders');
                      final batch = _firestore.batch();

                      for (var item in cartItems) {
                        final orderId = const Uuid().v4();
                        final orderRef = orderRefer.doc(orderId);

                        batch.set(orderRef, {
                          'orderId': orderId,
                          'productName': item.productName,
                          'productId': item.productId,
                          'size': item.productSize,
                          'quantity': item.quantity,
                          'price':
                              ((item.quantity * item.discount) *
                                  (1 - discount)),
                          'category': item.category,
                          'productImage': item.productImage[0],
                          'name': userDoc.get('name'),
                          'email': userDoc.get('email'),
                          'number': userDoc.get('number'),
                          'customerId': _auth.currentUser!.uid,
                          'state': userDoc.get('state'),
                          'city': userDoc.get('city'),
                          'locality': userDoc.get('locality'),
                          'pinCode': userDoc.get('pinCode'),
                          'deliveredCount': 0,
                          'delivered': false,
                          'processing': true,
                          'vendorId': item.vendorId,
                        });
                      }

                      await batch.commit().then((_) {
                        ref.read(cartProvider.notifier).clearCartData();

                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MainScreen(index: 1,),
                          ),
                          (route) => false, // Remove all previous routes
                        );

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: Colors.grey,
                            content: Text('Order Has Been Placed'),
                          ),
                        );

                        setState(() => isLoading = false);
                      });
                    }
                  },
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width - 50,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(210, 248, 186, 94),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                      child:
                          isLoading
                              ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                              : const Text(
                                'PLACE YOUR ORDER',
                                style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  height: 1.4,
                                ),
                              ),
                    ),
                  ),
                ),
              ),
    );
  }
}
