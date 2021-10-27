import 'package:flutter/material.dart';
import 'package:depth_spectrum/pages/landing.dart';
import 'package:depth_spectrum/consts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Depth Spectrum',
      theme: ThemeData(primaryColor: DSColors.darkred),
      home: const LandingPage(),
    );
  }
}
