
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reto_radiance/vendor/views/auth/vendor_login_screen.dart';
import '../../controllers/vendor_controller.dart';

class VendorRegisterScreen extends StatefulWidget {
  @override
  State<VendorRegisterScreen> createState() => _VendorRegisterScreenState();
}

class _VendorRegisterScreenState extends State<VendorRegisterScreen> {
  // const VendorRegisterScreen({super.key});    //This constructor is used when we are passing some information from one screen to another like from Register Screen to Login Screen but as we are not passing any information now so this constructor is not needed.


  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  //'GlobalKey' is used to make the key global. 'FormState' is used to get the current state of the form. '_' is used in '_formKey' so that to make this variable private, i.e, it cannot be used or referred outside the Register Screen class.


  final VendorAuthController _authController = VendorAuthController();

  bool _isLoading = false; //This boolean variable is created for the circular loading bar which will be shown when an action is being carried out and the user needs to wait till that action has been completed.

  late String email;

  late String name;

  late String contactNumber;

  late String password;

  bool _isObscure = true; //This variable will be used to hide and show our Password

  registerUser() async{

    BuildContext localContext = context;

    setState(() { //setState is only available in StatefulWidget and not in StatelessWidget.
      _isLoading = true; //We are making this to true to start Loading
    });

    String res = await _authController.registerNewUser(email, name, password, contactNumber); //Passing 4 parameters or inputs from the Register Screen to the auth_controller where these parameters are received using the same function 'registerNewUser()'. Here 'contactNumber' parameter is passed as argument which will be stored in 'number' in 'auth_controller' page.

    //In this page 'res' variable is of String type because the 'registerNewUser' function which we created in our 'auth_controller' page returns String type value
    //In this page 'res' variable is storing all the parameters and sending it to our 'auth_controller' page for storing it in our Firebase
    //If it is successfully stored in our Firebase then check there in our 'auth_controller' page we are declaring "res = 'Success' " there and that value we are again returning from our 'auth_controller' page to our this page and doing the next steps.
    //In this page 'res' variable is also storing all the error messages while Registration and Login and we are getting that from our 'auth_controller' page.

    if(res == 'Success') {
      Future.delayed(Duration.zero,(){
        Navigator.push(localContext, MaterialPageRoute(builder: (context){
          return VendorLoginScreen(); // Going to Vendor Login Screen when our SIGN UP is successful and the user account has been created successfully
        }));

        ScaffoldMessenger.of(localContext).showSnackBar(const SnackBar(content: Text('Account has been Created Successfully')));

      });
    } else {

      //What will happen if our Registration if Failed

      setState(() {
        _isLoading = false; //If our account is not created successfully then we are making '_isLoading' as false.
      });

      Future.delayed(Duration.zero, () {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(res))); //Showing the Error Message that why Registration has failed.
      });

    } //End of Else

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( //Everything is contained inside the Scaffold Widget so in order to change Background color of Screen just change the color of Scaffold Widget like it is done in the next Line.

      backgroundColor: Colors.white.withOpacity(0.95), //Background color of entire screen with Opacity to make it a little dark

      body: Padding( //Wrapped 'Center' (which is our body) with 'Padding' in order to give spaces in all directions that is overall spaces from all outer sides
        padding: const EdgeInsets.all(10.0),
        child: Center( //Wrapped Column Widget with Center now it will place all the components inside Column to the center of the screen
          child: SingleChildScrollView( //Wrapped our Form Widget with SingleChildScrollView because it will now make our Screen scrollable. Till now we had a static page and we were getting 'Overflowed' error as the Form increases the limit of the screen vertically but now our page can be scrollable.
            child: Form( //Wrapped Column Widget with Form widget hence we can use our '_formKey' variable now to get state of our Form
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(  //CREATE YOUR ACCOUNT  Heading Text
                    "Create ADMIN Account",
                    style: GoogleFonts.getFont(
                      'Lato',
                      color: Color(0xFF0d120E),
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                      fontSize: 23,
                    ),
                  ),

                  SizedBox( //Sized Box is used to give spacings between 2 components or 2 Widgets
                    height: 5,
                  ),

                  Text(  //TAGLINE Text
                    "Handcrafted with Love,  Delivered with Purpose",
                    style: GoogleFonts.getFont(
                      'Lato',
                      color: Color(0xFF0d120E),
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.2,
                      fontSize: 14,
                    ),
                  ),

                  SizedBox( //Sized Box is used to give spacings between 2 components or Widgets
                    height: 20,
                  ),

                  Image.asset( //LOGIN BRAND Image
                    'assets/images/RetoCircular.png',
                    width: 200,
                    height: 200,
                  ),

                  SizedBox( //Sized Box is used to give spacings between 2 components or Widgets
                    height: 20,
                  ),


                  //Email Section
                  Align(  //To Align the 'Email' Text to go Left and not from the Center
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


                  //Place or Input Box where the User will write his/her Mail ID
                  TextFormField(
                    onChanged: (value) { //This will take the actual value inputted by the user in the Input Box
                      email = value; //Assigning that value to our variable. These variables are created at the top after 'GlobalKey' line.
                    },
                    validator: (value) {
                      if (value!.isEmpty) { //If the user has not filled anything in this input box
                        return 'Enter Your Email';
                      }
                      else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9),
                        ),

                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        labelText: 'Enter Your Email', //Text which will be shown to user as instruction or information that what to write in the Input Box
                        labelStyle: GoogleFonts.getFont(
                          "Nunito Sans",
                          fontSize: 14,
                          letterSpacing: 0.2,
                        ),


                        //Icon which will be shown in the Email Text Box
                        prefixIcon: Padding( //Wrapped 'Image' with 'Padding' in order to give spaces in all directions
                          padding: const EdgeInsets.all(10.0),
                          child: Image.asset('assets/icons/email.png',
                            width: 20,
                            height: 20,
                          ),
                        )

                    ),
                  ),



                  SizedBox( //Sized Box is used to give spacings between 2 components or Widgets
                    height: 20,
                  ),



                  //Name Section
                  Align(  //To Align the 'Email' Text to go Left and not from the Center
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Full Name",
                      style: GoogleFonts.getFont(
                        'Nunito Sans',
                        color: Color(0xFF0d120E),
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.2,
                        fontSize: 16,
                      ),
                    ),
                  ),


                  //Place or Input Box where the User will write his/her Mail ID
                  TextFormField(
                    onChanged: (value) { //This will take the actual value inputted by the user in the Input Box
                      name = value; //Assigning that value to our variable
                    },
                    validator: (value) {
                      if (value!.isEmpty) { //If the user has not filled anything in this input box
                        return 'Enter Your Name';
                      }
                      else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(9),
                      ),

                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      labelText: 'Enter Your Full Name', //Text which will be shown to user as instruction or information that what to write in the Input Box
                      labelStyle: GoogleFonts.getFont(
                        "Nunito Sans",
                        fontSize: 14,
                        letterSpacing: 0.2,
                      ),


                      //Icon which will be shown in the Email Text Box
                      prefixIcon: Padding( //Wrapped 'Image' with 'Padding' in order to give spaces in all directions
                        padding: const EdgeInsets.all(10.0),
                        child: Image.asset('assets/icons/user.jpeg',
                          width: 20,
                          height: 20,
                        ),
                      ),
                    ),
                  ),

                  SizedBox( //Sized Box is used to give spacings between 2 components or Widgets
                    height: 20,
                  ),


                  //Number Section
                  Align(  //To Align the 'Email' Text to go Left and not from the Center
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Contact Number",
                      style: GoogleFonts.getFont(
                        'Nunito Sans',
                        color: Color(0xFF0d120E),
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.2,
                        fontSize: 16,
                      ),
                    ),
                  ),


                  //Place or Input Box where the User will write his/her Contact Number
                  TextFormField(
                    onChanged: (value) { //This will take the actual value inputted by the user in the Input Box
                      contactNumber = value; //Assigning that value to our variable
                    },
                    validator: (value) {
                      if (value!.isEmpty) { //If the user has not filled anything in this input box
                        return 'Enter Your Contact Number';
                      }
                      else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9),
                        ),

                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        labelText: 'Enter Your Contact Number', //Text which will be shown to user as instruction or information that what to write in the Input Box
                        labelStyle: GoogleFonts.getFont(
                          "Nunito Sans",
                          fontSize: 14,
                          letterSpacing: 0.2,
                        ),


                        //Icon which will be shown in the Email Text Box
                        prefixIcon: Padding( //Wrapped 'Image' with 'Padding' in order to give spaces in all directions
                          padding: const EdgeInsets.all(10.0),
                          child: Image.asset('assets/icons/user.jpeg',
                            width: 20,
                            height: 20,
                          ),
                        )

                    ),
                  ),



                  SizedBox( //Sized Box is used to give spacings between 2 components or Widgets
                    height: 20,
                  ),



                  //Password Section
                  Align(  //To Align the 'Email' Text to go Left and not from the Center
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


                  //Place or Input Box where the User will write his/her Password
                  TextFormField(
                    obscureText: _isObscure, //This will hide and show the Password.This will hide and show according to the bool value of our _isObscure.
                    onChanged: (value) { //This will take the actual value inputted by the user in the Input Box
                      password = value; //Assigning that value to our variable
                    },
                    validator: (value) {
                      if (value!.isEmpty) { //If the user has not filled anything in this input box
                        return 'Please Create Your Password';
                      }
                      else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(9),
                      ),

                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      labelText: 'Enter Your Password', //Text which will be shown to user as instruction or information that what to write in the Input Box
                      labelStyle: GoogleFonts.getFont(
                        "Nunito Sans",
                        fontSize: 14,
                        letterSpacing: 0.2,
                      ),


                      //Icon which will be shown in the Email Text Box
                      prefixIcon: Padding( //Wrapped 'Image' with 'Padding' in order to give spaces in all directions
                        padding: const EdgeInsets.all(10.0),
                        child: Image.asset('assets/icons/password.png',
                          width: 20,
                          height: 20,
                        ),
                      ),

                      // suffixIcon: const Icon(Icons.visibility), //'Eye' Icon in Password. With Icon Widget we can also get many ready made Icons for use.

                      suffixIcon: IconButton( //Now we are making our Eye Button Clickable and hence it will hide and show the password respectively.
                        onPressed: () {
                          setState(() { //Main Function of this: Whenever we click on Eye button, _isObscure will be true and again when we will click it will be false and this will keep on happening.
                            _isObscure = ! _isObscure;
                          });
                        },
                        icon: Icon( //"?' means True and ":" means False
                          _isObscure ? Icons.visibility : Icons.visibility_off, //If _isObscure is true then Eye will be shown if it is false then Eye Cross button will be shown.
                        ),
                      ),

                    ),
                  ),

                  SizedBox( //Sized Box is used to give spacings between 2 components or Widgets
                    height: 30,
                  ),


                  //SIGN UP Button
                  InkWell(
                    onTap: () { //On clicking our 'SIGN UP' button it will check our Form is Filled or Validated or not


                      if (_formKey.currentState!.validate()) { //Checking the current state of our Form by accessing our '_formKey' variable and whether it is validated or not
                        //If our Form is Validated


                        // _authController.registerNewUser(email, name, password, contactNumber); //Passing 4 parameters or inputs from the Register Screen to the auth_controller where these parameters are received using the same function 'registerNewUser()'. Here 'contactNumber' parameter is passed as argument which will be stored in 'number' in 'auth_controller' page.

                        registerUser(); //Running 'registerUser' function declared above
                      }
                      // else {
                      //   print('Failed'); //If our Form is not Validated
                      // }


                    },
                    child: Container(
                      width: 319,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        gradient: const LinearGradient(
                          colors: [Color(0xFF102DE1),Color(0xCC0D6EFF,),],
                        ),
                      ),

                      child: Center( //Wrapped 'Text' Widget with 'Center' now it will place this text component inside 'Container' Widget to the center of the 'Container' Widget
                        child: _isLoading? CircularProgressIndicator(color: Colors.white,) :  Text( // '?' means True and ':' means False. If '_isLoading' is true then we are starting our Circular Progress Indicator and when '_isLoading' becomes false then it means our operation is completed and we stop our Circular Progress Indicator.
                          'SIGN UP',                                            //Color of our Circular Progress Indicator is white
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

                  SizedBox( //Sized Box is used to give spacings between 2 components or Widgets
                    height: 20,
                  ),

                  Row( //Like 'Column' Widget is used to place components Vertically, 'Row' Widget is used to place components horizontally
                    mainAxisAlignment: MainAxisAlignment.center, //This will place the components at the center horizontally
                    children: [
                      Text('Already have an Account? ',style: GoogleFonts.getFont(
                        'Roboto',
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,),
                      ),


                      InkWell(
                        onTap: (){ //In Flutter every page is known as Material Page
                          Navigator.push(context, MaterialPageRoute(builder: (context){  //This is the method to go to different screen
                            return VendorLoginScreen(); //Going to LOGIN Screen when we click 'LOGIN' Text Widget
                          }));
                        },
                        child: Text('LOGIN',style: GoogleFonts.getFont(
                          'Roboto',
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF103DE5),),
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
