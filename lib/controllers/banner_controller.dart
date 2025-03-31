

//Till now we have retrieved our Banners from our Firebase in a normal way, now we will be retrieving our Banners from Firebase using GetX

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class BannerController extends GetxController{

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //Function to retrieve our Banners from Cloud Firestore
  Stream<List<String>> getBannerUrls() {

    return _firestore.collection('banners').snapshots().map((snapshot) {

      return snapshot.docs.map((doc) => doc['image'] as String).toList();  //In our Firestore Database in 'banners' collection open one banner and you will see there is a field called 'image'.Check in that field we have the URL of our Banner (all banners are stored in our Firebase Storage only) so we are accessing and storing that 'image' field.

    });

  }

}