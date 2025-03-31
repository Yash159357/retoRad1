
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class VendorAuthController {

  final FirebaseAuth _auth = FirebaseAuth.instance; //For Firebase Authentication

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//
//
//REGISTER USER SECTION
//
//

  //Purpose of registerNewUser function is to create new user database in our Firebase
  Future<String> registerNewUser(String email, String name, String password, String number) async { //Receiving 4 parameters or inputs from the Register Screen where these parameters are passed using the same function.
    //Whenever we use 'await' we need to use 'async'


    String res = 'Something Went Wrong';



    try {

      //We want to create the user in authentication tab and then later in Cloud Firestore

      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password
      );

      //Creating new Vendors Collection in our Firebase
      await _firestore.collection('vendors').doc(userCredential.user!.uid).set({

        'name' : name,
        'number' : number,
        'email' : email,
        'storeImage' : "",
        'uid' : userCredential.user!.uid,
        'pinCode' : "",
        'locality' : "",
        'city' : "",
        'state' : "",
        'isAdmin' : true, //Main Field which will allow only Admins to access Admin Panel
      });

      res = 'Success';

    }on FirebaseAuthException catch (e) {  //This documentation we got from "https://firebase.flutter.dev/docs/auth/password-auth" and this will actually show what the error actually is if the User Registration is Failed.
      if (e.code == 'weak-password') {
        // print('The password provided is too weak.');
        res = 'The password provided is too weak.'; //Updating the res variable with this error message instead of printing because we want to show the user this information.
      } else if (e.code == 'email-already-in-use') {
        // print('The account already exists for that email.');
        res = 'The account already exists for that email.';
      }
    }
    catch (e) {

      res = e.toString();

    }

    return res;

  }

//
//
//LOGIN USER SECTION
//
//


  //This process is also almost similar to what we did for Registration but doing it with Login Screen and 'auth_controller' now
  Future<String> loginUser(String email, String password)async {  //Future is used when a function needs time to do its operation and during that time we will show some things or do some things like while Login is going on we will show the user a Loading Screen, like this we use Future.
    String res = 'Something went wrong, Check Your Email or Password';


    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      res = "Success"; //If Login is successful then this will be stored in 'res'

    } on FirebaseAuthException catch (e) {  //This documentation we got from "https://firebase.flutter.dev/docs/auth/password-auth" and this will actually show what the error actually is if the User Login is Failed.
      if (e.code == 'user-not-found') {
        // print('No user found for that email.');
        res = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        // print('Wrong password provided for that user.');
        res = 'Wrong password provided for that user.';
      }
    }
    catch(e){ //'e' refers to Error

      res = e.toString(); //If error is catched then it is stored in 'res'

    }

    return res;

  }

}