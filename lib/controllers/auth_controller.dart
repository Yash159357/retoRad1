//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
//
// class AuthController {
//
//   final FirebaseAuth _auth = FirebaseAuth.instance; //For Firebase Authentication
//
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
// //
// //
// //REGISTER USER SECTION
// //
// //
//
//   //Purpose of registerNewUser function is to create new user database in our Firebase
//   Future<String> registerNewUser(String email, String name, String password, String number) async { //Receiving 4 parameters or inputs from the Register Screen where these parameters are passed using the same function.
//     //Whenever we use 'await' we need to use 'async'
//
//
//     String res = 'Something Went Wrong';
//
//
//
//     try {
//
//       //We want to create the user in authentication tab and then later in Cloud Firestore
//
//       UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
//           email: email,
//           password: password
//       );
//
//       await _firestore.collection('customers').doc(userCredential.user!.uid).set({
//
//       'name' : name,
//       'number' : number,
//       'email' : email,
//       'profileImage' : "",
//       'uid' : userCredential.user!.uid,
//       'pinCode' : "",
//       'locality' : "",
//       'city' : "",
//       'state' : "",
//       'isAdmin' : false, //Main Field which will allow only Admins to access Admin Panel
//       });
//
//       res = 'Success';
//
//     }on FirebaseAuthException catch (e) {  //This documentation we got from "https://firebase.flutter.dev/docs/auth/password-auth" and this will actually show what the error actually is if the User Registration is Failed.
//       if (e.code == 'weak-password') {
//         // print('The password provided is too weak.');
//         res = 'The password provided is too weak.'; //Updating the res variable with this error message instead of printing because we want to show the user this information.
//       } else if (e.code == 'email-already-in-use') {
//         // print('The account already exists for that email.');
//         res = 'The account already exists for that email.';
//       }
//     }
//     catch (e) {
//
//       res = e.toString();
//
//     }
//
//     return res;
//
//   }
//
// //
// //
// //LOGIN USER SECTION
// //
// //
//
//
//   //This process is also almost similar to what we did for Registration but doing it with Login Screen and 'auth_controller' now
// Future<String> loginUser(String email, String password)async {  //Future is used when a function needs time to do its operation and during that time we will show some things or do some things like while Login is going on we will show the user a Loading Screen, like this we use Future.
//     String res = 'Something went wrong, Check Your Email or Password';
//
//
//   try {
//     await _auth.signInWithEmailAndPassword(email: email, password: password);
//
//     res = "Success"; //If Login is successful then this will be stored in 'res'
//
//   } on FirebaseAuthException catch (e) {  //This documentation we got from "https://firebase.flutter.dev/docs/auth/password-auth" and this will actually show what the error actually is if the User Login is Failed.
//     if (e.code == 'user-not-found') {
//       // print('No user found for that email.');
//       res = 'No user found for that email.';
//     } else if (e.code == 'wrong-password') {
//       // print('Wrong password provided for that user.');
//       res = 'Wrong password provided for that user.';
//     }
//   }
//   catch(e){ //'e' refers to Error
//
//     res = e.toString(); //If error is catched then it is stored in 'res'
//
//   }
//
//   return res;
//
// }
//
// }



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController {
  final FirebaseAuth _auth =
      FirebaseAuth.instance; //For Firebase Authentication

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> loginWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return 'Google sign in aborted';
      }

      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential = await _auth.signInWithCredential(
        credential,
      );
      User? user = userCredential.user;

      if (user != null) {
        await _saveUserDataToFirestore(user);
        return 'Success';
      } else {
        return 'Google sign in failed';
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> _saveUserDataToFirestore(User user) async {
    await _firestore.collection('customers').doc(user.uid).set({
      'email': user.email,
      'name': user.displayName,
      'number': "",
      'profileImage': "",
      'uid': user.uid,
      'pinCode': "",
      'locality': "",
      'city': "",
      'state': "",
      'isAdmin': false,
    });
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> sendEmailVerification() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    } catch (e) {
      print(e.toString());
    }
  }

  //
  //
  //REGISTER USER SECTION
  //
  //

  //Purpose of registerNewUser function is to create new user database in our Firebase
  Future<String> registerNewUser(
      String email,
      String name,
      String password,
      String number,
      ) async {
    //Receiving 4 parameters or inputs from the Register Screen where these parameters are passed using the same function.
    //Whenever we use 'await' we need to use 'async'

    String res = 'Something Went Wrong';

    try {
      //We want to create the user in authentication tab and then later in Cloud Firestore

      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      await _firestore.collection('customers').doc(userCredential.user!.uid).set({
        'name': name,
        'number': number,
        'email': email,
        'profileImage': "",
        'uid': userCredential.user!.uid,
        'pinCode': "",
        'locality': "",
        'city': "",
        'state': "",
        'isAdmin':
        false, //Main Field which will allow only Admins to access Admin Panel
      });

      res = 'Success';
    } on FirebaseAuthException catch (e) {
      //This documentation we got from "https://firebase.flutter.dev/docs/auth/password-auth" and this will actually show what the error actually is if the User Registration is Failed.
      if (e.code == 'weak-password') {
        // print('The password provided is too weak.');
        res =
        'The password provided is too weak.'; //Updating the res variable with this error message instead of printing because we want to show the user this information.
      } else if (e.code == 'email-already-in-use') {
        // print('The account already exists for that email.');
        res = 'The account already exists for that email.';
      }
    } catch (e) {
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
  Future<String> loginUser(String email, String password,) async {
    //Future is used when a function needs time to do its operation and during that time we will show some things or do some things like while Login is going on we will show the user a Loading Screen, like this we use Future.
    String res = 'Something went wrong, Check Your Email or Password';

    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      res =
      "Success"; //If Login is successful then this will be stored in 'res'
    } on FirebaseAuthException catch (e) {
      //This documentation we got from "https://firebase.flutter.dev/docs/auth/password-auth" and this will actually show what the error actually is if the User Login is Failed.
      if (e.code == 'user-not-found') {
        // print('No user found for that email.');
        res = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        // print('Wrong password provided for that user.');
        res = 'Wrong password provided for that user.';
      }
    } catch (e) {
      //'e' refers to Error

      res = e.toString(); //If error is catched then it is stored in 'res'
    }
    return res;
  }
}
