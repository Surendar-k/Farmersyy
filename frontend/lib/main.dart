import 'package:flutter/material.dart';
import 'package:frontend/splash_screen/swipe_up_screen.dart';  // Ensure this path is correct

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Farm Nest',
      debugShowCheckedModeBanner: false, // Remove the debug banner
      home: SwipeUpScreen(), // Set SwipeUpScreen as the home screen
    );
  }
}
