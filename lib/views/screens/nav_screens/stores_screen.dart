

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reto_radiance/views/screens/inner_screens/inner_store_screen.dart';

class StoresScreen extends StatelessWidget {
  const StoresScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final Stream<QuerySnapshot> _storesStream = FirebaseFirestore.instance.collection('vendors').snapshots();

    return Scaffold(

      //Start of APP BAR
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(MediaQuery.of(context).size.height * 0.20), //The App Bar will take 20% of the screen size
        child: Container(
          width: MediaQuery.of(context).size.width, //The App Bar will take complete width of the screen size, although it is width of container but it will denote the width of App Bar only.
          height: 118, //Height of the container
          clipBehavior: Clip.hardEdge,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/icons/cartb.png',), //Cart Icon
              fit: BoxFit.cover, //This will actually make our App Bar cover the entire screen width
            ),
          ),

          child: Stack(
            children: [
              Positioned(
                left: 322,
                top: 52,
                child: Stack(
                  children: [

                    Image.asset(
                      'assets/icons/not.png', //Chat Icon
                      width: 26, //Width of Chat Icon
                      height: 26, //Height of Chat Icon
                    ),

                  ],
                ),
              ),

              //TITLE OF OUR NAVBAR
              Positioned(
                left: 61,
                top: 51,
                child: Text('Stores',
                  style: GoogleFonts.lato(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

            ],
          ),

        ),
      ), //End of APP BAR


      body: StreamBuilder<QuerySnapshot>(
        stream: _storesStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(),);
          }

          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              shrinkWrap: true,
              
              itemBuilder: (context, index) {
                final vendor = snapshot.data!.docs[index];
                
                return InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return InnerStoreScreen(vendorid: vendor['uid']);
                    }));
                  },


                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        CircleAvatar(
                          child: Text(vendor['name'][0].toUpperCase(),), //First letter of Vendor Name
                        ),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(vendor['name'],),
                        ), //Vendor Full Name

                      ],
                    ),
                  ),
                );
              }
          );
        },
      ),


    );
  }
}
