// //
// //
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:flutter/material.dart';
// // import 'package:reto_radiance/views/screens/inner_screens/shipping_address_screen.dart';
// // import 'package:reto_radiance/views/screens/nav_screens/reuseable_text_widget.dart';
// // import 'package:reto_radiance/views/screens/nav_screens/widgets/banner_widget.dart';
// // import 'package:reto_radiance/views/screens/nav_screens/widgets/category_item.dart';
// // import 'package:reto_radiance/views/screens/nav_screens/widgets/icon_widget.dart';
// // import 'package:reto_radiance/views/screens/nav_screens/widgets/popular_product_widget.dart';
// // import 'package:reto_radiance/views/screens/nav_screens/widgets/recommended_product_widget.dart';
// //
// // class HomeScreen extends StatefulWidget {
// //   HomeScreen({super.key});
// //
// //   @override
// //   State<HomeScreen> createState() => _HomeScreenState();
// // }
// //
// // class _HomeScreenState extends State<HomeScreen> {
// //   final TextEditingController _searchController = TextEditingController();
// //
// //   final FocusNode _searchFocusNode = FocusNode();
// //
// //   final FirebaseAuth _auth = FirebaseAuth.instance;
// //
// //   final GlobalKey<RecommendedProductWidgetState> _recommendedProductWidgetKey =
// //   GlobalKey<RecommendedProductWidgetState>();
// //
// //   final GlobalKey<PopularProductWidgetState> _popularProductKey =
// //   GlobalKey<PopularProductWidgetState>();
// //
// //   void onSearch(String query) {
// //     // Implement your search logic here
// //     print('Searching for: $query');
// //     if (_recommendedProductWidgetKey.currentState != null) {
// //       _recommendedProductWidgetKey.currentState?.onSearch(query);
// //       _popularProductKey.currentState?.onSearch(query);
// //     } else {
// //       print('RecommendedProductWidget state is not yet available.');
// //       // Optionally, you can add a fallback behavior here, like showing a default list.
// //     }
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     // WidgetsBinding.instance.addPostFrameCallback((_) {
// //     //   if (!_searchFocusNode.hasFocus) {
// //     //     _searchFocusNode.requestFocus();
// //     //   }
// //     // });
// //
// //     return Scaffold(
// //       appBar: AppBar(
// //         // backgroundColor: const Color.fromARGB(255, 245, 200, 127),
// //         backgroundColor: Colors.white,
// //         elevation: 0,
// //         automaticallyImplyLeading:
// //         false, //This will remove the default back button from our App Bar
// //         title: Padding(
// //           padding: const EdgeInsets.only(top: 8.0, left: 17),
// //           child: Container(
// //             width: 350,
// //             decoration: BoxDecoration(
// //               color: const Color(0xFFF7D7FA),
// //               borderRadius: BorderRadius.circular(20),
// //               // border: Border.all(color: Colors.black),
// //             ),
// //             child: TextField(
// //               controller: _searchController,
// //               focusNode: _searchFocusNode,
// //               decoration: InputDecoration(
// //                 prefixIcon: Icon(Icons.search),
// //                 suffixIcon:
// //                 _searchController.text.isNotEmpty
// //                     ? IconButton(
// //                   icon: Icon(Icons.clear),
// //                   onPressed: () {
// //                     setState(() {
// //                       _searchController.clear();
// //                       onSearch(''); // Clear the search results
// //                     });
// //                     _searchFocusNode.unfocus();
// //                   },
// //                 )
// //                     : null,
// //                 border: InputBorder.none,
// //                 hintText: 'Wooden Mandir',
// //                 contentPadding: EdgeInsets.symmetric(
// //                   vertical: 10.0,
// //                   horizontal: 16.0,
// //                 ),
// //               ),
// //               textAlignVertical: TextAlignVertical.center,
// //               onChanged: (text) {
// //                 setState(() {}); // Trigger rebuild to show/hide the clear icon
// //               },
// //               onSubmitted: onSearch,
// //             ),
// //           ),
// //         ),
// //         // actions: [
// //         //   IconButton(
// //         //     onPressed: () {},
// //         //     icon: const Icon(Icons.compare_arrows),
// //         //     color: const Color(0xFFB38859),
// //         //   ),
// //         // ],
// //         bottom: PreferredSize(
// //           preferredSize: const Size.fromHeight(50),
// //           child: Padding(
// //             padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
// //             // child: DropdownButtonFormField<String>(
// //             //   value: 'Suvrajeet - Coimbatore 641029',
// //             //   onChanged: (value) {},
// //             //   decoration: const InputDecoration(
// //             //     prefixIcon: Icon(Icons.location_on),
// //             //     border: InputBorder.none,
// //             //   ),
// //             //   items: const [
// //             //     DropdownMenuItem(
// //             //       value: 'Suvrajeet - Coimbatore 641029',
// //             //       child: Text('Suvrajeet - Coimbatore 641029'),
// //             //     ),
// //             //   ],
// //             // ),
// //             child: TextButton(
// //               onPressed: () {
// //                 Navigator.push(
// //                   context,
// //                   MaterialPageRoute(
// //                     builder: (context) {
// //                       return ShippingAddressScreen(); //Navigating to Order Detail Screen and also passing complete our order data.
// //                     },
// //                   ),
// //                 );
// //               },
// //
// //               child: StreamBuilder<DocumentSnapshot>(
// //                 stream:
// //                 FirebaseFirestore.instance
// //                     .collection("customers")
// //                     .doc(_auth.currentUser!.uid)
// //                     .snapshots(),
// //                 builder: (context, snapshot) {
// //                   if (snapshot.connectionState == ConnectionState.waiting) {
// //                     return Text("Loading...");
// //                   }
// //                   if (!snapshot.hasData || !snapshot.data!.exists) {
// //                     return Text("Document not found!");
// //                   }
// //                   return Text(
// //                     snapshot.data!["name"] +
// //                         " - " +
// //                         snapshot.data!["city"] +
// //                         " " +
// //                         snapshot.data!["pinCode"],
// //                     style: TextStyle(
// //                       fontSize: 18,
// //                       color: const Color.fromARGB(255, 42, 42, 42),
// //                     ),
// //                   );
// //                 },
// //               ),
// //             ),
// //           ),
// //         ),
// //       ),
// //       // body: Center(child: Text('Welcome to Home of RetoINDIA'),),
// //       body: SingleChildScrollView(
// //         //Making our Home Screen Scrollable
// //         child: Container(
// //           decoration: BoxDecoration(
// //             color: const Color(0xFFF7D7FA),
// //             borderRadius: BorderRadius.only(
// //               topLeft: Radius.circular(50),
// //               topRight: Radius.circular(50),
// //             ),
// //           ),
// //           child: Column(
// //             children: [
// //               //Here in this it will mention particularly how and in what order our Widgets will be displayed.
// //               // HeaderWidget(), //Calling our Header Widget
// //               IconWidget(), //Calling our Banner Widget
// //               CategoryItem(), //Calling our Category Section
// //               BannerWidget(),
// //               ReuseableTextWidget(
// //                 title: 'Recommended For You',
// //                 subtitle: 'View All',
// //               ), //Calling our this reuseable text widget and displaying our Section heading and sub heading.
// //               RecommendedProductWidget(
// //                 key: _recommendedProductWidgetKey,
// //               ), //Displaying our Recommended Section
// //               ReuseableTextWidget(
// //                 title: 'Popular Products',
// //                 subtitle: 'View All',
// //               ),
// //               PopularProductWidget(key: _popularProductKey),
// //               SizedBox(height: 20),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:reto_radiance/models/product_model.dart';
// import 'package:reto_radiance/provider/product_provider.dart';
// import 'package:reto_radiance/views/screens/inner_screens/shipping_address_screen.dart';
// import 'package:reto_radiance/views/screens/nav_screens/reuseable_text_widget.dart';
// import 'package:reto_radiance/views/screens/nav_screens/widgets/banner_widget.dart';
// import 'package:reto_radiance/views/screens/nav_screens/widgets/category_item.dart';
// import 'package:reto_radiance/views/screens/nav_screens/widgets/icon_widget.dart';
// import 'package:reto_radiance/views/screens/nav_screens/widgets/popular_product_widget.dart';
// import 'package:reto_radiance/views/screens/nav_screens/widgets/recommended_product_widget.dart';

