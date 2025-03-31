

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:reto_radiance/models/category_models.dart';


//Now we will retrieve our Categories from our Firebase using our GetX
//It is almost similar like what we did when we retrieved our Banners from our Firebase
class CategoryController extends GetxController {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //The main purpose of this line is to keep track of the data (mostly the ones we are retrieving from our Firebase) going to the 'categories' variable and hence update the UI accordingly.
  RxList<CategoryModel> categories = <CategoryModel> [].obs; //RxList stands for Reactive List and obs stands for observatory.


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _fetchCategories();
  }


  //Creating a function which will retrieve our category datas from our Cloud Firestore
  void _fetchCategories() {
    _firestore
        .collection('categories')
        .snapshots()
        .listen((QuerySnapshot querySnapshot) {
          categories.assignAll(querySnapshot.docs.map((doc) {

            final data = doc.data() as Map<String, dynamic>; //Map is something which has a name and a property value, here our name in Firebase is 'categoryImage' and our value is 'categoryImage'. 'dynamic' because our data will be dynamic.

            //Returning these datas to our 'CategoryModel' constructor present in our 'category_models' page
            return CategoryModel(data['categoryName'], data['categoryImage']);

          }).toList(),
        );
    });
  }

}