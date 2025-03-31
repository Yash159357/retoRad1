//
//
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:reto_radiance/views/screens/authentication_screens/login_screen.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../inner_screens/order_screen.dart';
//
// class AccountScreen extends ConsumerStatefulWidget {
//   const AccountScreen({Key? key});
//
//   @override
//   _AccountScreenState createState() => _AccountScreenState();
// }
//
// class _AccountScreenState extends ConsumerState<AccountScreen> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//
//   Future<void> _logout(BuildContext context) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.remove('email'); // Remove email
//     await prefs.remove('password'); // Remove password
//
//     // Navigate to Login Screen
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (context) => LoginScreen()),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF7D7FA),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Container(
//               // width: MediaQuery.of(context).size.width,
//               height: 450,
//               clipBehavior: Clip.antiAlias,
//               decoration: const BoxDecoration(),
//               child: Stack(
//                 clipBehavior: Clip.none,
//                 children: [
//                   Align(
//                     alignment: Alignment.center,
//                     child: CachedNetworkImage(
//                       imageUrl:
//                       "https://images.unsplash.com/photo-1472289065668-ce650ac443d2?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8b3JhZ25nZSUyMGJhY2tncm91bmR8ZW58MHx8MHx8fDA%3D",
//                       width: MediaQuery.of(context).size.width,
//                       height: 451,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//
//                   // //PROFILE ICON TO UPDATE DATA
//                   // Positioned(
//                   //   top: 30,
//                   //   right: 30,
//                   //   child: Align(
//                   //     alignment: Alignment.topRight,
//                   //     child: badges.Badge(
//                   //       badgeStyle: badges.BadgeStyle(
//                   //         badgeColor: Colors.yellow.shade800,
//                   //       ),
//                   //       badgeContent: Text(
//                   //         "1",
//                   //         style: GoogleFonts.lato(color: Colors.white),
//                   //       ),
//                   //       child: Image.asset('assets/icons/not.png', width: 20),
//                   //     ),
//                   //   ),
//                   // ),
//
//                   Stack(
//                     children: [
//                       const Align(
//                         alignment: Alignment(0, -0.53),
//                         child: CircleAvatar(
//                           radius: 65,
//                           backgroundImage: CachedNetworkImageProvider(
//                             'https://cdn.pixabay.com/photo/2014/04/03/10/32/businessman-310819_1280.png',
//                           ),
//                         ),
//                       ),
//                       // Align(
//                       //   alignment: Alignment(0.23, -0.61),
//                       //   child: InkWell(
//                       //     onTap: () {},
//                       // child: Image.asset(
//                       //   'assets/icons/edit.png',
//                       //   width: 19,
//                       //   height: 19,
//                       //   fit: BoxFit.cover,
//                       // ),
//                       // ),
//                       // ),
//                     ],
//                   ),
//                   Align(
//                     alignment: const Alignment(0, 0.03),
//                     child: StreamBuilder<DocumentSnapshot>(
//                       stream:
//                       FirebaseFirestore.instance
//                           .collection("customers")
//                           .doc(_auth.currentUser!.uid)
//                           .snapshots(),
//                       builder: (context, snapshot) {
//                         if (snapshot.connectionState ==
//                             ConnectionState.waiting) {
//                           return Text("Loading...");
//                         }
//                         if (!snapshot.hasData || !snapshot.data!.exists) {
//                           return Text("Document not found!");
//                         }
//                         return Text(
//                           snapshot.data!["name"],
//                           style: GoogleFonts.getFont(
//                             'DM Sans',
//                             color: const Color.fromARGB(255, 24, 2, 2),
//                             fontSize: 22,
//                             fontWeight: FontWeight.bold,
//                             letterSpacing: 0.4,
//                           ),
//                         );
//                       },
//                     ),
//                     // child: Text(
//                     //   'Suvrajeet Jash',
//                     //   style: GoogleFonts.getFont(
//                     //     'DM Sans',
//                     //     color: Colors.white,
//                     //     fontSize: 22,
//                     //     fontWeight: FontWeight.bold,
//                     //     letterSpacing: 0.4,
//                     //   ),
//                     // ),
//                   ),
//                   Align(
//                     alignment: const Alignment(0.05, 0.17),
//                     child: InkWell(
//                       onTap: () {},
//                       child: StreamBuilder<DocumentSnapshot>(
//                         stream:
//                         FirebaseFirestore.instance
//                             .collection("customers")
//                             .doc(_auth.currentUser!.uid)
//                             .snapshots(),
//                         builder: (context, snapshot) {
//                           if (snapshot.connectionState ==
//                               ConnectionState.waiting) {
//                             return Text("Loading...");
//                           }
//                           if (!snapshot.hasData || !snapshot.data!.exists) {
//                             return Text("Document not found!");
//                           }
//                           return Text(
//                             snapshot.data!["city"],
//                             style: GoogleFonts.getFont(
//                               'DM Sans',
//                               color: Colors.white,
//                               fontSize: 22,
//                               fontWeight: FontWeight.bold,
//                               letterSpacing: 0.4,
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                   ),
//                   // Align(
//                   //   alignment: const Alignment(-0.22, 0.17),
//                   //   child: Image.network(
//                   //     "https://cdn.pixabay.com/photo/2014/04/03/10/32/businessman-310819_1280.png",
//                   //     width: 9,
//                   //     height: 12,
//                   //     fit: BoxFit.contain,
//                   //   ),
//                   // ),
//                   Align(
//                     alignment: const Alignment(0.09, 0.81),
//                     child: Container(
//                       width: 287,
//                       height: 117,
//                       clipBehavior: Clip.antiAlias,
//                       decoration: const BoxDecoration(),
//                       child: Stack(
//                         clipBehavior: Clip.none,
//                         children: [
//                           // const Positioned(
//                           //   left: 240,
//                           //   top: 66,
//                           //   child: Text(
//                           //     '0',
//                           //     style: TextStyle(
//                           //       color: Colors.white,
//                           //       fontSize: 22,
//                           //       letterSpacing: 0.4,
//                           //       fontFamily: 'DM Sans Medium',
//                           //     ),
//                           //   ),
//                           // ),
//                           // Positioned(
//                           //   left: 212,
//                           //   top: 99,
//                           //   child: Text(
//                           //     'Completed',
//                           //     textAlign: TextAlign.center,
//                           //     style: GoogleFonts.getFont(
//                           //       'DM Sans',
//                           //       color: Colors.white,
//                           //       fontSize: 14,
//                           //       letterSpacing: 0.3,
//                           //     ),
//                           //   ),
//                           // ),
//                           // Positioned(
//                           //   left: 224,
//                           //   top: 2,
//                           //   child: Container(
//                           //     width: 52,
//                           //     height: 58,
//                           //     clipBehavior: Clip.antiAlias,
//                           //     decoration: const BoxDecoration(
//                           //       image: DecorationImage(
//                           //         image: NetworkImage(
//                           //           "https://cdn.pixabay.com/photo/2014/04/03/10/32/businessman-310819_1280.png",
//                           //         ),
//                           //         fit: BoxFit.contain,
//                           //       ),
//                           //     ),
//                           //     child: Stack(
//                           //       clipBehavior: Clip.none,
//                           //       children: [
//                           //         Positioned(
//                           //           left: 13,
//                           //           top: 18,
//                           //           child: Image.network(
//                           //             "https://cdn.pixabay.com/photo/2014/04/03/10/32/businessman-310819_1280.png",
//                           //             width: 26,
//                           //             height: 26,
//                           //             fit: BoxFit.cover,
//                           //           ),
//                           //         ),
//                           //       ],
//                           //     ),
//                           //   ),
//                           // ),
//                           const Positioned(
//                             left: 172,
//                             top: 66,
//                             child: Text( //Show how many items are in Wishlist currently
//                               // '5',
//                               'Reto',
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 22,
//                                 letterSpacing: 0.4,
//                                 fontFamily: 'DM Sans Medium',
//                               ),
//                             ),
//                           ),
//                           Positioned(
//                             left: 165,
//                             top: 99,
//                             child: Text(
//                               'Favourite',
//                               textAlign: TextAlign.center,
//                               style: GoogleFonts.getFont(
//                                 'DM Sans',
//                                 color: Colors.white,
//                                 fontSize: 14,
//                                 letterSpacing: 0.3,
//                               ),
//                             ),
//                           ),
//                           Positioned(
//                             left: 170,
//                             top: 2,
//                             child: Container(
//                               width: 52,
//                               height: 58,
//                               clipBehavior: Clip.antiAlias,
//                               decoration: const BoxDecoration(
//                                 image: DecorationImage(
//                                   image: CachedNetworkImageProvider(
//                                     'https://firebasestorage.googleapis.com/v0/b/codeless-app.appspot.com/o/projects%2Fnn2Ldqjoc2Xp89Y7Wfzf%2F068bdad59a9aff5a9ee67737678b8d5438866afewish-list%201.png?alt=media&token=4a8abc27-022f-4a53-8f07-8c10791468e4',
//                                   ),
//                                   fit: BoxFit.contain,
//                                 ),
//                               ),
//                               // child: Stack(
//                               // clipBehavior: Clip.none,
//                               // children: [
//                               // Positioned(
//                               //   left: 15,
//                               //   top: 18,
//                               //   child: Image.network(
//                               //     "https://cdn.pixabay.com/photo/2014/04/03/10/32/businessman-310819_1280.png",
//                               //     width: 26,
//                               //     height: 26,
//                               //     fit: BoxFit.cover,
//                               //   ),
//                               // ),
//                               // ],
//                               // ),
//                             ),
//                           ),
//                           Positioned(
//                             left: 40,
//                             top: 66,
//                             child: Text( //Show how many items are in Cart currently
//                               // '4',
//                               'Reto',
//                               style: GoogleFonts.quicksand(
//                                 color: Colors.white,
//                                 fontSize: 22,
//                                 letterSpacing: 0.4,
//                               ),
//                             ),
//                           ),
//                           Positioned(
//                             left: 50,
//                             top: 99,
//                             child: Text(
//                               'Cart',
//                               textAlign: TextAlign.center,
//                               style: GoogleFonts.quicksand(
//                                 color: Colors.white,
//                                 fontSize: 14,
//                                 letterSpacing: 0.3,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                           Positioned(
//                             left: 40,
//                             top: 0,
//                             child: Container(
//                               width: 56,
//                               height: 63,
//                               clipBehavior: Clip.antiAlias,
//                               decoration: const BoxDecoration(
//                                 image: DecorationImage(
//                                   image: CachedNetworkImageProvider(
//                                     'https://firebasestorage.googleapis.com/v0/b/codeless-app.appspot.com/o/projects%2Fnn2Ldqjoc2Xp89Y7Wfzf%2F4ad2eb1752466c61c6bb41a0e223251a906a1a7bcorrect%201.png?alt=media&token=57abd4a6-50b4-4609-bb59-b48dce4c8cc6',
//                                   ),
//                                   fit: BoxFit.contain,
//                                 ),
//                               ),
//                               // child: Stack(
//                               //   clipBehavior: Clip.none,
//                               //   children: [
//                               //     Positioned(
//                               //       left: 12,
//                               //       top: 15,
//                               //       child: Image.network(
//                               //         "https://cdn.pixabay.com/photo/2014/04/03/10/32/businessman-310819_1280.png",
//                               //         width: 33,
//                               //         height: 33,
//                               //         fit: BoxFit.cover,
//                               //       ),
//                               //     ),
//                               //   ],
//                               // ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 10),
//             ListTile(
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) {
//                       return OrderScreen();
//                     },
//                   ),
//                 );
//               },
//               leading: Image.asset('assets/icons/orders.png'),
//               title: Text(
//                 'Track your order',
//                 style: GoogleFonts.lato(fontWeight: FontWeight.bold),
//               ),
//             ),
//             SizedBox(height: 10),
//             // ListTile(
//             //   leading: Image.asset('assets/icons/history.png'),
//             //   title: Text(
//             //     'History ',
//             //     style: GoogleFonts.lato(fontWeight: FontWeight.bold),
//             //   ),
//             // ),
//             // SizedBox(height: 10),
//             // ListTile(
//             //   leading: Image.asset('assets/icons/help.png'),
//             //   title: Text(
//             //     'Help ',
//             //     style: GoogleFonts.lato(fontWeight: FontWeight.bold),
//             //   ),
//             // ),
//             // SizedBox(height: 10),
//             ListTile(
//               onTap: () async {
//                 await _logout(context);
//               },
//               leading: Image.asset('assets/icons/logout.png'),
//               title: Text(
//                 'Logout ',
//                 style: GoogleFonts.lato(fontWeight: FontWeight.bold),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:reto_radiance/controllers/shared_preference_controller.dart';
import 'package:reto_radiance/provider/cart_provider.dart';
import 'package:reto_radiance/provider/favorite_provider.dart';
import 'package:reto_radiance/views/screens/authentication_screens/login_screen.dart';
import 'package:reto_radiance/views/screens/inner_screens/shipping_address_screen.dart';
// import 'package:shared_preferences/shared_preferences.dart';

import '../inner_screens/order_screen.dart';

class AccountScreen extends ConsumerStatefulWidget {
  const AccountScreen({Key? key});

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends ConsumerState<AccountScreen> {
  // final FirebaseAuth _auth = FirebaseAuth.instance;

  // Future<void> _logout(BuildContext context) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.remove('email'); // Remove email
  //   await prefs.remove('password'); // Remove password

  //   await _auth.signOut();

  //   // Navigate to Login Screen
  //   Navigator.pushReplacement(
  //     context,
  //     MaterialPageRoute(builder: (context) => LoginScreen()),
  //   );
  // }
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoggingOut = false;

  Future<void> _logout(BuildContext context) async {
    setState(() => _isLoggingOut = true);

    try {
      // Clear all user-specific data
      // final prefs = await SharedPreferences.getInstance();
      // final sharedPrefController = SharedPreferenceController(prefs);
      ref.invalidate(favoriteProvider);
      ref.invalidate(cartProvider);
      // Clear all user data from SharedPreferences

      // Clear navigation stack completely
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
        (route) => false,
      );
      // Clear Firebase session
      await _auth.signOut();
    } catch (e) {
      // Handle logout errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Logout failed: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoggingOut = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7D7FA),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              // width: MediaQuery.of(context).size.width,
              height: 450,
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: CachedNetworkImage(
                      imageUrl:
                          "https://images.unsplash.com/photo-1472289065668-ce650ac443d2?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8b3JhZ25nZSUyMGJhY2tncm91bmR8ZW58MHx8MHx8fDA%3D",
                      width: MediaQuery.of(context).size.width,
                      height: 451,
                      fit: BoxFit.cover,
                    ),
                  ),

                  // //PROFILE ICON TO UPDATE DATA
                  // Positioned(
                  //   top: 30,
                  //   right: 30,
                  //   child: Align(
                  //     alignment: Alignment.topRight,
                  //     child: badges.Badge(
                  //       badgeStyle: badges.BadgeStyle(
                  //         badgeColor: Colors.yellow.shade800,
                  //       ),
                  //       badgeContent: Text(
                  //         "1",
                  //         style: GoogleFonts.lato(color: Colors.white),
                  //       ),
                  //       child: Image.asset('assets/icons/not.png', width: 20),
                  //     ),
                  //   ),
                  // ),
                  Stack(
                    children: [
                      const Align(
                        alignment: Alignment(0, -0.53),
                        child: CircleAvatar(
                          radius: 65,
                          backgroundImage: CachedNetworkImageProvider(
                            'https://cdn.pixabay.com/photo/2014/04/03/10/32/businessman-310819_1280.png',
                          ),
                        ),
                      ),
                      // Align(
                      //   alignment: Alignment(0.23, -0.61),
                      //   child: InkWell(
                      //     onTap: () {},
                      // child: Image.asset(
                      //   'assets/icons/edit.png',
                      //   width: 19,
                      //   height: 19,
                      //   fit: BoxFit.cover,
                      // ),
                      // ),
                      // ),
                    ],
                  ),
                  Align(
                    alignment: const Alignment(0, 0.03),
                    child: StreamBuilder<DocumentSnapshot>(
                      stream:
                          _auth.currentUser != null
                              ? FirebaseFirestore.instance
                                  .collection("customers")
                                  .doc(_auth.currentUser!.uid)
                                  .snapshots()
                              : null,
                      builder: (context, snapshot) {
                        if (_auth.currentUser == null) {
                          return const Text(
                            "Please log in to view your account details",
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          );
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Text("Loading...");
                        }
                        if (!snapshot.hasData || !snapshot.data!.exists) {
                          return const Text("Document not found!");
                        }
                        return Text(
                          snapshot.data!["name"],
                          style: GoogleFonts.getFont(
                            'DM Sans',
                            color: const Color.fromARGB(255, 24, 2, 2),
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.4,
                          ),
                        );
                      },
                    ),
                  ),

                  // child: Text(
                  //   'Suvrajeet Jash',
                  //   style: GoogleFonts.getFont(
                  //     'DM Sans',
                  //     color: Colors.white,
                  //     fontSize: 22,
                  //     fontWeight: FontWeight.bold,
                  //     letterSpacing: 0.4,
                  //   ),
                  // ),
                  Align(
                    alignment: const Alignment(0.05, 0.17),
                    child: InkWell(
                      onTap: () {},
                      child: StreamBuilder<DocumentSnapshot>(
                        stream:
                            _auth.currentUser != null
                                ? FirebaseFirestore.instance
                                    .collection("customers")
                                    .doc(_auth.currentUser!.uid)
                                    .snapshots()
                                : null,
                        builder: (context, snapshot) {
                          if (_auth.currentUser == null) {
                            return const Text(
                              "Please log in to view your city",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            );
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Text("Loading...");
                          }
                          if (!snapshot.hasData || !snapshot.data!.exists) {
                            return const Text("Document not found!");
                          }
                          return Text(
                            snapshot.data!["city"],
                            style: GoogleFonts.getFont(
                              'DM Sans',
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.4,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  // Align(
                  //   alignment: const Alignment(-0.22, 0.17),
                  //   child: Image.network(
                  //     "https://cdn.pixabay.com/photo/2014/04/03/10/32/businessman-310819_1280.png",
                  //     width: 9,
                  //     height: 12,
                  //     fit: BoxFit.contain,
                  //   ),
                  // ),
                  Align(
                    alignment: const Alignment(0.09, 0.81),
                    child: Container(
                      width: 287,
                      height: 117,
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          // const Positioned(
                          //   left: 240,
                          //   top: 66,
                          //   child: Text(
                          //     '0',
                          //     style: TextStyle(
                          //       color: Colors.white,
                          //       fontSize: 22,
                          //       letterSpacing: 0.4,
                          //       fontFamily: 'DM Sans Medium',
                          //     ),
                          //   ),
                          // ),
                          // Positioned(
                          //   left: 212,
                          //   top: 99,
                          //   child: Text(
                          //     'Completed',
                          //     textAlign: TextAlign.center,
                          //     style: GoogleFonts.getFont(
                          //       'DM Sans',
                          //       color: Colors.white,
                          //       fontSize: 14,
                          //       letterSpacing: 0.3,
                          //     ),
                          //   ),
                          // ),
                          // Positioned(
                          //   left: 224,
                          //   top: 2,
                          //   child: Container(
                          //     width: 52,
                          //     height: 58,
                          //     clipBehavior: Clip.antiAlias,
                          //     decoration: const BoxDecoration(
                          //       image: DecorationImage(
                          //         image: NetworkImage(
                          //           "https://cdn.pixabay.com/photo/2014/04/03/10/32/businessman-310819_1280.png",
                          //         ),
                          //         fit: BoxFit.contain,
                          //       ),
                          //     ),
                          //     child: Stack(
                          //       clipBehavior: Clip.none,
                          //       children: [
                          //         Positioned(
                          //           left: 13,
                          //           top: 18,
                          //           child: Image.network(
                          //             "https://cdn.pixabay.com/photo/2014/04/03/10/32/businessman-310819_1280.png",
                          //             width: 26,
                          //             height: 26,
                          //             fit: BoxFit.cover,
                          //           ),
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          // ),
                          const Positioned(
                            left: 172,
                            top: 66,
                            child: Text(
                              //Show how many items are in Wishlist currently
                              // '5',
                              'Reto',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                letterSpacing: 0.4,
                                fontFamily: 'DM Sans Medium',
                              ),
                            ),
                          ),
                          Positioned(
                            left: 165,
                            top: 99,
                            child: Text(
                              'Favourite',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.getFont(
                                'DM Sans',
                                color: Colors.white,
                                fontSize: 14,
                                letterSpacing: 0.3,
                              ),
                            ),
                          ),
                          Positioned(
                            left: 170,
                            top: 2,
                            child: Container(
                              width: 52,
                              height: 58,
                              clipBehavior: Clip.antiAlias,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: CachedNetworkImageProvider(
                                    'https://firebasestorage.googleapis.com/v0/b/codeless-app.appspot.com/o/projects%2Fnn2Ldqjoc2Xp89Y7Wfzf%2F068bdad59a9aff5a9ee67737678b8d5438866afewish-list%201.png?alt=media&token=4a8abc27-022f-4a53-8f07-8c10791468e4',
                                  ),
                                  fit: BoxFit.contain,
                                ),
                              ),
                              // child: Stack(
                              // clipBehavior: Clip.none,
                              // children: [
                              // Positioned(
                              //   left: 15,
                              //   top: 18,
                              //   child: Image.network(
                              //     "https://cdn.pixabay.com/photo/2014/04/03/10/32/businessman-310819_1280.png",
                              //     width: 26,
                              //     height: 26,
                              //     fit: BoxFit.cover,
                              //   ),
                              // ),
                              // ],
                              // ),
                            ),
                          ),
                          Positioned(
                            left: 40,
                            top: 66,
                            child: Text(
                              //Show how many items are in Cart currently
                              // '4',
                              'Reto',
                              style: GoogleFonts.quicksand(
                                color: Colors.white,
                                fontSize: 22,
                                letterSpacing: 0.4,
                              ),
                            ),
                          ),
                          Positioned(
                            left: 50,
                            top: 99,
                            child: Text(
                              'Cart',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.quicksand(
                                color: Colors.white,
                                fontSize: 14,
                                letterSpacing: 0.3,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Positioned(
                            left: 40,
                            top: 0,
                            child: Container(
                              width: 56,
                              height: 63,
                              clipBehavior: Clip.antiAlias,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: CachedNetworkImageProvider(
                                    'https://firebasestorage.googleapis.com/v0/b/codeless-app.appspot.com/o/projects%2Fnn2Ldqjoc2Xp89Y7Wfzf%2F4ad2eb1752466c61c6bb41a0e223251a906a1a7bcorrect%201.png?alt=media&token=57abd4a6-50b4-4609-bb59-b48dce4c8cc6',
                                  ),
                                  fit: BoxFit.contain,
                                ),
                              ),
                              // child: Stack(
                              //   clipBehavior: Clip.none,
                              //   children: [
                              //     Positioned(
                              //       left: 12,
                              //       top: 15,
                              //       child: Image.network(
                              //         "https://cdn.pixabay.com/photo/2014/04/03/10/32/businessman-310819_1280.png",
                              //         width: 33,
                              //         height: 33,
                              //         fit: BoxFit.cover,
                              //       ),
                              //     ),
                              //   ],
                              // ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return OrderScreen();
                    },
                  ),
                );
              },
              leading: Image.asset('assets/icons/orders.png'),
              title: Text(
                'Track your order',
                style: GoogleFonts.lato(fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return ShippingAddressScreen();
                    },
                  ),
                );
              },
              leading: Image.asset('assets/icons/history.png'),
              title: Text(
                'Add/Update Address',
                style: GoogleFonts.lato(fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),
            // ListTile(
            //   leading: Image.asset('assets/icons/help.png'),
            //   title: Text(
            //     'Help ',
            //     style: GoogleFonts.lato(fontWeight: FontWeight.bold),
            //   ),
            // ),
            SizedBox(height: 10),
            ListTile(
              onTap: () async {
                if (_auth.currentUser != null) {
                  // User is logged in, perform logout
                  await _logout(context);
                } else {
                  // User is not logged in, navigate to LoginScreen
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                }
              },
              leading: Image.asset(
                _auth.currentUser != null
                    ? 'assets/icons/logout.png'
                    : 'assets/icons/logout.png',
              ),
              title: Text(
                _auth.currentUser != null ? 'Logout' : 'Sign In',
                style: GoogleFonts.lato(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