// class HomeScreen extends ConsumerStatefulWidget {
//   HomeScreen({super.key});

//   @override
//   ConsumerState<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends ConsumerState<HomeScreen> {

//   final TextEditingController _searchController = TextEditingController();
//   final FocusNode _searchFocusNode = FocusNode();
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   String _searchQuery = '';

//   // final GlobalKey<RecommendedProductWidgetState> _recommendedProductWidgetKey =
//   //     GlobalKey<RecommendedProductWidgetState>();

//   // final GlobalKey<PopularProductWidgetState> _popularProductKey =
//   //     GlobalKey<PopularProductWidgetState>();

//   void _onSearchChanged() {
//     setState(() {
//       _searchQuery = _searchController.text.toLowerCase();
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       ref.read(productProvider.notifier).fetchAllProducts();
//     });
//     _searchController.addListener(_onSearchChanged);
//   }

//   List<ProductModel> _filterProducts(List<ProductModel> products) {
//     if (_searchQuery.isEmpty || _searchQuery.trim() == '') return products;
//     return products.where((product) =>
//         product.productName.toLowerCase().contains(_searchQuery)).toList();
//   }
//   @override
//   void dispose() {
//     _searchController.removeListener(_onSearchChanged);
//     _searchController.dispose();
//     _searchFocusNode.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // WidgetsBinding.instance.addPostFrameCallback((_) {
//     //   if (!_searchFocusNode.hasFocus) {
//     //     _searchFocusNode.requestFocus();
//     //   }
//     // });
//     final productState = ref.watch(productProvider);
//     final recommendedProducts = _filterProducts(
//       ref.read(productProvider.notifier).getRecommendedProducts()
//     );
//     final popularProducts = _filterProducts(
//       ref.read(productProvider.notifier).getPopularProducts()
//     );

