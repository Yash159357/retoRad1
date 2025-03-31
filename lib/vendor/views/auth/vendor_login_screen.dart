//
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:reto_radiance/vendor/controllers/vendor_controller.dart';
// import 'package:reto_radiance/vendor/views/auth/vendor_register_screen.dart';
// import 'package:reto_radiance/vendor/views/screens/main_vendor_screen.dart';
// import 'package:reto_radiance/views/screens/authentication_screens/login_screen.dart';
//
// class VendorLoginScreen extends StatefulWidget {
//   @override
//   State<VendorLoginScreen> createState() => _VendorLoginScreenState();
// }
//
// class _VendorLoginScreenState extends State<VendorLoginScreen> {
//   //const VendorLoginScreen({super.key});
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); //'GlobalKey' is used to make the key global. 'FormState' is used to get the current state of the form. '_' is used in '_formKey' so that to make this variable private, i.e, it cannot be used or referred outside the Register Screen class.
//   final VendorAuthController _authController = VendorAuthController();
//
//   bool _isLoading = false;
//   bool _isObscure = true;
//
//   late String email; //'late' is used when we will be assigning value to a variable later
//   late String password;
//
//
//   //Login User Function
//   loginUser()async {
//
//     setState(() {
//       _isLoading = true; //Same process we are following as we followed in Register Screen Circular Progress Bar
//     });
//
//     String res = await _authController.loginUser(email, password);
//
//     if(res == 'Success'){
//
//       // print('Logged IN');
//
//       //Go to Main Vendor Screen
//       Future.delayed(Duration.zero,()
//       {
//         Navigator.push(context, MaterialPageRoute(builder: (context) {
//           return const MainVendorScreen();  //Going to Main Screen if LOGIN is successful
//         }));
//
//         //We want to show a message to the user that he/she has LOGGED IN Successfully
//         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Logged IN Successfully')));
//
//       });
//
//     } else {
//       // print(res);
//
//       setState(() {
//         _isLoading = false; //If LOGIN is unsuccessful
//       });
//
//       Future.delayed(Duration.zero, () {
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(res))); //Showing the Error Message that why Login has failed.
//       });
//
//     }
//
//   } //END of Login User Function
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold( //Everything is contained inside the Scaffold Widget so in order to change Background color of Screen just change the color of Scaffold Widget like it is done in the next Line.
//
//       backgroundColor: Colors.white.withOpacity(0.95), //Background color of entire screen with Opacity to make it a little dark
//
//       body: Padding( //Wrapped 'Center' (which is our body) with 'Padding' in order to give spaces in all directions that is overall spaces from all outer sides
//         padding: const EdgeInsets.all(10.0),
//         child: Center( //Wrapped Column Widget with Center now it will place all the components inside Column to the center of the screen
//           child: SingleChildScrollView(
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(  //LOGIN Text
//                     "RetoADMIN Login",
//                     style: GoogleFonts.getFont(
//                       'Lato',
//                       color: Color(0xFF0d120E),
//                       fontWeight: FontWeight.bold,
//                       letterSpacing: 2,
//                       fontSize: 23,
//                     ),
//                   ),
//
//                   const SizedBox( //Sized Box is used to give spacings between 2 components or 2 Widgets
//                     height: 8,
//                   ),
//
//                   Text(  //TAGLINE Text
//                     "Handcrafted with Love,  Delivered with Purpose",
//                     style: GoogleFonts.getFont(
//                       'Lato',
//                       color: Color(0xFF0d120E),
//                       fontWeight: FontWeight.bold,
//                       letterSpacing: 0.2,
//                       fontSize: 14,
//                     ),
//                   ),
//
//                   const SizedBox( //Sized Box is used to give spacings between 2 components or Widgets
//                     height: 40,
//                   ),
//
//                   Image.asset( //LOGIN BRAND Image
//                     'assets/images/RetoCircular.png',
//                     width: 200,
//                     height: 200,
//                   ),
//
//                   const SizedBox( //Sized Box is used to give spacings between 2 components or Widgets
//                     height: 40,
//                   ),
//
//
//                   //Email Section
//                   Align(  //To Align the 'Email' Text to go Left and not from the Center
//                     alignment: Alignment.topLeft,
//                     child: Text(
//                       "Email",
//                       style: GoogleFonts.getFont(
//                         'Nunito Sans',
//                         color: Color(0xFF0d120E),
//                         fontWeight: FontWeight.w600,
//                         letterSpacing: 0.2,
//                         fontSize: 16,
//                       ),
//                     ),
//                   ),
//
//
//                   //Place or Input Box where the User will write his/her Mail ID
//                   TextFormField(
//                     onChanged: (value) { //This will take the actual value inputted by the user in the Input Box
//                       email = value; //Assigning that value to our variable
//                     },
//                     validator: (value) {
//                       if (value!.isEmpty) { //If the user has not filled anything in this input box
//                         return 'Enter Your Email';
//                       }
//                       else {
//                         return null;
//                       }
//                     },
//                     decoration: InputDecoration(
//                         fillColor: Colors.white,
//                         filled: true,
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(9),
//                         ),
//
//                         focusedBorder: InputBorder.none,
//                         enabledBorder: InputBorder.none,
//                         labelText: 'Enter Your Email', //Text which will be shown to user as instruction or information that what to write in the Input Box
//                         labelStyle: GoogleFonts.getFont(
//                           "Nunito Sans",
//                           fontSize: 14,
//                           letterSpacing: 0.2,
//                         ),
//
//
//                         //Icon which will be shown in the Email Text Box
//                         prefixIcon: Padding( //Wrapped 'Image' with 'Padding' in order to give spaces in all directions
//                           padding: const EdgeInsets.all(10.0),
//                           child: Image.asset('assets/icons/email.png',
//                             width: 20,
//                             height: 20,
//                           ),
//                         )
//
//                     ),
//                   ),
//
//
//
//                   const SizedBox( //Sized Box is used to give spacings between 2 components or Widgets
//                     height: 20,
//                   ),
//
//
//
//                   //Password Section
//                   Align(  //To Align the 'Email' Text to go Left and not from the Center
//                     alignment: Alignment.topLeft,
//                     child: Text(
//                       "Password",
//                       style: GoogleFonts.getFont(
//                         'Nunito Sans',
//                         color: Color(0xFF0d120E),
//                         fontWeight: FontWeight.w600,
//                         letterSpacing: 0.2,
//                         fontSize: 16,
//                       ),
//                     ),
//                   ),
//
//
//                   //Place or Input Box where the User will write his/her Password
//                   TextFormField(
//                     obscureText: _isObscure, //This will hide and show according to the bool value of our _isObscure
//                     onChanged: (value) { //This will take the actual value inputted by the user in the Input Box
//                       password = value; //Assigning that value to our variable
//                     },
//                     validator: (value) {
//                       if (value!.isEmpty) { //If the user has not filled anything in this input box
//                         return 'Please Enter Your Password';
//                       }
//                       else {
//                         return null;
//                       }
//                     },
//                     decoration: InputDecoration(
//                       fillColor: Colors.white,
//                       filled: true,
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(9),
//                       ),
//
//                       focusedBorder: InputBorder.none,
//                       enabledBorder: InputBorder.none,
//                       labelText: 'Enter Your Password', //Text which will be shown to user as instruction or information that what to write in the Input Box
//                       labelStyle: GoogleFonts.getFont(
//                         "Nunito Sans",
//                         fontSize: 14,
//                         letterSpacing: 0.2,
//                       ),
//
//
//                       //Icon which will be shown in the Email Text Box
//                       prefixIcon: Padding( //Wrapped 'Image' with 'Padding' in order to give spaces in all directions
//                         padding: const EdgeInsets.all(10.0),
//                         child: Image.asset('assets/icons/password.png',
//                           width: 20,
//                           height: 20,
//                         ),
//                       ),
//
//                       //suffixIcon: Icon(Icons.visibility), //'Eye' Icon in Password. With Icon Widget we can also get many ready made Icons for use.
//
//                       suffixIcon: IconButton( //Now we are making our Eye Button Clickable and hence it will hide and show the password respectively.
//                         onPressed: () {
//                           setState(() { //Main Function of this: Whenever we click on Eye button, _isObscure will be true and again when we will click it will be false and this will keep on happening.
//                             _isObscure = ! _isObscure;
//                           });
//                         },
//                         icon: Icon(
//                           _isObscure ? Icons.visibility : Icons.visibility_off, //If _isObscure is true then Eye will be shown if it is false then Eye Cross button will be shown.
//                         ),
//                       ),
//
//                     ),
//                   ),
//
//                   const SizedBox( //Sized Box is used to give spacings between 2 components or Widgets
//                     height: 30,
//                   ),
//
//
//                   //LOGIN Button
//                   InkWell(
//                     onTap: () { //On clicking our 'LOGIN' button it will check our Form is Filled or Validated or not
//                       if (_formKey.currentState!.validate()) { //Checking the current state of our Form by accessing our '_formKey' variable and whether it is validated or not.
//                         //If our Form is Validated
//                         loginUser();
//                       }
//                       else {
//                         print('Failed'); //If our Form is not Validated
//                       }
//                     },
//                     child: Container(
//                       width: 319,
//                       height: 50,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(40),
//                         gradient: const LinearGradient(
//                           colors: [Color(0xFF102DE1),Color(0xCC0D6EFF,),],
//                         ),
//                       ),
//
//                       child: Center( //Wrapped Text Widget with Center now it will place this text component inside 'Container' Widget to the center of the 'Container' Widget
//                         child: _isLoading? CircularProgressIndicator(color: Colors.white,) : Text(
//                           'LOGIN',
//                           style: GoogleFonts.getFont(
//                             'Lato',
//                             fontSize: 17,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//
//                     ),
//                   ),
//
//
//
//                   const SizedBox( //Sized Box is used to give spacings between 2 components or Widgets
//                     height: 20,
//                   ),
//
//
//
//                   Row( //Like 'Column' Widget is used to place components Vertically, 'Row' Widget is used to place components horizontally
//                     mainAxisAlignment: MainAxisAlignment.center, //This will place the components at the center horizontally
//                     children: [
//                       Text('Login to Customer Account? ',style: GoogleFonts.getFont(
//                         'Roboto',
//                         fontSize: 17,
//                         fontWeight: FontWeight.w500,
//                         color: Colors.black,),
//                       ),
//
//
//                       InkWell( //Wrapped SIGN UP 'Text' Widget with InkWell because we want 'SIGN UP' Text Widget to be clickable and 'InkWell' Widget has a property known as 'onTap' which makes our Text Widget to be clickable and when we click on it we will be directed to another page
//                         onTap: (){ //In Flutter every page is known as Material Page
//                           Navigator.push(context, MaterialPageRoute(builder: (context){  //This is the method to go to different screen
//                             return LoginScreen(); //Going to Register Screen when we click 'SIGN UP' Text Widget
//                           }));
//                         },
//                         child: Text('SIGN IN',style: GoogleFonts.getFont(
//                           'Roboto',
//                           fontSize: 17,
//                           fontWeight: FontWeight.bold,
//                           color: Color(0xFF103DE5),),
//                         ),
//                       ),
//                     ],
//                   ),
//
//                   const SizedBox(height: 10,), //To give horizontal spacing
//
//
//                   //
//                   //VENDORS WILL BE RENAMED TO ADMIN, IN FUTURE WE CAN RE-FRAME THE STRUCTURE IF WE NEED VENDOR'S ACCOUNT SEPARATELY.
//                   //
//                   //
//                   //ADMIN SECTION, NOW WILL REDIRECT TO SIGNUP BUT IN FUTURE WILL ONLY REDIRECT TO ADMIN LOGIN, NO SIGN UP.
//                   //
//                   //
//
//                   Row( //Like 'Column' Widget is used to place components Vertically, 'Row' Widget is used to place components horizontally
//                     mainAxisAlignment: MainAxisAlignment.center, //This will place the components at the center horizontally
//                     children: [
//
//                       //In future we will remove this and lots of changes
//                       Text('Need an Admin Account? ',style: GoogleFonts.getFont(
//                         'Roboto',
//                         fontSize: 17,
//                         fontWeight: FontWeight.w500,
//                         color: Colors.black,),
//                       ),
//
//
//                       //This will be changed to ADMIN LOGIN ONLY NO SIGN UP
//                       InkWell( //Wrapped SIGN UP 'Text' Widget with InkWell because we want 'SIGN UP' Text Widget to be clickable and 'InkWell' Widget has a property known as 'onTap' which makes our Text Widget to be clickable and when we click on it we will be directed to another page
//                         onTap: (){ //In Flutter every page is known as Material Page
//                           Navigator.push(context, MaterialPageRoute(builder: (context){  //This is the method to go to different screen
//                             return VendorRegisterScreen(); //Going to Register Screen when we click 'SIGN UP' Text Widget
//                           }));
//                         },
//                         child: Text('SIGN UP',style: GoogleFonts.getFont(
//                           'Roboto',
//                           fontSize: 17,
//                           fontWeight: FontWeight.bold,
//                           color: Color(0xFF103DE5),),
//                         ),
//                       ),
//                     ],
//                   ),
//
//
//
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }




//
//
//NEW CODE
//
//

//It will check both in 'customers' and 'vendors' collection that 'isAdmin' is true or false and if it is true then only the user can login to the Admin Panel

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reto_radiance/vendor/controllers/vendor_controller.dart';
import 'package:reto_radiance/vendor/views/auth/vendor_register_screen.dart';
import 'package:reto_radiance/vendor/views/screens/main_vendor_screen.dart';
import 'package:reto_radiance/views/screens/authentication_screens/login_screen.dart';

class VendorLoginScreen extends StatefulWidget {
  @override
  State<VendorLoginScreen> createState() => _VendorLoginScreenState();
}

class _VendorLoginScreenState extends State<VendorLoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final VendorAuthController _authController = VendorAuthController();

  bool _isLoading = false;
  bool _isObscure = true;

  late String email;
  late String password;

  // Function to check if the user is an admin in either 'customers' or 'vendors' collection
  Future<bool> _checkIfAdmin(String email) async {
    try {
      // Check in 'customers' collection
      QuerySnapshot customersSnapshot = await FirebaseFirestore.instance
          .collection('customers')
          .where('email', isEqualTo: email)
          .get();

      if (customersSnapshot.docs.isNotEmpty) {
        DocumentSnapshot customerDoc = customersSnapshot.docs.first;
        bool isAdmin = customerDoc['isAdmin'] ?? false;
        if (isAdmin) {
          return true; // User is an admin in 'customers' collection
        }
      }

      // Check in 'vendors' collection
      QuerySnapshot vendorsSnapshot = await FirebaseFirestore.instance
          .collection('vendors')
          .where('email', isEqualTo: email)
          .get();

      if (vendorsSnapshot.docs.isNotEmpty) {
        DocumentSnapshot vendorDoc = vendorsSnapshot.docs.first;
        bool isAdmin = vendorDoc['isAdmin'] ?? false;
        if (isAdmin) {
          return true; // User is an admin in 'vendors' collection
        }
      }

      // User is not an admin in either collection
      return false;
    } catch (e) {
      print("Error checking admin status: $e");
      return false;
    }
  }

  // Login User Function
  loginUser() async {
    setState(() {
      _isLoading = true;
    });

    String res = await _authController.loginUser(email, password);

    if (res == 'Success') {
      // Check if the user is an admin in either collection
      bool isAdmin = await _checkIfAdmin(email);

      if (isAdmin) {
        // Navigate to the Main Vendor Screen
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return const MainVendorScreen();
        }));

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Logged IN Successfully')),
        );
      } else {
        // User is not an admin
        setState(() {
          _isLoading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Access Denied: You are not an admin')),
        );
      }
    } else {
      // Login failed
      setState(() {
        _isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(res)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.95),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "RetoADMIN Login",
                    style: GoogleFonts.getFont(
                      'Lato',
                      color: Color(0xFF0d120E),
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                      fontSize: 23,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Handcrafted with Love,  Delivered with Purpose",
                    style: GoogleFonts.getFont(
                      'Lato',
                      color: Color(0xFF0d120E),
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.2,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 40),
                  Image.asset(
                    'assets/images/RetoCircular.png',
                    width: 200,
                    height: 200,
                  ),
                  const SizedBox(height: 40),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Email",
                      style: GoogleFonts.getFont(
                        'Nunito Sans',
                        color: Color(0xFF0d120E),
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.2,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  TextFormField(
                    onChanged: (value) {
                      email = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Your Email';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(9),
                      ),
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      labelText: 'Enter Your Email',
                      labelStyle: GoogleFonts.getFont(
                        "Nunito Sans",
                        fontSize: 14,
                        letterSpacing: 0.2,
                      ),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Image.asset(
                          'assets/icons/email.png',
                          width: 20,
                          height: 20,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Password",
                      style: GoogleFonts.getFont(
                        'Nunito Sans',
                        color: Color(0xFF0d120E),
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.2,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  TextFormField(
                    obscureText: _isObscure,
                    onChanged: (value) {
                      password = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Enter Your Password';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(9),
                      ),
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      labelText: 'Enter Your Password',
                      labelStyle: GoogleFonts.getFont(
                        "Nunito Sans",
                        fontSize: 14,
                        letterSpacing: 0.2,
                      ),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Image.asset(
                          'assets/icons/password.png',
                          width: 20,
                          height: 20,
                        ),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _isObscure = !_isObscure;
                          });
                        },
                        icon: Icon(
                          _isObscure ? Icons.visibility : Icons.visibility_off,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  InkWell(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        loginUser();
                      }
                    },
                    child: Container(
                      width: 319,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        gradient: const LinearGradient(
                          colors: [Color(0xFF102DE1), Color(0xCC0D6EFF)],
                        ),
                      ),
                      child: Center(
                        child: _isLoading
                            ? CircularProgressIndicator(color: Colors.white)
                            : Text(
                          'LOGIN',
                          style: GoogleFonts.getFont(
                            'Lato',
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Login to Customer Account? ',
                        style: GoogleFonts.getFont(
                          'Roboto',
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return LoginScreen();
                          }));
                        },
                        child: Text(
                          'SIGN IN',
                          style: GoogleFonts.getFont(
                            'Roboto',
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF103DE5),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Need an Admin Account? ',
                        style: GoogleFonts.getFont(
                          'Roboto',
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return VendorRegisterScreen();
                          }));
                        },
                        child: Text(
                          'SIGN UP',
                          style: GoogleFonts.getFont(
                            'Roboto',
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF103DE5),
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

