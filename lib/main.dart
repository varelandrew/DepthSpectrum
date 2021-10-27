import 'package:flutter/material.dart';
import 'package:depth_spectrum/pages/landing.dart';
import 'package:depth_spectrum/theme/theme.dart';
import 'package:camera/camera.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure plugin initialized
  final cameras = await availableCameras();  // Get available device cameras
  final firstCamera = cameras.first;         // Obtain specific camera

  runApp(MyApp(camera: firstCamera));
}

class MyApp extends StatelessWidget {
  final CameraDescription camera;

  const MyApp({
    Key? key,
    required this.camera
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Depth Spectrum',
      theme: dsTheme(),
      home: LandingPage(camera: camera), // Send camera to landing
    );
  }
}