//     return Scaffold(
//       appBar: AppBar(
//         // backgroundColor: const Color.fromARGB(255, 245, 200, 127),
//         backgroundColor: Colors.white,
//         elevation: 0,
//         automaticallyImplyLeading:
//             false, //This will remove the default back button from our App Bar
//         title: Padding(
//           padding: const EdgeInsets.only(top: 8.0, left: 17),
//           child: Container(
//             width: 350,
//             decoration: BoxDecoration(
//               color: const Color(0xFFF7D7FA),
//               borderRadius: BorderRadius.circular(20),
//               // border: Border.all(color: Colors.black),
//             ),
//             child: TextField(
//               controller: _searchController,
//               focusNode: _searchFocusNode,
//               decoration: InputDecoration(
//                 prefixIcon: Icon(Icons.search),
//                 suffixIcon:
//                     _searchController.text.isNotEmpty
//                         ? IconButton(
//                           icon: Icon(Icons.clear),
//                           onPressed: () {
//                             setState(() {
//                               _searchController.clear();
//                               _onSearchChanged(); // Clear the search results
//                             });
//                             _searchFocusNode.unfocus();
//                           },
//                         )
//                         : null,
//                 border: InputBorder.none,
//                 hintText: 'Wooden Mandir',
//                 contentPadding: EdgeInsets.symmetric(
//                   vertical: 10.0,
//                   horizontal: 16.0,
//                 ),
//               ),
//               textAlignVertical: TextAlignVertical.center,
//               onChanged: (text) {
//                 setState(() {
//                   _onSearchChanged();
//                 }); // Trigger rebuild to show/hide the clear icon
//               },
//               onSubmitted: (value) {
//                 setState(() {
//                   _onSearchChanged();
//                 });
//               },
//             ),
//           ),
//         ),
//         // actions: [
//         //   IconButton(
//         //     onPressed: () {},
//         //     icon: const Icon(Icons.compare_arrows),
//         //     color: const Color(0xFFB38859),
//         //   ),
//         // ],
//         bottom: PreferredSize(
//           preferredSize: const Size.fromHeight(50),
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
//             // child: DropdownButtonFormField<String>(
//             //   value: 'Suvrajeet - Coimbatore 641029',
//             //   onChanged: (value) {},
//             //   decoration: const InputDecoration(
//             //     prefixIcon: Icon(Icons.location_on),
//             //     border: InputBorder.none,
//             //   ),
//             //   items: const [
//             //     DropdownMenuItem(
//             //       value: 'Suvrajeet - Coimbatore 641029',
//             //       child: Text('Suvrajeet - Coimbatore 641029'),
//             //     ),
//             //   ],
//             // ),
//             child: TextButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) {
//                       return ShippingAddressScreen(); //Navigating to Order Detail Screen and also passing complete our order data.
//                     },
//                   ),
//                 );
//               },

