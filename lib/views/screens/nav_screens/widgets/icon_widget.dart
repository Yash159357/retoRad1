import 'package:flutter/material.dart';

class IconWidget extends StatelessWidget {
  const IconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // print(2);
    return Column(
      children: [
        Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10), // Adjust radius as needed
            child: Image.asset(
              'assets/images/BcglessLogo.png',
              height: 150,
              width: 150,
            ),
          ),
        ),
      ],
    );
  }
}
