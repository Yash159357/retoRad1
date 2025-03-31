

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EarningsScreen extends StatelessWidget {
  const EarningsScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final Stream<QuerySnapshot> orderStream = FirebaseFirestore.instance.collection('orders').where('vendorId', isEqualTo: FirebaseAuth.instance.currentUser!.uid).snapshots(); //Accessing the Orders collection from Firebase and only those orders which has the current logged in user vendor id that is only those orders placed to this current logged in vendor.
    CollectionReference users = FirebaseFirestore.instance.collection('vendors');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(FirebaseAuth.instance.currentUser!.uid).get(), //Getting the details of the Current Logged IN User
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          return Scaffold(
            appBar: AppBar( //Top App Bar
              backgroundColor: Colors.white,
              elevation: 0,
              title: Row(
                children: [
                  CircleAvatar( //Inside a circle our Text (Widget) will be shown, that is the function of Circle Avatar.
                    // radius: 40,
                    backgroundColor: Colors.blue,
                    child: Text(data['name'][0].toUpperCase(), //To get and display the first letter of the Vendor Name in Upper Case.
                    ),
                  ),
                  
                  Padding(padding: const EdgeInsets.all(8),
                    child: Text('Hi, ${data['name']}', //Displaying the Complete Name of the Vendor.
                      style: TextStyle(
                        fontSize: 20,
                        // fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                ],
              ),

              //LOGOUT BUTTON IN APP BAR
              actions: [
                IconButton(  //DON'T USE IT NOW WE NEED TO WORK PROPERLY ON LOGIN AND LOGOUT SO DON'T TAP THIS BUTTON NOW, AFTER LOGOUT WE WANT TO TAKE THE USER BACK TO ADMIN LOGIN SCREEN FOR VENDORS AND CUSTOMER LOGIN SCREEN FOR CUSTOMERS.
                    onPressed: () async{
                      await FirebaseAuth.instance.signOut();
                    },

                    icon: const Icon(Icons.logout,),),
              ],

            ), //END OF APP BAR


            body: StreamBuilder<QuerySnapshot>(
              stream: orderStream,
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.blue,
                    ),
                  );
                }



                //MAIN LOGIC SECTION

                double totalOrder = 0.0;

                for(var orderItem in snapshot.data!.docs) { //We are fetching these information from orders collection in Firebase so refer that.
                  totalOrder += orderItem['quantity'] * orderItem['price']; //THIS LOGIC IS ALSO WRONG AS WE ARE NOT CONSIDERING MULTIPLE PRODUCTS BUT ONLY 1 PRODUCT WITH MULTIPLE QUANTITIES.
                } //ALSO THE 'price' in 'orders' collection is itself 'quantity * discount' which we did in 'checkout_screen' when we are making and sending 'orders' collection and its respective fields so the above logic is completely WRONG as we are again multiplying. REMOVE QUANTITY FROM THIS LOGIC FIRST AND THEN PROCEED.

                //END OF MAIN LOGIC SECTION



                return Center(
                  child: Padding(padding: EdgeInsets.all(14),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [

                        //TOTAL EARNINGS SECTION
                        Container(
                          height: 150,
                          width: MediaQuery.of(context).size.width * 0.5,
                          decoration: BoxDecoration(
                            color: Color(0xFF102DE1),
                            borderRadius: BorderRadius.circular(32),
                          ),

                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text('Total Earnings',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  // fontWeight: FontWeight.bold,
                                ),
                              ),
                              
                              Text('\₹ ${totalOrder.toStringAsFixed(2,)}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  // fontWeight: FontWeight.bold,
                                ),
                              ),
                              
                            ],
                          ),

                        ),


                        //TOTAL ORDERS SECTION
                        Container(
                          height: 150,
                          width: MediaQuery.of(context).size.width * 0.5,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(32),
                          ),

                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text('Total Orders',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  // fontWeight: FontWeight.bold,
                                ),
                              ),

                              Text(snapshot.data!.docs.length.toString(),  //This LOGIC IS CORRECT AS WE ARE JUST RETURNING THE NUMBER OF DOCS IN 'orders' COLLECTION MATCHING WITH OUR CURRENT LOGGED IN VENDOR ID and displaying it.
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  // fontWeight: FontWeight.bold,
                                ),
                              ),

                            ],
                          ),

                        ),


                      ],
                    ),
                  ),
                );


              },
            ),


          );
        }

        return const CircularProgressIndicator();
      },
    );
  }
}
