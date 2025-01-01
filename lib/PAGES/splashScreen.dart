// ignore_for_file: prefer_const_constructors

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3), // Duration of the zoom-out effect
      vsync: this,
    );

    _animation = Tween<double>(begin: 1.0, end: 0.8).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    // Add status listener to check when animation completes
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Get.toNamed('/home');
      }
    });

    _controller.forward(); // Start the animation
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      body: Stack(
        children: [
          // Animated Zoom-Out Image
          Center(
            child: AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _animation.value,
                  child: child,
                );
              },
              child: Image.asset("images/cotsm.png", fit: BoxFit.cover),
            ),
          ),
          // Animated Text
          Positioned(
            bottom: 150, // Adjust position
            left: 0,
            right: 0,
            child: Center(
              child: AnimatedTextKit(
                animatedTexts: [
                  TyperAnimatedText(
                    "JOSIAH'S",
                    textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.red,
                    ),
                  ),
                  TyperAnimatedText(
                    "ARE",
                    textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.red,
                    ),
                  ),
                  ColorizeAnimatedText(
                    "JOSIAH'S ARISING",
                    textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                    colors: [
                      Colors.red,
                      Colors.blue,
                      Colors.green,
                      Colors.yellow,
                      Colors.white,
                      Colors.purple,
                    ],
                  ),
                ],
                isRepeatingAnimation: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
