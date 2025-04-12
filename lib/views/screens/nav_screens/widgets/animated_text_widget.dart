import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class AnimatedTextWidget extends StatelessWidget {
  const AnimatedTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedTextKit(
        animatedTexts: [
          TypewriterAnimatedText(
            'Welcome to RetoRadience!',
            textStyle: const TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 182, 0, 118),
            ),
            speed: const Duration(milliseconds: 100),
          ),
          TypewriterAnimatedText(
            'Discover amazing deals!',
            textStyle: const TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 62, 1, 148),
            ),
            speed: const Duration(milliseconds: 100),
          ),
          TypewriterAnimatedText(
            'Shop the latest trends!',
            textStyle: const TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            speed: const Duration(milliseconds: 100),
          ),
          TypewriterAnimatedText(
            'Fast delivery at your doorstep!',
            textStyle: const TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 136, 0, 127),
            ),
            speed: const Duration(milliseconds: 100),
          ),
          TypewriterAnimatedText(
            'Enjoy exclusive discounts!',
            textStyle: const TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 203, 0, 125),
            ),
            speed: const Duration(milliseconds: 100),
          ),
        ],
        repeatForever: true, // Makes the animation loop infinitely
        pause: const Duration(milliseconds: 500), // Pause between loops
      ),
    );
  }
}
