

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VendorOrderDetailScreen extends StatefulWidget {

  final dynamic orderData;

  VendorOrderDetailScreen({super.key, required this.orderData});

  @override
  State<VendorOrderDetailScreen> createState() => _VendorOrderDetailScreenState();
}

class _VendorOrderDetailScreenState extends State<VendorOrderDetailScreen> {



  double rating = 0; //RATING VARIABLE


  //Function to Check if the Current Logged in User have a gave a review or not for this particular product. Main thing is that the user can only give one review for a particular product.
  Future<bool> hasUserReviewedProduct(String productId) async{
    final user = FirebaseAuth.instance.currentUser; //Here we are fetching the details of the customer

    //In this below line, we are filtering all this particular product purchased by our Current user.
    final querySnapshot = await FirebaseFirestore.instance.collection('productReviews').where('productId', isEqualTo: productId).where('customerId',isEqualTo: user!.uid).get();

    return querySnapshot.docs.isNotEmpty; //Checking whether its Empty or Not
  }


  //Function to Update Review and Rating in 'products' collection in our Firebase
  Future<void> updateProductRating(String productId) async{
    final querySnapshot = await FirebaseFirestore.instance
        .collection('productReviews')
        .where('productId', isEqualTo: productId)
        .get();

    double totalRating = 0;
    int totalReviews = querySnapshot.docs.length;

    //Extracting every rating this particular product has given by all customers
    for(final doc in querySnapshot.docs) {
      totalRating += doc['rating'];
    }

    //Calculating Average Rating
    final double averageRating = totalReviews > 0 ? totalRating/totalReviews : 0; //If Total Reviews is greater than 0 then calculate average rating or else it will be 0 which is our default.

    //Updating Rating and Reviews in our Firebase in 'products' collection.
    await FirebaseFirestore.instance.collection('products').doc(productId).update({
      'rating' : averageRating,
      'totalReviews' : totalReviews,
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text(widget.orderData['productName'],),
      ),

      body: Column(
        children: [

          Padding(padding: const EdgeInsets.symmetric(
            horizontal: 25, //Horizontal Padding
            vertical: 25, //Vertical Padding
          ),
            child: Container(
              width: 335,
              height: 153,
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(),
              child: SizedBox(
                width: double.infinity,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      left: 0,
                      top: 0,
                      child: Container(
                        width: 336,
                        height: 154,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: const Color(0xFFEFF0F2),
                          ),
                          borderRadius: BorderRadius.circular(9),
                        ),

                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [

                            //IMAGE SECTION
                            Positioned(
                              left: 10,
                              top: 9,
                              //Box inside which our Image will be shown
                              child: Container(
                                width: 78,
                                height: 78,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFBCC5FF),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    //Image is displayed
                                    Positioned(
                                      left: 10,
                                      top: 5,
                                      child: Image.network(widget.orderData['productImage'],
                                        width: 58, //Width of Image
                                        height: 67, //Height of Image
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            Positioned(
                              left: 101,
                              top: 14,
                              child: SizedBox(
                                width: 216,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(child: SizedBox(
                                      width: double.infinity,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          //Displaying Product Name
                                          SizedBox(
                                            width: double.infinity,
                                            child: Text(widget.orderData['productName'],
                                              style: GoogleFonts.lato(
                                                fontSize: 16,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),

                                          const SizedBox(height: 4,),

                                          //Displaying Product Category Name
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(widget.orderData['category'],
                                              style: const TextStyle(
                                                fontSize: 12,
                                                color: Color(0xFF7F808C),
                                                // fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),

                                          const SizedBox(height: 2,),

                                          //Displaying Product Price but it is actually our Discounted Price because everywhere we have passed it as this is the price which the user has paid for the Product.
                                          Text('\₹${widget.orderData['price']}',
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: Color(0xFF0B0C1E),
                                              // fontWeight: FontWeight.w500,
                                            ),
                                          ),

                                        ],
                                      ),
                                    ),
                                    )
                                  ],
                                ),
                              ),
                            ),


                            //Container where Delivery Status of the Product will be shown to the Customer.
                            Positioned(
                              left: 14,
                              top: 114,
                              child: Container(
                                width: 90, //Width of the Box where status will be shown
                                height: 25, //Height of the Box where status will be shown
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(

                                  //Color depending on the status of Order Delivery
                                  color:
                                  widget.orderData['delivered'] == true ? Color(0xFF3C55EF)  //This color will be shown when the order has been delivered.
                                      : widget.orderData['processing'] == true ? Colors.purple   //This color will be shown when the order is in processing.
                                      : Colors.red,      //This color will be shown when the order is cancelled.

                                  borderRadius: BorderRadius.circular(4),
                                ),

                                child: Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    Positioned(
                                      left: 9,
                                      top: 3,
                                      //Text depending on the status of Order Delivery
                                      child: Text(
                                        widget.orderData['delivered'] == true ? 'Delivered'  //This text will be shown when the order has been delivered.
                                            : widget.orderData['processing'] == true ? 'Processing'  //This text will be shown when the order is in processing.
                                            : 'Cancelled', //This text will be shown when the order is cancelled.

                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          height: 1.4,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                              ),
                            ),

                          ],
                        ),

                      ),
                    ),


                    //DELETE BUTTON SECTION
                    Positioned(
                      top: 115,
                      left: 298,

                      child: Container(
                        width: 20,
                        height: 20,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(), //IMPORTANT: Whenever we are using clipBehaviour, BoxDecoration is compulsory to mention even when we are not using it.
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [

                          ],
                        ),

                      ),
                    ), //END OF DELETE BUTTON SECTION

                  ],
                ),
              ),
            ),
          ),

          Padding(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),

            //MAIN BOX within which our Delivery Address, Customer Name and Review Button are displayed
            child: Container(
              width: 336,
              height: 250,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: const Color(0xFFEFF0F2,),
                ),
                borderRadius: BorderRadius.circular(9),
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(padding: EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        const Text('Delivery Address:',
                          style: TextStyle(
                            fontSize: 16,
                            // color: Colors.white,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                            // height: 1.4,
                          ),
                        ),

                        const SizedBox(height: 10,),

                        //Delivery Address
                        Text(widget.orderData['locality'] + ', ' + widget.orderData['city'] + ', ' + widget.orderData['state'] + ', Pincode: ' + widget.orderData['pinCode'],
                          style: const TextStyle(
                            fontSize: 14,
                            // color: Colors.white,
                            // fontWeight: FontWeight.bold,
                            // letterSpacing: 1,
                            // height: 1.4,
                          ),
                        ),

                        //Customer Name
                        Text('\nTo' + ' ' + widget.orderData['name'],
                          style: const TextStyle(
                            fontSize: 16,
                            // color: Colors.white,
                            fontWeight: FontWeight.w600,
                            // letterSpacing: 1,
                            // height: 1.4,
                          ),
                        ),


                        //
                        //Mark Deliver Button
                        //
                        ElevatedButton(

                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                          ),

                          onPressed: () async{
                            await FirebaseFirestore.instance.collection('orders').doc(widget.orderData['orderId']).update({
                              'delivered' : true,
                              'processing' : false,
                              'deliveredCount' : FieldValue.increment(1), //Incrementing Delivered Count
                            });
                          },

                          child: widget.orderData['delivered'] == true ? const Text('Delivered') : const Text('Mark Delivered',), //If the order has been delivered change the text to 'Delivered' or else 'Mark Delivered'
                        ),



                        //
                        //Mark Cancel Button
                        //
                        ElevatedButton(

                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),

                          onPressed: () async{
                            await FirebaseFirestore.instance.collection('orders').doc(widget.orderData['orderId']).update({
                              'delivered' : false,
                              'processing' : false,
                            });
                          },

                          child: widget.orderData['delivered'] == false && widget.orderData['processing'] == false  ? const Text('Cancelled') : const Text('Mark Cancel',),
                        ),

                      ],
                    ),
                  ),



                ],
              ),

            ),

          ),

        ],
      ),

    );
  }
}
