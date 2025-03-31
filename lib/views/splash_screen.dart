//
//
// import 'package:flutter/material.dart';
// import 'package:reto_radiance/controllers/auth_controller.dart';
// import 'package:reto_radiance/views/screens/authentication_screens/login_screen.dart';
// import 'package:reto_radiance/views/screens/main_screen.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});
//
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> {
//   bool _isDisposed = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _goHome();
//   }
//
//   @override
//   void dispose() {
//     _isDisposed = true;
//     super.dispose();
//   }
//
//   _goHome() async {
//     await Future.delayed(const Duration(milliseconds: 3000), () {});
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? storedEmail = prefs.getString('email');
//     String? storedPassword = prefs.getString('password');
//
//     if (storedEmail != null && storedPassword != null) {
//       // Attempt auto-login
//       String res = await _authController.loginUser(storedEmail, storedPassword);
//       if (res == 'Success' && mounted && !_isDisposed) {
//         // Navigate to main screen
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => MainScreen()),
//         );
//       } else if (mounted && !_isDisposed) {
//         // Handle auto-login failure (e.g., token expired)
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => LoginScreen()),
//         );
//         print('Auto-login failed: $res');
//       }
//     } else if (mounted && !_isDisposed) {
//       // Navigate to login screen if no stored credentials
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => LoginScreen()),
//       );
//     }
//   }
//
//   final AuthController _authController = AuthController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Image.asset('assets/images/gif1.gif'),
//       ),
//     );
//   }
// }

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reto_radiance/controllers/auth_controller.dart';
import 'package:reto_radiance/views/screens/authentication_screens/login_screen.dart';
import 'package:reto_radiance/views/screens/main_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isDisposed = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _goHome();
  }

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  // _goHome() async {
  //   await Future.delayed(const Duration(milliseconds: 3000), () {});
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? storedEmail = prefs.getString('email');
  //   String? storedPassword = prefs.getString('password');

  //   if (storedEmail != null && storedPassword != null) {
  //     // Attempt auto-login
  //     String res = await _authController.loginUser(storedEmail, storedPassword);
  //     if (res == 'Success' && mounted && !_isDisposed) {
  //       // Navigate to main screen
  //       Navigator.pushReplacement(
  //         context,
  //         MaterialPageRoute(builder: (context) => MainScreen()),
  //       );
  //     } else if (mounted && !_isDisposed) {
  //       // Handle auto-login failure (e.g., token expired)
  //       Navigator.pushReplacement(
  //         context,
  //         MaterialPageRoute(builder: (context) => LoginScreen()),
  //       );
  //       print('Auto-login failed: $res');
  //     }
  //   } else if (mounted && !_isDisposed) {
  //     // Navigate to login screen if no stored credentials
  //     Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(builder: (context) => LoginScreen()),
  //     );
  //   }
  // }

  // _goHome() async {
  //   await Future.delayed(const Duration(milliseconds: 3000), () {});
  //   await _auth.currentUser?.reload();
  //   User? user = _auth.currentUser;

  //   if (user != null) {
  //     // User is signed in
  //     if (mounted && !_isDisposed) {
  //       Navigator.pushAndRemoveUntil(
  //         context,
  //         MaterialPageRoute(builder: (context) => MainScreen(index: 1,)),
  //         (route) => false,
  //       );
  //     }
  //   } else {
  //     // No user is signed in, check for stored credentials
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     String? storedEmail = prefs.getString('email');
  //     String? storedPassword = prefs.getString('password');

  //     if (storedEmail != null && storedPassword != null) {
  //       // Attempt auto-login
  //       String res = await _authController.loginUser(storedEmail, storedPassword);
  //       if (res == 'Success' && mounted && !_isDisposed) {
  //         // Navigate to main screen
  //         Navigator.pushAndRemoveUntil(
  //           context,
  //           MaterialPageRoute(builder: (context) => MainScreen(index: 1)),
  //           (route) => false,
  //         );
  //       } else if (mounted && !_isDisposed) {
  //         // Handle auto-login failure (e.g., token expired)
  //         Navigator.pushReplacement(
  //           context,
  //           MaterialPageRoute(builder: (context) => LoginScreen()),
  //         );
  //         print('Auto-login failed: $res');
  //       }
  //     } else if (mounted && !_isDisposed) {
  //       // Navigate to login screen if no stored credentials
  //       Navigator.pushReplacement(
  //         context,
  //         MaterialPageRoute(builder: (context) => LoginScreen()),
  //       );
  //     }
  //   }
  // }

  _goHome() async {
    await Future.delayed(const Duration(milliseconds: 3000), () {});
    await _auth.currentUser?.reload();
    User? user = _auth.currentUser;

    if (mounted && !_isDisposed) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => MainScreen(index: 1)),
        (route) => false,
      );
    }
  }

  final AuthController _authController = AuthController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Image.asset('assets/images/gif1.gif')));
  }
}
// import 'package:flutter/material.dart';