//               child: StreamBuilder<DocumentSnapshot>(
//                 stream:
//                     FirebaseFirestore.instance
//                         .collection("customers")
//                         .doc(_auth.currentUser!.uid)
//                         .snapshots(),
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return Text("Loading...");
//                   }
//                   if (!snapshot.hasData || !snapshot.data!.exists) {
//                     return Text("Document not found!");
//                   }
//                   return Text(
//                     snapshot.data!["name"] +
//                         " - " +
//                         snapshot.data!["city"] +
//                         " " +
//                         snapshot.data!["pinCode"],
//                     style: TextStyle(
//                       fontSize: 18,
//                       color: const Color.fromARGB(255, 42, 42, 42),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ),
//         ),
//       ),
//       // body: Center(child: Text('Welcome to Home of RetoINDIA'),),
//       body: SingleChildScrollView(
//         //Making our Home Screen Scrollable
//         child: Container(
//           decoration: BoxDecoration(
//             color: const Color(0xFFF7D7FA),
//             borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(50),
//               topRight: Radius.circular(50),
//             ),
//           ),
//           child: Column(
//             children: [
//               //Here in this it will mention particularly how and in what order our Widgets will be displayed.
//               // HeaderWidget(), //Calling our Header Widget
//               IconWidget(), //Calling our Banner Widget
//               CategoryItem(), //Calling our Category Section
//               BannerWidget(),
//               ReuseableTextWidget(
//                 title: 'Recommended For You',
//                 // subtitle: 'View All',
//               ), //Calling our this reuseable text widget and displaying our Section heading and sub heading.
//               RecommendedProductWidget(
//                 recommendedProducts: recommendedProducts
//               ), //Displaying our Recommended Section
//               ReuseableTextWidget(
//                 title: 'Popular Products',
//                 // subtitle: 'View All',
//               ),
//               PopularProductWidget(
//                 popularProducts: popularProducts,
//               ),
//               SizedBox(height: 20),
//             ],
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
import 'package:reto_radiance/models/product_model.dart';
import 'package:reto_radiance/provider/product_provider.dart';
import 'package:reto_radiance/views/screens/inner_screens/shipping_address_screen.dart';
import 'package:reto_radiance/views/screens/nav_screens/reuseable_text_widget.dart';
import 'package:reto_radiance/views/screens/nav_screens/widgets/banner_widget.dart';
import 'package:reto_radiance/views/screens/nav_screens/widgets/category_item.dart';
import 'package:reto_radiance/views/screens/nav_screens/widgets/icon_widget.dart';
import 'package:reto_radiance/views/screens/nav_screens/widgets/popular_product_widget.dart';
import 'package:reto_radiance/views/screens/nav_screens/widgets/recommended_product_widget.dart';

class HomeScreen extends ConsumerStatefulWidget {
  HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(productProvider.notifier).fetchAllProducts();
    });
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchController.text.toLowerCase();
    });
  }

  List<ProductModel> _filterProducts(List<ProductModel> products) {
    if (_searchQuery.isEmpty) return products;
    return products
        .where(
          (product) => product.productName.toLowerCase().contains(_searchQuery),
        )
        .toList();
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // print(1);
    final productState = ref.watch(productProvider);
    final recommendedProducts = _filterProducts(
      ref.read(productProvider.notifier).getRecommendedProducts(),
    );
    final popularProducts = _filterProducts(
      ref.read(productProvider.notifier).getPopularProducts(),
    );
    // print("Recommended: $recommendedProducts");
    // print("Popular: $popularProducts");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 17),
          child: Container(
            width: 350,
            decoration: BoxDecoration(
              color: const Color(0xFFF7D7FA),
              borderRadius: BorderRadius.circular(20),
            ),
            child: TextField(
              controller: _searchController,
              focusNode: _searchFocusNode,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                suffixIcon:
                    _searchController.text.isNotEmpty
                        ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _searchController.clear();
                            _searchQuery = '';
                            _searchFocusNode.unfocus();
                            setState(() {});
                          },
                        )
                        : null,
                border: InputBorder.none,
                hintText: 'Wooden Mandir',
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 16.0,
                ),
              ),
              textAlignVertical: TextAlignVertical.center,
            ),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ShippingAddressScreen(),
                  ),
                );
              },
              child: StreamBuilder<DocumentSnapshot>(
                stream:
                    _auth.currentUser != null
                        ? FirebaseFirestore.instance
                            .collection("customers")
                            .doc(_auth.currentUser!.uid)
                            .snapshots()
                        : null,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Text("Loading...");
                  }
                  if (!snapshot.hasData || !snapshot.data!.exists) {
                    return const Text("Add Shipping Address");
                  }
                  return Text(
                    "${snapshot.data!["name"]} - ${snapshot.data!["city"]} ${snapshot.data!["pinCode"]}",
                    style: const TextStyle(
                      fontSize: 18,
                      color: Color.fromARGB(255, 42, 42, 42),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF7D7FA),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(50),
              topRight: Radius.circular(50),
            ),
          ),
          child: Column(
            children: [
              const IconWidget(),
              const CategoryItem(),
              const BannerWidget(),
              const ReuseableTextWidget(title: 'Recommended For You'),
              RecommendedProductWidget(
                key: ValueKey('recommended-${recommendedProducts.hashCode}'),
                recommendedProducts: recommendedProducts,
              ),
              const ReuseableTextWidget(title: 'Popular Products'),
              PopularProductWidget(
                key: ValueKey('popular-${popularProducts.hashCode}'),
                popularProducts: popularProducts,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
