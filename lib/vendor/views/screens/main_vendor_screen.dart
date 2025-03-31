

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reto_radiance/vendor/views/screens/BottomNavigationBar/earnings_screen.dart';
import 'package:reto_radiance/vendor/views/screens/BottomNavigationBar/edit_product_screen.dart';
import 'package:reto_radiance/vendor/views/screens/BottomNavigationBar/upload_product_screen.dart';
import 'package:reto_radiance/vendor/views/screens/BottomNavigationBar/vendor_order_screen.dart';
import 'package:reto_radiance/vendor/views/screens/BottomNavigationBar/vendor_profile_screen.dart';

class MainVendorScreen extends StatefulWidget {
  const MainVendorScreen({super.key});

  @override
  State<MainVendorScreen> createState() => _MainVendorScreenState();
}

class _MainVendorScreenState extends State<MainVendorScreen> {

  int pageIndex = 0; //Using this we will navigate to different pages though our Bottom Navigation Bar.

  final List<Widget> _pages = [  //List to store all the pages
    EarningsScreen(),
    UploadProductScreen(),
    VendorOrderScreen(),
    EditProductScreen(),
    VendorProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      //BOTTOM NAVIGATION BAR

      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,

        currentIndex: pageIndex,

        onTap: (value) {
          setState(() {
            pageIndex = value;
          });
        },

        type: BottomNavigationBarType.fixed, //It will fix our Bottom Navigation Bar even if we scroll.
          items: const [
        BottomNavigationBarItem(icon: Icon(CupertinoIcons.money_dollar,), label: 'Earnings'),
        BottomNavigationBarItem(icon: Icon(CupertinoIcons.upload_circle,), label: 'Upload'),
        BottomNavigationBarItem(icon: Icon(Icons.shopping_cart,), label: 'Orders'),
        BottomNavigationBarItem(icon: Icon(Icons.edit,), label: 'Edit'),
        BottomNavigationBarItem(icon: Icon(CupertinoIcons.person,), label: 'Profile'),
      ]),

      //END OF BOTTOM NAVIGATION BAR


      body: _pages[pageIndex], //We want to access pages using our page index


    );
  }
}
