import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:reto_radiance/views/screens/nav_screens/about_screen.dart';
import 'package:reto_radiance/views/screens/nav_screens/account_screen.dart';
import 'package:reto_radiance/views/screens/nav_screens/cart_screen.dart';
import 'package:reto_radiance/views/screens/nav_screens/favourite_screen.dart';
import 'package:reto_radiance/views/screens/nav_screens/home_screen.dart';
import 'package:reto_radiance/views/screens/navbar_key.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key, required this.index});
  final int index;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;

  final screen = [
    HomeScreen(),
    FavouriteScreen(),
    AboutScreen(),
    CartScreen(),
    AccountScreen(),
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedIndex = widget.index - 1; 
    // acounting for 1 based indexing conversion to 0 based indexing do not remove -1
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: const Color.fromARGB(
          255,
          221,
          160,
          221,
        ), // Background color above the bar
        // Active button color
        index: selectedIndex,
        // key: NavbarKey.getKey(),
        items: [
          Icon(Icons.home, size: 30),
          Icon(Icons.favorite, size: 30),
          // Icon(Icons.messenger, size: 30),
          Image.asset('assets/images/BcglessLogo.png', height: 70, width: 70),
          Icon(Icons.shopping_cart, size: 30),
          Icon(Icons.person, size: 30),
        ],
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        animationCurve: Curves.easeInBack,
        animationDuration: Duration(milliseconds: 300),
      ),
      body: screen[selectedIndex],
    );
  }
}
