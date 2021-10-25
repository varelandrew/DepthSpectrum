import 'package:flutter/material.dart';
import 'package:depth_spectrum/pages/landing.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DepthSpectrum',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const LandingPage(title: 'DepthSpectrum Landing Demo'),
    );
  }
}
