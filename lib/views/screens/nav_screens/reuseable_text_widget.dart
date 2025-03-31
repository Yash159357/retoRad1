// //This page is for Section Headings and Sub Headings. We will REUSE it wherever we want and we just pass the required text to show them for that particular page.
//
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// class ReuseableTextWidget extends StatelessWidget {
//   final String title;
//   final String subtitle;
//
//   const ReuseableTextWidget({super.key, required this.title, required this.subtitle});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(12.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween, //This will make our Heading and Sub-Heading place at 2 separate extreme right and left to the screen horizontally
//         children: [
//           Text(title, style: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 1),),
//
//           Text(subtitle, style: GoogleFonts.roboto(color: Colors.blue, fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: 1),),
//         ],
//       ),
//     );
//   }
// }

//This page is for Section Headings and Sub Headings. We will REUSE it wherever we want and we just pass the required text to show them for that particular page.

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReuseableTextWidget extends StatelessWidget {
  final String title;
  // final String subtitle;

  const ReuseableTextWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    // print(5);
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment
                .spaceBetween, //This will make our Heading and Sub-Heading place at 2 separate extreme right and left to the screen horizontally
        children: [
          Text(
            title,
            style: GoogleFonts.roboto(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),

          // Text(subtitle, style: GoogleFonts.roboto(color: Colors.blue, fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: 1),),
        ],
      ),
    );
  }
}
