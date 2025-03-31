

import 'package:flutter/material.dart';


//This widget is for the Header of our App so it will be used in many pages hence it will be difficult if we write the same code again for every page hence for our ease we have created this Widget and whenever we will need it we will simply call this Widget.

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(  //'Container' and 'SizedBox' are almost same but in 'Container' we can have access to 'BoxDecoration' which is very useful but here in this section as we are not using 'BoxDecoration' feature so it's better to go with 'SizedBox'



      //Width and Height of our Header Box (SizedBox)
      //We are making it Responsive
      width: MediaQuery.of(context).size.width, //We will have many phones using our App so there will be many screen sizes hence this line will automatically take the entire current screen width size of the phone.

      // height: MediaQuery.of(context).size.height *0.20, //We will have many phones using our App so there will be many screen sizes hence this line will automatically take the current screen height size of the phone and "*0.20" means we will be using only 20% of the screen height size.
                                                 //"*0.20" means we will be using only 20% of the screen height (vertical) size.




      child: Stack(children: [ //We use 'Stack' to place Widget on top of Widget

        Image.asset('assets/icons/searchBanner.jpeg', //Background Image of our Header
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,  //This will fill and fit the banner entirely in our Header Widget Container (here we are not talking about the Phone Screen)
        ),




        //Search Bar
        Positioned( //Positioned is used when we want to Position some widget according to our want and need.

          left: 48, //Position of our Search Bar (horizontal)
          top: 68,  //Position of our Search Bar (vertical)

          child: SizedBox( //Wrapping with Sized Box to give our TextField a Width and Height

            width: 250, //Width of our TextField that is our Search Bar only
            height: 50, //Height of our TextField that is our Search Bar only

            child: TextField( //Difference between 'TextField' and 'TextFormField' is in 'TextFormField' we have validator but as here we are making a Search bar so we don't need a validator and hence we will use simple 'TextField'

              decoration: InputDecoration(

                hintText: 'Search', //Text that will appear when user has not written anything

                //Styling the Hint Text that we just created above
                hintStyle: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF7F7F7F,),
                ),

                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16,), //Adding Padding to our Hint Text

                prefixIcon: Image.asset('assets/icons/searc1.png',), //Search Icon at the Left End of our Search Bar

                suffixIcon: Image.asset('assets/icons/cam.png',), //Camera Icon at the Right End of our Search Bar

                fillColor: Colors.grey.shade200, //Color of our Search Bar
                filled: true, //This will implement our 'fillColor' property that we created above

                focusColor: Colors.black, //Defines the color that is applied to a widget when it has keyboard focus

              ),

            ),
          ),
        ),




        //Bell Feature just beside our Search Bar
        Positioned(

          //Positions of Bell Icon
            left: 311,
            top: 78,


            child: Material( //Material is almost similar ro Scaffold

              type: MaterialType.transparency, //To get transparent BCG Images or Icons in our Header

              child: InkWell(
                onTap: (){},

                // overlayColor: MaterialStateProperty.all(const Color(0x0c7f7f,),),

              child: Ink(  //Main function of 'Ink' is when the user clicks on this icon then it will create a splash that is there will a highlight over that icon with a color like a splash effect when we click on it.
                width: 31, //Width of Bell Icon
                height: 31, //Height of Bell Icon



                //Whenever we click on this bell icon created down, we will get an effect and this effect is due to our 'InkWell' and 'Ink' Widgets

                decoration: const BoxDecoration(
                  image: DecorationImage(image: AssetImage('assets/icons/bell.png'),), //Bell Icon just beside our Search Bar
                ),
              ),

              ),

            ),
        ),




        //Message Feature just beside our Bell Feature
        Positioned(

          //Positions of Message Icon
            left: 354,
            top: 78,


            child: Material(

              type: MaterialType.transparency, //To get transparent BCG Images or Icons in our Header

              child: InkWell(
                onTap: (){},

                child: Ink(
                  width: 31, //Width of Message Icon
                  height: 31, //Height of Message Icon

                  decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage('assets/icons/message.png'),), //Message Icon just beside our Bell Icon
                  ),
                ),

              ),
            ),
        ),

      ],),

    );
  }
}