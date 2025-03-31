

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class UploadProductScreen extends StatefulWidget {
  UploadProductScreen({super.key});

  @override
  State<UploadProductScreen> createState() => _UploadProductScreenState();
}

class _UploadProductScreenState extends State<UploadProductScreen> {
  
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  final TextEditingController _sizeController = TextEditingController();
  final FirebaseFirestore _firestore =FirebaseFirestore.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<String> _imageUrlList = []; //To store the urls of images after they are uploaded in FirebaseStorage. We will use this to store these urls in our Firestore Database from where we will fetch everything and display in our Customer App.

  bool _isLoading = false;

  final List<String> _categoryList = [];

// We will be uploading the values stored in this variables to the cloud firestore
  final List<String> _sizeList = [];
  String? selectedCategory;
  bool isLoading = false;
  String? productName;
  double? productPrice;
  int? discount;
  int? quantity;
  String? description;

  bool _isEntered = false;



  //Create an Instance of the ImagePicker to handle Image Selection
  final ImagePicker picker = ImagePicker();

  //Initialise an Empty List to Store the Selected Images
  List<File> images = [];

  //Function to Choose Image from Gallery
  chooseImage() async{

    //Use the Picker to Select an image from the Gallery
    final pickedFile = await picker.pickImage(source: ImageSource.gallery); //We can select camera also as source but as we want to edit and then upload so we selected source as gallery.

    //Check if no image was picked or selected
    if(pickedFile == null)
    {
      print('No Image Selected');
    }
    else
    {
      setState(() {
        images.add(File(pickedFile.path));
      });
    }

  }
  
  
  //Function to Upload the Selected Product Images to Firebase Storage
  uploadProductImages() async{
    for (var image in images) {
      Reference ref = _firebaseStorage.ref().child('productImages').child(const Uuid().v4());
      await ref.putFile(image).whenComplete(() async{
        await ref.getDownloadURL().then((value) {
          setState(() {
            _imageUrlList.add(value); //Storing the Image urls of FirebaseStorage in this list.
          });
        });
      });
    }
    print(_imageUrlList);
  }


  //Function to Upload Products to Cloud Firestore
  uploadData() async{
    setState(() {
      _isLoading = true;
    });

    DocumentSnapshot vendorDoc = await _firestore.collection('vendors').doc(FirebaseAuth.instance.currentUser!.uid).get(); //Retrieving all the information of the Current Logged IN Vendor from Firebase.

    await uploadProductImages();
    if (_imageUrlList.isNotEmpty) {
      final productId = Uuid().v4();
      await _firestore.collection('products').doc(productId).set({
        'productId':productId,
        'productName':productName,
        'productPrice':productPrice,
        'productSize':_sizeList,
        'category':selectedCategory,
        'description':description,
        'discount':discount,
        'quantity':quantity,
        'productImage':_imageUrlList,
        'vendorId' : FirebaseAuth.instance.currentUser!.uid, //Vendor Id who uploads a particular product
        'vendorName' : (vendorDoc.data() as Map<String, dynamic>)['name'],
        'rating' : 0,
        'totalReviews' : 0,
        'isPopular' : false,
        'isRecommended' : false,
        'isSoldOut' : false,
      }).whenComplete(() {
        setState(() {
          _isLoading = false;
          _formKey.currentState!.reset();
          _imageUrlList.clear();
          images.clear();
        });
      });

    }
  }
  
  

  //Fetch categories from Cloud Firestore
  _getCategories() {
    return _firestore.collection('categories').get().then((
        QuerySnapshot querySnapshot,
        ) {
      for (var doc in querySnapshot.docs) {
        setState(() {
          _categoryList.add(doc['categoryName']);
        });
      }
    });
  }



