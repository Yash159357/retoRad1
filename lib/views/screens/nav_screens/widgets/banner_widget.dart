import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:reto_radiance/controllers/banner_controller.dart';

class BannerWidget extends StatefulWidget {
  const BannerWidget({super.key});

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  final BannerController _bannerController = BannerController();

  //Initialising Firestore package and creating '_firestore' which we will use to fetch our Banners from the Firebase.
  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // final List _bannerImage = []; //This "_bannerImage" will store our banners and it's a list because it will store a lot of values.

  // //Using this Function we will retrieve our Banners
  // getBanners(){
  //
  //   //Accessing our 'banners' collection present in our Firestore Database.
  //   return _firestore.collection("banners")
  //       .get()
  //       .then((QuerySnapshot querySnapshot) {
  //         querySnapshot.docs.forEach((doc) {
  //
  //           setState(() {
  //             _bannerImage.add(doc['image']); //In our Firestore Database in banners collection open one banner and you will see there is a field called 'image'.Check in that field we have the URL of our Banner (all banners are stored in our Firebase Storage only) so we are accessing and storing that 'image' field.
  //           });
  //
  //         });
  //   });
  //
  // } //End of getBanners()

  // //Function of init is as soon as our BannerWidget is called in our Home Screen, instantly it will run our 'getBanners()' function present in our 'banner_widget' page and will display our Banners.
  // @override
  // void initState() {   //init is only available for StatefulWidget
  //   // TODO: implement initState
  //   getBanners();
  //   super.initState();
  // }
  //

  //The above entire function is not needed as now we will retrieve our Banners from Firebase using GetX and we have already written or made that function in our 'banner_controller' page.

  @override
  Widget build(BuildContext context) {
    // return SizedBox(  //Here inside this we will display our Banners
    //
    //
    //   height: 140, //Height of the Container
    //   width: MediaQuery.of(context).size.width, //We will have many phones using our App so there will be many screen sizes hence this line will automatically take the entire current screen width size of the phone.
    //
    //
    //   child: PageView.builder(  //PageView is used to display more than one items.
    //
    //       itemCount: _bannerImage.length,  //'itemCount' will store the number of items stored inside our '_bannerImage' List.
    //       itemBuilder: (context, index) {
    //
    //       //'Image.network' because we are fetching our Image (Banners) from our Firebase.
    //       return Image.network(_bannerImage[index],); //Here we are accessing the banners by their index number in which they are stored in the List.
    //
    //   }),
    //
    // );

    //New way of retrieving our Banners using GetX function created in 'banner_controller' page.
    // print(4);
    return Padding(
      padding: const EdgeInsets.all(
        20.0,
      ), //Added Padding to our Container from all sides (MAIN PADDING)
      child: Container(
        //Here inside this we will display our Banners

        //Width and Height of the Container where our Banners will be shown
        width:
            MediaQuery.of(context)
                .size
                .width, //We will have many phones using our App so there will be many screen sizes hence this line will automatically take the entire current screen width size of the phone.
        height: 170, //Height of the Container

        decoration: BoxDecoration(
          color: const Color(0xffb832f6), //Color of our Banner Container

          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(
                0.2,
              ), //Color of the Box Shadow of our Container
              spreadRadius:
                  4, //'spreadRadius' means that how much we want our Box Shadow to spread.
              blurRadius:
                  10, //'blurRadius' means that how blurry we want our Box Shadow to be.
              offset: const Offset(
                0,
                1,
              ), //"Offset" represents a point in a coordinate system, defining the position of a widget on the screen by specifying how far it is from the origin on both the horizontal (dx) and vertical (dy) axis.
            ),
          ], //End of BoxShadow
          // borderRadius: BorderRadius.circular(10),
        ),

        child: StreamBuilder<List<String>>(
          stream:
              _bannerController
                  .getBannerUrls(), //Calling our 'getBannerUrls()' function from our 'banner_controller' page.

          builder: (context, snapshot) {
            if (snapshot.connectionState ==
                ConnectionState
                    .waiting) //It means that when we are trying to retrieve our Banners then we will show a Circular Progress Bar till that operation is completed.
            {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.blue, //Color of the Circular Progress Indicator
                ),
              );
            } else if (snapshot
                .hasError) //This means that if we encounter some error while loading our Banners then we will show an Error Icon
            {
              return const Icon(Icons.error);
            } else if (!snapshot.hasData ||
                snapshot
                    .data!
                    .isEmpty) //This means that if there are no Banners stored in our Firebase then we will show this message.
            {
              return const Center(
                child: Text(
                  'No Banners Available',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              );
            } else //Now this part means that we are not having any problems and now we can show our Banners.
            {
              return Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  PageView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      // return Image.network(snapshot.data![index],
                      // fit: BoxFit.cover, //This will make our Banner cover the entire Container Box.
                      // );

                      return CachedNetworkImage(
                        //Function of 'CachedNetworkImage' is it will store our banner locally after fetching it from our Firebase so that it doesn't have to load it from our Firebase all the time and our loading time will be less and hence our app will be fast.
                        imageUrl: snapshot.data![index],
                        fit:
                            BoxFit
                                .cover, //This will make our Banner cover the entire Container Box.
                        placeholder:
                            (context, url) =>
                                const CircularProgressIndicator(), //While we are trying to fetch our banner it will show the Circular Progress Indicator
                        errorWidget:
                            (context, url, error) => const Icon(
                              Icons.error,
                            ), //In case of Error it will show the Error Icon.
                      );
                    },
                  ),

                  _buildPageIndicator(
                    snapshot.data!.length,
                  ), //Passing the number of banners as argument to '_buildPageIndicator' function to create our indicators to show the number of banners
                ],
              );
            }
          },
        ),
      ),
    );
  }

  //This widget will now show the user the indicator of banners that how many banners are there
  Widget _buildPageIndicator(int pageCount) {
    //'pageCount' variable will store the number of Banners

    return Container(
      margin: const EdgeInsets.only(
        bottom: 16,
      ), //Giving margin only at the bottom of the Container

      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,

        children: List.generate(pageCount, (index) {
          return Container(
            //In this container we will actually create and design our Indicators
            width: 8, //Width of each indicator
            height: 8, //Height of each indicator

            margin: const EdgeInsets.symmetric(
              horizontal: 4,
            ), //This is the Horizontal Margin between each Indicator

            decoration: const BoxDecoration(
              color: Colors.orange, //Color of each indicator

              shape:
                  BoxShape
                      .circle, //Making our Indicator shape as circle from rectangle.
            ),
          );
        }),
      ),
    );
  }
}
