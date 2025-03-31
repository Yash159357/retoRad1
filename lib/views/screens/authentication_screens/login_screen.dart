//
//
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:reto_radiance/controllers/auth_controller.dart';
// import 'package:reto_radiance/vendor/views/auth/vendor_login_screen.dart';
// import 'package:reto_radiance/views/screens/authentication_screens/register_screen.dart';
// import 'package:reto_radiance/views/screens/main_screen.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class LoginScreen extends StatefulWidget {
//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   @override
//   void initState() {
//     super.initState();
//     // _checkLoginStatus();
//   }
//
//   // _checkLoginStatus() async {
//   //   SharedPreferences prefs = await SharedPreferences.getInstance();
//   //   String? storedEmail = prefs.getString('email');
//   //   String? storedPassword = prefs.getString('password');
//
//   //   if (storedEmail != null && storedPassword != null) {
//   //     // Attempt auto-login
//   //     String res = await _authController.loginUser(storedEmail, storedPassword);
//   //     if (res == 'Success') {
//   //       // Navigate to main screen
//   //       Navigator.pushReplacement(
//   //         context,
//   //         MaterialPageRoute(builder: (context) => MainScreen()),
//   //       );
//   //     } else {
//   //       // Handle auto-login failure (e.g., token expired)
//   //       print('Auto-login failed: $res');
//   //     }
//   //   }
//   // }
//
//   loginUser() async {
//     setState(() {
//       _isLoading = true;
//     });
//
//     String res = await _authController.loginUser(email, password);
//
//     if (res == 'Success') {
//       // Store credentials
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       await prefs.setString('email', email);
//       await prefs.setString('password', password);
//
//       // Navigate to main screen
//       Future.delayed(Duration.zero, () {
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => MainScreen()),
//         );
//         ScaffoldMessenger.of(
//           context,
//         ).showSnackBar(const SnackBar(content: Text('Logged IN Successfully')));
//       });
//     } else {
//       setState(() {
//         _isLoading = false;
//       });
//
//       Future.delayed(Duration.zero, () {
//         ScaffoldMessenger.of(
//           context,
//         ).showSnackBar(SnackBar(content: Text(res)));
//       });
//     }
//   }
//
//   //const LoginScreen({super.key});
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   //'GlobalKey' is used to make the key global. 'FormState' is used to get the current state of the form. '_' is used in '_formKey' so that to make this variable private, i.e, it cannot be used or referred outside the Register Screen class.
//
//   final AuthController _authController = AuthController();
//
//   bool _isLoading = false;
//
//   bool _isObscure = true;
//
//   //'late' is used when we will be assigning value to a variable later
//   late String email;
//
//   late String password;
//
//   // loginUser() async {
//   //   setState(() {
//   //     _isLoading =
//   //         true; //Same process we are following as we followed in Register Screen Circular Progress Bar
//   //   });
//
//   //   String res = await _authController.loginUser(email, password);
//
//   //   if (res == 'Success') {
//   //     // print('Logged IN');
//
//   //     //Go to Main Screen
//   //     Future.delayed(Duration.zero, () {
//   //       Navigator.push(
//   //         context,
//   //         MaterialPageRoute(
//   //           builder: (context) {
//   //             return MainScreen(); //Going to Main Screen if LOGIN is successful
//   //           },
//   //         ),
//   //       );
//
//   //       //We want to show a message to the user that he/she has LOGGED IN Successfully
//   //       ScaffoldMessenger.of(
//   //         context,
//   //       ).showSnackBar(const SnackBar(content: Text('Logged IN Successfully')));
//   //     });
//   //   } else {
//   //     // print(res);
//
//   //     setState(() {
//   //       _isLoading = false; //If LOGIN is unsuccessful
//   //     });
//
//   //     Future.delayed(Duration.zero, () {
//   //       ScaffoldMessenger.of(context).showSnackBar(
//   //         SnackBar(content: Text(res)),
//   //       ); //Showing the Error Message that why Login has failed.
//   //     });
//   //   }
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       //Everything is contained inside the Scaffold Widget so in order to change Background color of Screen just change the color of Scaffold Widget like it is done in the next Line.
//
//       // backgroundColor: Colors.white.withOpacity(0.95), //Background color of entire screen with Opacity to make it a little dark
//       backgroundColor: Color(0xFFF6D0FA),
//
//       // backgroundColor: const LinearGradient(colors: [Color(0xFFfffae4),Color(0xFFffb78b),],),
//       body: Padding(
//         //Wrapped 'Center' (which is our body) with 'Padding' in order to give spaces in all directions that is overall spaces from all outer sides
//         padding: const EdgeInsets.all(15.0),
//         child: Center(
//           //Wrapped Column Widget with Center now it will place all the components inside Column to the center of the screen
//           child: SingleChildScrollView(
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     //LOGIN Text
//                     "RadianceLOGIN",
//                     style: GoogleFonts.getFont(
//                       'Lexend',
//                       color: Color(0xFF0d120E),
//                       fontWeight: FontWeight.bold,
//                       letterSpacing: 1,
//                       fontSize: 30,
//                     ),
//                   ),
//
//                   const SizedBox(
//                     //Sized Box is used to give spacings between 2 components or 2 Widgets
//                     height: 8,
//                   ),
//
//                   Text(
//                     //TAGLINE Text
//                     "Handcrafted with Love,  Delivered with Purpose",
//                     style: GoogleFonts.getFont(
//                       'Roboto',
//                       color: Color(0xFF0d120E),
//                       fontWeight: FontWeight.w500,
//                       letterSpacing: 0,
//                       fontSize: 14,
//                     ),
//                   ),
//
//                   const SizedBox(
//                     //Sized Box is used to give spacings between 2 components or Widgets
//                     height: 0,
//                   ),
//
//                   Image.asset(
//                     //LOGIN BRAND Image
//                     'assets/images/BcglessLogo.png',
//                     width: 250,
//                     height: 250,
//                   ),
//
//                   const SizedBox(
//                     //Sized Box is used to give spacings between 2 components or Widgets
//                     height: 5,
//                   ),
//
//                   //
//                   //Email Section
//                   //
//
//                   // Align(  //To Align the 'Email' Text to go Left and not from the Center
//                   //   alignment: Alignment.topLeft,
//                   //   child: Text(
//                   //     "Email",
//                   //     style: GoogleFonts.getFont(
//                   //       'Nunito Sans',
//                   //       color: Color(0xFF0d120E),
//                   //       fontWeight: FontWeight.w600,
//                   //       letterSpacing: 0.2,
//                   //       fontSize: 16,
//                   //     ),
//                   //   ),
//                   // ),
//
//                   //Place or Input Box where the User will write his/her Mail ID
//                   TextFormField(
//                     onChanged: (value) {
//                       //This will take the actual value inputted by the user in the Input Box
//                       email = value.trim(); //Assigning that value to our variable
//                     },
//                     validator: (value) {
//                       if (value!.trim().isEmpty) {
//                         //If the user has not filled anything in this input box
//                         return 'Enter Your Email';
//                       } else {
//                         return null;
//                       }
//                     },
//                     decoration: InputDecoration(
//                       fillColor: Colors.white,
//                       filled: true,
//                       border: OutlineInputBorder(
//                         //borderSide: BorderSide.none,
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//
//                       // focusedBorder: InputBorder.none,
//                       // enabledBorder: InputBorder.none,
//                       labelText:
//                       'Enter Your Email', //Text which will be shown to user as instruction or information that what to write in the Input Box
//                       labelStyle: GoogleFonts.getFont(
//                         "Nunito Sans",
//                         fontSize: 14,
//                         letterSpacing: 0.2,
//                       ),
//
//                       //Icon which will be shown in the Email Text Box
//                       prefixIcon: Padding(
//                         //Wrapped 'Image' with 'Padding' in order to give spaces in all directions
//                         padding: const EdgeInsets.all(10.0),
//                         child: Image.asset(
//                           'assets/icons/email.png',
//                           width: 20,
//                           height: 20,
//                           color: Color(0xffb832f6),
//                         ),
//                       ),
//                     ),
//                   ),
//
//                   const SizedBox(
//                     //Sized Box is used to give spacings between 2 components or Widgets
//                     height: 20,
//                   ),
//
//                   //
//                   //Password Section
//                   //
//
//                   // Align(  //To Align the 'Email' Text to go Left and not from the Center
//                   //   alignment: Alignment.topLeft,
//                   //   child: Text(
//                   //     "Password",
//                   //     style: GoogleFonts.getFont(
//                   //       'Nunito Sans',
//                   //       color: Color(0xFF0d120E),
//                   //       fontWeight: FontWeight.w600,
//                   //       letterSpacing: 0.2,
//                   //       fontSize: 16,
//                   //     ),
//                   //   ),
//                   // ),
//
//                   //Place or Input Box where the User will write his/her Password
//                   TextFormField(
//                     obscureText:
//                     _isObscure, //This will hide and show according to the bool value of our _isObscure
//                     onChanged: (value) {
//                       //This will take the actual value inputted by the user in the Input Box
//                       password = value.trim(); //Assigning that value to our variable
//                     },
//                     validator: (value) {
//                       if (value!.trim().isEmpty) {
//                         //If the user has not filled anything in this input box
//                         return 'Please Enter Your Password';
//                       } else {
//                         return null;
//                       }
//                     },
//                     decoration: InputDecoration(
//                       fillColor: Colors.white,
//                       filled: true,
//                       border: OutlineInputBorder(
//                         //borderSide: BorderSide.none,
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//
//                       // focusedBorder: InputBorder.none,
//                       // enabledBorder: InputBorder.none,
//                       labelText:
//                       'Enter Your Password', //Text which will be shown to user as instruction or information that what to write in the Input Box
//                       labelStyle: GoogleFonts.getFont(
//                         "Nunito Sans",
//                         fontSize: 14,
//                         letterSpacing: 0.2,
//                       ),
//
//                       //Icon which will be shown in the Email Text Box
//                       prefixIcon: Padding(
//                         //Wrapped 'Image' with 'Padding' in order to give spaces in all directions
//                         padding: const EdgeInsets.all(10.0),
//                         child: Image.asset(
//                           'assets/icons/password.png',
//                           width: 20,
//                           height: 20,
//                           color: Color(0xffb832f6),
//                         ),
//                       ),
//
//                       //suffixIcon: Icon(Icons.visibility), //'Eye' Icon in Password. With Icon Widget we can also get many ready made Icons for use.
//                       suffixIcon: IconButton(
//                         //Now we are making our Eye Button Clickable and hence it will hide and show the password respectively.
//                         onPressed: () {
//                           setState(() {
//                             //Main Function of this: Whenever we click on Eye button, _isObscure will be true and again when we will click it will be false and this will keep on happening.
//                             _isObscure = !_isObscure;
//                           });
//                         },
//                         icon: Icon(
//                           _isObscure
//                               ? Icons.visibility_off
//                               : Icons
//                               .visibility, //If _isObscure is true then Eye will be shown if it is false then Eye Cross button will be shown.
//                           color: Color(0xffb832f6),
//                         ),
//                       ),
//                     ),
//                   ),
//
//                   const SizedBox(
//                     //Sized Box is used to give spacings between 2 components or Widgets
//                     height: 30,
//                   ),
//
//                   //LOGIN Button
//                   InkWell(
//                     onTap: () {
//                       //On clicking our 'LOGIN' button it will check our Form is Filled or Validated or not
//                       if (_formKey.currentState!.validate()) {
//                         //Checking the current state of our Form by accessing our '_formKey' variable and whether it is validated or not.
//                         //If our Form is Validated
//                         loginUser();
//                       } else {
//                         print('Failed'); //If our Form is not Validated
//                       }
//                     },
//                     child: Container(
//                       // width: 319,
//                       width: 270,
//                       height: 50,
//                       decoration: BoxDecoration(
//                         border: Border.all(color: Colors.black),
//                         borderRadius: BorderRadius.circular(40),
//                         // gradient: const LinearGradient(
//                         //     colors: [Color(0xFF102DE1),Color(0xCC0D6EFF,),],
//                         // ),
//                         color: Color(0xffb832f6),
//                       ),
//
//                       child: Center(
//                         //Wrapped Text Widget with Center now it will place this text component inside 'Container' Widget to the center of the 'Container' Widget
//                         child:
//                         _isLoading
//                             ? CircularProgressIndicator(color: Colors.white)
//                             : Text(
//                           'LOGIN',
//                           style: GoogleFonts.getFont(
//                             'Lexend',
//                             fontSize: 25,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white,
//                             letterSpacing: 3,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ), //END of Login Button
//
//                   const SizedBox(height: 5),
//
//                   Text(
//                     'OR,',
//                     style: GoogleFonts.getFont(
//                       'Roboto',
//                       fontSize: 15,
//                       fontWeight: FontWeight.w500,
//                       color: Colors.black,
//                     ),
//                   ),
//
//                   const SizedBox(height: 5),
//
//                   //SIGN IN with Google Button
//                   InkWell(
//                     onTap: () {},
//
//                     child: Container(
//                       width: 270,
//                       height: 50,
//                       decoration: BoxDecoration(
//                         border: Border.all(color: Colors.black),
//                         borderRadius: BorderRadius.circular(40),
//                         // gradient: const LinearGradient(
//                         //     colors: [Color(0xFF102DE1),Color(0xCC0D6EFF,),],
//                         // ),
//                         // color: Color(0xFFf58634),
//                         color: Colors.white,
//                       ),
//
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//
//                         children: [
//                           Image.asset(
//                             'assets/images/GoogleLogo.png',
//                             width: 30,
//                             height: 30,
//                           ),
//
//                           //Comment IN the below line again when our this button is Functional and the Sign IN with Google Function is implemented.
//
//                           // _isLoading? CircularProgressIndicator(color: Color(0xFFf58634),) :   //This is our Circular Progress Bar Code which will appear when our sign in with google operation starts and will continue till it ends. Comment IN again when our this button is Functional and the Function is implemented.
//                           Text(
//                             'Sign IN',
//                             style: GoogleFonts.getFont(
//                               'Lexend',
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.black,
//                               letterSpacing: 3,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ), //END of Sign IN with Google Section
//
//                   const SizedBox(
//                     //Sized Box is used to give spacings between 2 components or Widgets
//                     height: 20,
//                   ),
//
//                   Row(
//                     //Like 'Column' Widget is used to place components Vertically, 'Row' Widget is used to place components horizontally
//                     mainAxisAlignment:
//                     MainAxisAlignment
//                         .center, //This will place the components at the center horizontally
//                     children: [
//                       Text(
//                         'Need an Account? ',
//                         style: GoogleFonts.getFont(
//                           'Roboto',
//                           fontSize: 17,
//                           fontWeight: FontWeight.w500,
//                           color: Colors.black,
//                         ),
//                       ),
//
//                       InkWell(
//                         //Wrapped SIGN UP 'Text' Widget with InkWell because we want 'SIGN UP' Text Widget to be clickable and 'InkWell' Widget has a property known as 'onTap' which makes our Text Widget to be clickable and when we click on it we will be directed to another page
//                         onTap: () {
//                           //In Flutter every page is known as Material Page
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) {
//                                 //This is the method to go to different screen
//                                 return RegisterScreen(); //Going to Register Screen when we click 'SIGN UP' Text Widget
//                               },
//                             ),
//                           );
//                         },
//                         child: Text(
//                           'SIGN UP',
//                           style: GoogleFonts.getFont(
//                             'Roboto',
//                             fontSize: 17,
//                             fontWeight: FontWeight.bold,
//                             color: Color(0xffb832f6),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//
//                   const SizedBox(height: 10), //To give horizontal spacing
//                   //
//                   //VENDORS WILL BE RENAMED TO ADMIN, IN FUTURE WE CAN RE-FRAME THE STRUCTURE IF WE NEED VENDOR'S ACCOUNT SEPARATELY.
//                   //
//                   //
//                   //ADMIN SECTION, NOW WILL REDIRECT TO SIGNUP BUT IN FUTURE WILL ONLY REDIRECT TO ADMIN LOGIN, NO SIGN UP.
//                   //
//                   //
//                   Row(
//                     //Like 'Column' Widget is used to place components Vertically, 'Row' Widget is used to place components horizontally
//                     mainAxisAlignment:
//                     MainAxisAlignment
//                         .center, //This will place the components at the center horizontally
//                     children: [
//                       //In future we will remove this and lots of changes
//                       // Text('Need an Admin Account? ',style: GoogleFonts.getFont(
//                       //   'Roboto',
//                       //   fontSize: 17,
//                       //   fontWeight: FontWeight.w500,
//                       //   color: Colors.black,),
//                       // ),
//
//                       //This will be changed to ADMIN LOGIN ONLY NO SIGN UP
//                       InkWell(
//                         //Wrapped SIGN UP 'Text' Widget with InkWell because we want 'SIGN UP' Text Widget to be clickable and 'InkWell' Widget has a property known as 'onTap' which makes our Text Widget to be clickable and when we click on it we will be directed to another page
//                         onTap: () {
//                           //In Flutter every page is known as Material Page
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) {
//                                 //This is the method to go to different screen
//                                 return VendorLoginScreen(); //Going to Register Screen when we click 'SIGN UP' Text Widget
//                               },
//                             ),
//                           );
//                         },
//                         child: Text(
//                           'ADMIN LOGIN',
//                           style: GoogleFonts.getFont(
//                             'Roboto',
//                             fontSize: 15,
//                             fontWeight: FontWeight.bold,
//                             color: Color(0xffb832f6),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reto_radiance/controllers/auth_controller.dart';
import 'package:reto_radiance/vendor/views/auth/vendor_login_screen.dart';
import 'package:reto_radiance/views/screens/authentication_screens/forgot_password.dart';
import 'package:reto_radiance/views/screens/authentication_screens/register_screen.dart';
import 'package:reto_radiance/views/screens/main_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  @override
  void initState() {
    super.initState();
    // _checkLoginStatus();
  }

  // _checkLoginStatus() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? storedEmail = prefs.getString('email');
  //   String? storedPassword = prefs.getString('password');

  //   if (storedEmail != null && storedPassword != null) {
  //     // Attempt auto-login
  //     String res = await _authController.loginUser(storedEmail, storedPassword);
  //     if (res == 'Success') {
  //       // Navigate to main screen
  //       Navigator.pushReplacement(
  //         context,
  //         MaterialPageRoute(builder: (context) => MainScreen()),
  //       );
  //     } else {
  //       // Handle auto-login failure (e.g., token expired)
  //       print('Auto-login failed: $res');
  //     }
  //   }
  // }

  loginUser() async {
    setState(() {
      _isLoading = true;
    });

    String res = await _authController.loginUser(email, password);

    if (res == 'Success') {
      // Store credentials
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('email', email);
      await prefs.setString('password', password);

      // Navigate to main screen
      Future.delayed(Duration.zero, () {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => MainScreen(index: 1)),
          (route) => false,
        );
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Logged IN Successfully')));
      });
    } else {
      setState(() {
        _isLoading = false;
      });

      Future.delayed(Duration.zero, () {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(res)));
      });
    }
  }

  //const LoginScreen({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  //'GlobalKey' is used to make the key global. 'FormState' is used to get the current state of the form. '_' is used in '_formKey' so that to make this variable private, i.e, it cannot be used or referred outside the Register Screen class.

  final AuthController _authController = AuthController();

  bool _isLoading = false;

  bool _isObscure = true;

  //'late' is used when we will be assigning value to a variable later
  late String email;

  late String password;

  // loginUser() async {
  //   setState(() {
  //     _isLoading =
  //         true; //Same process we are following as we followed in Register Screen Circular Progress Bar
  //   });

  //   String res = await _authController.loginUser(email, password);

  //   if (res == 'Success') {
  //     // print('Logged IN');

  //     //Go to Main Screen
  //     Future.delayed(Duration.zero, () {
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) {
  //             return MainScreen(); //Going to Main Screen if LOGIN is successful
  //           },
  //         ),
  //       );

  //       //We want to show a message to the user that he/she has LOGGED IN Successfully
  //       ScaffoldMessenger.of(
  //         context,
  //       ).showSnackBar(const SnackBar(content: Text('Logged IN Successfully')));
  //     });
  //   } else {
  //     // print(res);

  //     setState(() {
  //       _isLoading = false; //If LOGIN is unsuccessful
  //     });

  //     Future.delayed(Duration.zero, () {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text(res)),
  //       ); //Showing the Error Message that why Login has failed.
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Everything is contained inside the Scaffold Widget so in order to change Background color of Screen just change the color of Scaffold Widget like it is done in the next Line.

      // backgroundColor: Colors.white.withOpacity(0.95), //Background color of entire screen with Opacity to make it a little dark
      backgroundColor: Color(0xFFF6D0FA),

      // backgroundColor: const LinearGradient(colors: [Color(0xFFfffae4),Color(0xFFffb78b),],),
      body: Padding(
        //Wrapped 'Center' (which is our body) with 'Padding' in order to give spaces in all directions that is overall spaces from all outer sides
        padding: const EdgeInsets.all(15.0),
        child: Center(
          //Wrapped Column Widget with Center now it will place all the components inside Column to the center of the screen
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    //LOGIN Text
                    "RadianceLOGIN",
                    style: GoogleFonts.getFont(
                      'Lexend',
                      color: Color(0xFF0d120E),
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                      fontSize: 30,
                    ),
                  ),

                  const SizedBox(
                    //Sized Box is used to give spacings between 2 components or 2 Widgets
                    height: 8,
                  ),

                  Text(
                    //TAGLINE Text
                    "Handcrafted with Love,  Delivered with Purpose",
                    style: GoogleFonts.getFont(
                      'Roboto',
                      color: Color(0xFF0d120E),
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0,
                      fontSize: 14,
                    ),
                  ),

                  const SizedBox(
                    //Sized Box is used to give spacings between 2 components or Widgets
                    height: 0,
                  ),

                  Image.asset(
                    //LOGIN BRAND Image
                    'assets/images/BcglessLogo.png',
                    width: 250,
                    height: 250,
                  ),

                  const SizedBox(
                    //Sized Box is used to give spacings between 2 components or Widgets
                    height: 5,
                  ),

                  //
                  //Email Section
                  //

                  // Align(  //To Align the 'Email' Text to go Left and not from the Center
                  //   alignment: Alignment.topLeft,
                  //   child: Text(
                  //     "Email",
                  //     style: GoogleFonts.getFont(
                  //       'Nunito Sans',
                  //       color: Color(0xFF0d120E),
                  //       fontWeight: FontWeight.w600,
                  //       letterSpacing: 0.2,
                  //       fontSize: 16,
                  //     ),
                  //   ),
                  // ),

                  //Place or Input Box where the User will write his/her Mail ID
                  TextFormField(
                    onChanged: (value) {
                      //This will take the actual value inputted by the user in the Input Box
                      email =
                          value.trim(); //Assigning that value to our variable
                    },
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        //If the user has not filled anything in this input box
                        return 'Enter Your Email';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        //borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(20),
                      ),

                      // focusedBorder: InputBorder.none,
                      // enabledBorder: InputBorder.none,
                      labelText:
                          'Enter Your Email', //Text which will be shown to user as instruction or information that what to write in the Input Box
                      labelStyle: GoogleFonts.getFont(
                        "Nunito Sans",
                        fontSize: 14,
                        letterSpacing: 0.2,
                      ),

                      //Icon which will be shown in the Email Text Box
                      prefixIcon: Padding(
                        //Wrapped 'Image' with 'Padding' in order to give spaces in all directions
                        padding: const EdgeInsets.all(10.0),
                        child: Image.asset(
                          'assets/icons/email.png',
                          width: 20,
                          height: 20,
                          color: Color(0xffb832f6),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(
                    //Sized Box is used to give spacings between 2 components or Widgets
                    height: 20,
                  ),

                  //
                  //Password Section
                  //

                  // Align(  //To Align the 'Email' Text to go Left and not from the Center
                  //   alignment: Alignment.topLeft,
                  //   child: Text(
                  //     "Password",
                  //     style: GoogleFonts.getFont(
                  //       'Nunito Sans',
                  //       color: Color(0xFF0d120E),
                  //       fontWeight: FontWeight.w600,
                  //       letterSpacing: 0.2,
                  //       fontSize: 16,
                  //     ),
                  //   ),
                  // ),

                  //Place or Input Box where the User will write his/her Password
                  TextFormField(
                    obscureText:
                        _isObscure, //This will hide and show according to the bool value of our _isObscure
                    onChanged: (value) {
                      //This will take the actual value inputted by the user in the Input Box
                      password =
                          value.trim(); //Assigning that value to our variable
                    },
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        //If the user has not filled anything in this input box
                        return 'Please Enter Your Password';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        //borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(20),
                      ),

                      // focusedBorder: InputBorder.none,
                      // enabledBorder: InputBorder.none,
                      labelText:
                          'Enter Your Password', //Text which will be shown to user as instruction or information that what to write in the Input Box
                      labelStyle: GoogleFonts.getFont(
                        "Nunito Sans",
                        fontSize: 14,
                        letterSpacing: 0.2,
                      ),

                      //Icon which will be shown in the Email Text Box
                      prefixIcon: Padding(
                        //Wrapped 'Image' with 'Padding' in order to give spaces in all directions
                        padding: const EdgeInsets.all(10.0),
                        child: Image.asset(
                          'assets/icons/password.png',
                          width: 20,
                          height: 20,
                          color: Color(0xffb832f6),
                        ),
                      ),

                      //suffixIcon: Icon(Icons.visibility), //'Eye' Icon in Password. With Icon Widget we can also get many ready made Icons for use.
                      suffixIcon: IconButton(
                        //Now we are making our Eye Button Clickable and hence it will hide and show the password respectively.
                        onPressed: () {
                          setState(() {
                            //Main Function of this: Whenever we click on Eye button, _isObscure will be true and again when we will click it will be false and this will keep on happening.
                            _isObscure = !_isObscure;
                          });
                        },
                        icon: Icon(
                          _isObscure
                              ? Icons.visibility_off
                              : Icons
                                  .visibility, //If _isObscure is true then Eye will be shown if it is false then Eye Cross button will be shown.
                          color: Color(0xffb832f6),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(
                    //Sized Box is used to give spacings between 2 components or Widgets
                    height: 15,
                  ),

                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ForgotPasswordScreen(),
                          ),
                        );
                      },
                      child: Text('Forgot Password?'),
                    ),
                  ),
                  const SizedBox(height: 15),

                  //LOGIN Button
                  InkWell(
                    onTap: () {
                      //On clicking our 'LOGIN' button it will check our Form is Filled or Validated or not
                      if (_formKey.currentState!.validate()) {
                        //Checking the current state of our Form by accessing our '_formKey' variable and whether it is validated or not.
                        //If our Form is Validated
                        loginUser();
                      } else {
                        print('Failed'); //If our Form is not Validated
                      }
                    },
                    child: Container(
                      // width: 319,
                      width: 270,
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(40),
                        // gradient: const LinearGradient(
                        //     colors: [Color(0xFF102DE1),Color(0xCC0D6EFF,),],
                        // ),
                        color: Color(0xffb832f6),
                      ),

                      child: Center(
                        //Wrapped Text Widget with Center now it will place this text component inside 'Container' Widget to the center of the 'Container' Widget
                        child:
                            _isLoading
                                ? CircularProgressIndicator(color: Colors.white)
                                : Text(
                                  'LOGIN',
                                  style: GoogleFonts.getFont(
                                    'Lexend',
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    letterSpacing: 3,
                                  ),
                                ),
                      ),
                    ),
                  ), //END of Login Button

                  const SizedBox(height: 5),

                  Text(
                    'OR,',
                    style: GoogleFonts.getFont(
                      'Roboto',
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),

                  const SizedBox(height: 5),

                  //SIGN IN with Google Button
                  InkWell(
                    onTap: () async {
                      String res = await _authController.loginWithGoogle();

                      if (res == 'Success') {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MainScreen(index: 1),
                          ),
                          (route) => false,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Logged in with Google successfully'),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text(res)));
                      }
                    }, //This is the method which will be called when we click on this button

                    child: Container(
                      width: 270,
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(40),
                        // gradient: const LinearGradient(
                        //     colors: [Color(0xFF102DE1),Color(0xCC0D6EFF,),],
                        // ),
                        // color: Color(0xFFf58634),
                        color: Colors.white,
                      ),

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: [
                          Image.asset(
                            'assets/images/GoogleLogo.png',
                            width: 30,
                            height: 30,
                          ),

                          //Comment IN the below line again when our this button is Functional and the Sign IN with Google Function is implemented.
                          SizedBox(width: 10),
                          // _isLoading? CircularProgressIndicator(color: Color(0xFFf58634),) :   //This is our Circular Progress Bar Code which will appear when our sign in with google operation starts and will continue till it ends. Comment IN again when our this button is Functional and the Function is implemented.
                          Text(
                            'Sign In',
                            style: GoogleFonts.getFont(
                              'Lexend',
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              letterSpacing: 2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ), //END of Sign IN with Google Section

                  const SizedBox(
                    //Sized Box is used to give spacings between 2 components or Widgets
                    height: 20,
                  ),

                  Row(
                    //Like 'Column' Widget is used to place components Vertically, 'Row' Widget is used to place components horizontally
                    mainAxisAlignment:
                        MainAxisAlignment
                            .center, //This will place the components at the center horizontally
                    children: [
                      Text(
                        'Need an Account? ',
                        style: GoogleFonts.getFont(
                          'Roboto',
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),

                      InkWell(
                        //Wrapped SIGN UP 'Text' Widget with InkWell because we want 'SIGN UP' Text Widget to be clickable and 'InkWell' Widget has a property known as 'onTap' which makes our Text Widget to be clickable and when we click on it we will be directed to another page
                        onTap: () {
                          //In Flutter every page is known as Material Page
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                //This is the method to go to different screen
                                return RegisterScreen(); //Going to Register Screen when we click 'SIGN UP' Text Widget
                              },
                            ),
                          );
                        },
                        child: Text(
                          'SIGN UP',
                          style: GoogleFonts.getFont(
                            'Roboto',
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Color(0xffb832f6),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10), //To give horizontal spacing
                  //
                  //VENDORS WILL BE RENAMED TO ADMIN, IN FUTURE WE CAN RE-FRAME THE STRUCTURE IF WE NEED VENDOR'S ACCOUNT SEPARATELY.
                  //
                  //
                  //ADMIN SECTION, NOW WILL REDIRECT TO SIGNUP BUT IN FUTURE WILL ONLY REDIRECT TO ADMIN LOGIN, NO SIGN UP.
                  //
                  //
                  Row(
                    //Like 'Column' Widget is used to place components Vertically, 'Row' Widget is used to place components horizontally
                    mainAxisAlignment:
                        MainAxisAlignment
                            .center, //This will place the components at the center horizontally
                    children: [
                      //In future we will remove this and lots of changes
                      // Text('Need an Admin Account? ',style: GoogleFonts.getFont(
                      //   'Roboto',
                      //   fontSize: 17,
                      //   fontWeight: FontWeight.w500,
                      //   color: Colors.black,),
                      // ),

                      //This will be changed to ADMIN LOGIN ONLY NO SIGN UP
                      InkWell(
                        //Wrapped SIGN UP 'Text' Widget with InkWell because we want 'SIGN UP' Text Widget to be clickable and 'InkWell' Widget has a property known as 'onTap' which makes our Text Widget to be clickable and when we click on it we will be directed to another page
                        onTap: () {
                          //In Flutter every page is known as Material Page
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                //This is the method to go to different screen
                                return VendorLoginScreen(); //Going to Register Screen when we click 'SIGN UP' Text Widget
                              },
                            ),
                          );
                        },
                        child: Text(
                          'ADMIN LOGIN',
                          style: GoogleFonts.getFont(
                            'Roboto',
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color(0xffb832f6),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