  @override
  void initState() {
    _getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
        child: SingleChildScrollView( //This will make the Screen Scrollable
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              GridView.builder(
                  shrinkWrap: true,
                  itemCount: images.length + 1, //Number of Items in the Grid(+1) for the Add Button

                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, //This means we will show 3 images in each Row
                    mainAxisSpacing: 8, //Vertical spacing between each image
                    crossAxisSpacing: 4, //Horizontal spacing between each image
                    childAspectRatio: 1,
                  ),

                  itemBuilder: (context, index) {
                    //If the Index is 0 then display an Icon Button to add a New Image.
                    return index == 0 ? Center(  //IF PART
                      child: IconButton(onPressed: () {
                        chooseImage();
                      },

                          icon: const Icon(Icons.add)),
                    )

                        : SizedBox( //ELSE PART
                      child: Image.file(images[index - 1],),
                    );
                  },
              ),

              const SizedBox(height: 10,),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [

                    //Product Name Section
                    TextFormField(
                      onChanged: (value) {
                        productName = value;
                      },
                      validator: (value) {
                        if(value!.isEmpty) {
                          return 'enter field';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        labelText: 'Enter Product Name',
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),


                    const SizedBox(height: 20),


                    Row(
                      children: [
                        Flexible(

                          //Original Price Section
                          child: TextFormField(
                            onChanged: (value) {
                              productPrice = double.parse(value); //OLD CODE, NEW BELOW CODE IS NOT WORKING, GOING ONLY TO ELSE PART, SOME PROBLEM WITH IF PART.

                              // if(value.isEmpty && double.tryParse(value)!=null)
                              // {
                              //   productPrice = double.parse(value);
                              // }
                              // else
                              // {
                              //   //Handle the Case where value is Invalid or Empty
                              //   productPrice = 0.0;
                              // }
                            },
                            validator: (value) {
                              if(value!.isEmpty) {
                                return 'enter field';
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              labelText: 'Enter Price',
                              filled: true,
                              fillColor: Colors.grey[200],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        Flexible(child: buildDropDownField()),
                      ],
                    ),


                    const  SizedBox(height: 20),

                    //Discounted Price Section
                    TextFormField(
                      onChanged: (value) {
                        discount = int.parse(value); //OLD CODE, NEW BELOW CODE IS NOT WORKING, GOING ONLY TO ELSE PART, SOME PROBLEM WITH IF PART.

                        // if(value.isEmpty && int.tryParse(value)!=null)  //We can make Discount even Double.
                        // {
                        //   discount = int.parse(value);
                        // }
                        // else
                        // {
                        //   //Handle the Case where value is Invalid or Empty
                        //   discount = 0;
                        // }
                      },
                      validator: (value) {
                        if(value!.isEmpty) {
                          return 'enter field';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        labelText: 'Discount',
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),

                    const  SizedBox(height: 20),


                    //Quantity Section
                    TextFormField(
                      onChanged: (value) {
                        quantity = int.parse(value); //OLD CODE, NEW BELOW CODE IS NOT WORKING, GOING ONLY TO ELSE PART, SOME PROBLEM WITH IF PART.

                        // if(value.isEmpty && int.tryParse(value)!=null)
                        // {
                        //   quantity = int.parse(value);
                        // }
                        // else
                        // {
                        //   //Handle the Case where value is Invalid or Empty
                        //   quantity = 1;
                        // }
                      },
                      validator: (value) {
                        if(value!.isEmpty) {
                          return 'enter field';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        labelText: 'Quantity',
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),


                    const SizedBox(height: 20),


                    //Description Section
                    TextFormField(
                      onChanged: (value) {
                        description = value;
                      },
                      maxLength: 800,
                      maxLines: 4,
                      validator: (value) {
                        if(value!.isEmpty) {
                          return 'enter field';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        labelText: 'Enter Description',
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),


                    const SizedBox(height: 20),


                    //Size Section
                    Row(
                      children: [
                        Flexible(
                          child: SizedBox(
                            width: 200,
                            child: TextFormField(
                              controller: _sizeController,
                              onChanged: (value) {
                                setState(() {
                                  _isEntered = true;
                                });
                              },
                              decoration: InputDecoration(
                                labelText: 'Add Size',
                                filled: true,
                                fillColor: Colors.grey[200],
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        _isEntered==true?  Flexible(
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _sizeList.add(_sizeController.text);
                                _sizeController.clear();
                              });
                            },
                            child: const Text(
                              'Add',
                            ),
                          ),
                        ): const Text(' '),

                      ],
                    ),
                    _sizeList.isNotEmpty
                        ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 50,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _sizeList.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    _sizeList.removeAt(index);
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.blue.shade800,
                                      borderRadius: BorderRadius.circular(8),
                                    ),

                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(_sizeList[index], style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                      ),
                                    ),
                                  ),
                                ),
                              );

                            }),
                      ),
                    )
                        : Text(''),

                    //END OF SIZE SECTION

                  ],
                ),
              ),


              //UPLOAD PRODUCT BUTTON
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    if(_formKey.currentState!.validate())  //Checking if our Form is Valid or Not
                    {
                      uploadData();
                    }
                  },


                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(9),
                    ),
                    child: Center(
                      child: _isLoading ? const CircularProgressIndicator(color: Colors.white,) : Text('Upload Product',
                        style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),


            ],
          ),
        ),
    );
  }

  Widget buildDropDownField() {
    return DropdownButtonFormField(
      decoration: InputDecoration(
        labelText: 'Select Category',
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
      items:
      _categoryList.map((value) {
        return DropdownMenuItem(value: value, child: Text(value));
      }).toList(),
      onChanged: (value) {
        if (value != null) {
          setState(() {
            selectedCategory = value;
          });
        }
      },
    );
  }

}
