import 'package:flutter/material.dart';

import 'package:reto_radiance/views/screens/nav_screens/widgets/about_screen_constants.dart';
class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          Constants.aboutUsTitle,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFFFFE3C5),
        centerTitle: true,
      ),
      body: Container(
        color: const Color(0xFFFFE3C5),
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 420, // Set a fixed height for the GridView
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 2.0,
                    mainAxisSpacing: 10.0, // Increased vertical space
                  ),
                  itemCount: 9,
                  itemBuilder: (context, index) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: Image.asset(
                        'assets/images/grid_item${index + 1}.png',
                        fit: BoxFit.contain,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20.0),
              const Text(
                Constants.weAimToHelpText,
                style: TextStyle(
                  color: Color.fromRGBO(148, 72, 28, 1),
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20.0),
              const Text(
                Constants.missionText,
                style: TextStyle(color: Colors.black, fontSize: 16.0),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 20.0),
              const Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: Constants.whatIsOurText,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: Constants.movementText,
                      style: TextStyle(
                        color: Color.fromRGBO(148, 72, 28, 1),
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
              const Text(
                Constants.empoweringText,
                style: TextStyle(color: Colors.black, fontSize: 16.0),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 20.0),
              // First Stack widget
              ModifiedCard(
                text: Constants.firstStackText,
                imagePath: "assets/images/stack_im1.png",
                isImageRight: true,
              ),
              ModifiedCard(
                text: Constants.secondStackText,
                imagePath: "assets/images/stack_im2.png",
                isImageRight: false,
              ),
              ModifiedCard(
                text: Constants.thirdStackText,
                imagePath: "assets/images/stack_im3.png",
                isImageRight: true,
              ),
              const SizedBox(height: 20.0),
              const Text(
                Constants.testimonialsTitle,
                style: TextStyle(
                  color: Color.fromRGBO(148, 72, 28, 1),
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20.0),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    TestimonialCard(
                      name: "Aarohi Mehta",
                      stars: 5,
                      reviewText: Constants.aarohiReview,
                      imagePath: 'assets/images/test_user1.png',
                    ),
                    SizedBox(width: 16),
                    TestimonialCard(
                      name: "Rohan Sharma",
                      stars: 4.5,
                      reviewText: Constants.rohanReview,
                      imagePath: 'assets/images/test_user2.png',
                    ),
                    SizedBox(width: 16),
                    TestimonialCard(
                      name: "Priya Singh",
                      stars: 4,
                      reviewText: Constants.priyaReview,
                      imagePath: 'assets/images/test_user1.png',
                    ),
                    SizedBox(width: 16),
                    TestimonialCard(
                      name: "Amit Patel",
                      stars: 5,
                      reviewText: Constants.amitReview,
                      imagePath: 'assets/images/test_user2.png',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/instagram_2.png',
                    width: 30,
                    height: 30,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(width: 15.0),
                  const Text(
                    Constants.instagramHandle,
                    style: TextStyle(
                      color: Color.fromRGBO(148, 72, 28, 1),
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(6, (index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child: Image.asset(
                          'assets/images/shorts_${index + 1}.jpg',
                          width: 150,
                          height: 250,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  }),
                ),
              ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/youtube_2.png',
                    width: 30,
                    height: 30,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(width: 15.0),
                  const Text(
                    Constants.youtubeHandle,
                    style: TextStyle(
                      color: Color.fromRGBO(148, 72, 28, 1),
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(6, (index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child: Image.asset(
                          'assets/images/shorts_${6 - index}.jpg',
                          width: 150,
                          height: 250,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TestimonialCard extends StatelessWidget {
  final String name;
  final double stars;
  final String reviewText;
  final String imagePath;

  const TestimonialCard({
    super.key,
    required this.name,
    required this.stars,
    required this.reviewText,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 250,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFFB2694F),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  imagePath,
                  height: 100,
                  width: 100,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Row(
                    children: [
                      Row(
                        children: List.generate(
                          stars.floor(),
                          (index) =>
                              Icon(Icons.star, color: Colors.white, size: 20),
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        "${stars.toStringAsFixed(1)}/5",
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(reviewText, style: TextStyle(color: Colors.white, fontSize: 14)),
        ],
      ),
    );
  }
}

class CustomStackWidget extends StatelessWidget {
  final String text;
  final String imagePath;
  final bool isImageRight;

  const CustomStackWidget({
    super.key,
    required this.text,
    required this.imagePath,
    required this.isImageRight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: 250,
      decoration: BoxDecoration(
        color: Color.fromRGBO(148, 72, 28, 1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          // Text
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.only(
                left: isImageRight ? 16 : 140,
                right: isImageRight ? 140 : 16,
                top: 16,
                bottom: 16,
              ),
              child: Text(
                text,
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),
          ),
          // Image
          Positioned(
            top: 20,
            left: isImageRight ? null : 0,
            right: isImageRight ? 0 : null,
            child: ClipRRect(
              borderRadius:
                  isImageRight
                      ? BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                      )
                      : BorderRadius.only(
                        topRight: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
              child: Image.asset(
                imagePath,
                height: 160,
                width: 120,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ModifiedCard extends StatelessWidget {
  final String text;
  final String imagePath;
  final bool isImageRight;

  const ModifiedCard({
    super.key,
    required this.text,
    required this.imagePath,
    required this.isImageRight,
  });

  @override
  Widget build(BuildContext context) {
    // Use a fixed width or constrained width instead of double.infinity
    return Center(
      child: Container(
        // width: MediaQuery.of(context).size.width * 0.8, // 80% of screen width
        // padding: EdgeInsets.all(8),
        margin: EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          // border: Border.all(color: Colors.black, width: 2),
          borderRadius: BorderRadius.circular(16),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final containerWidth = constraints.maxWidth * 0.8;
            final imageWidth = constraints.maxWidth * 0.4;
            final imageHeight = 200.0;
            // Make sure text container has min height that's larger than image
            final containerMinHeight =
                220.0; // Slightly larger than image height

            return Stack(
              clipBehavior: Clip.none, // Allow image to overflow
              children: [
                // Text container with dynamic height but minimum size
                Align(
                  alignment:
                      isImageRight
                          ? Alignment.centerLeft
                          : Alignment.centerRight,
                  child: Container(
                    width: containerWidth,
                    constraints: BoxConstraints(minHeight: containerMinHeight),
                    padding: EdgeInsets.only(
                      top: 16,
                      bottom: 16,
                      // Add padding on the side where the image will overlap
                      left: isImageRight ? 16 : (imageWidth / 2) + 16,
                      right: isImageRight ? (imageWidth / 2) + 16 : 16,
                    ),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(148, 72, 28, 1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      textAlign: TextAlign.start,
                      text,
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                  ),
                ),
                // Image positioned at middle height and overlapping exactly halfway
                Positioned(
                  left: isImageRight ? containerWidth - (imageWidth / 2) : null,
                  right:
                      isImageRight ? null : containerWidth - (imageWidth / 2),
                  // Center the image vertically relative to the container's minimum height
                  // top: (containerMinHeight - imageHeight) / 2,
                  bottom: 100,
                  top: 100,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      imagePath.startsWith("assets")
                          ? imagePath
                          : "assets/images/shorts_1.jpg",
                      width: imageWidth,
                      height: imageHeight,

                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
