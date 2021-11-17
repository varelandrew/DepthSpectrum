import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:depth_spectrum/pages/landing.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

final InAppLocalhostServer localhostServer = InAppLocalhostServer();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure plugin initialized
  final cameras = await availableCameras(); // Get available device cameras
  final firstCamera = cameras.first; // Obtain specific camera
  await localhostServer.start();
  if (Platform.isAndroid) {
    await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);
  }

  runApp(DepthSpectrum(camera: firstCamera));
}

class DepthSpectrum extends StatefulWidget {
  final CameraDescription camera;

  const DepthSpectrum({Key? key, required this.camera}) : super(key: key);

  @override
  _DepthSpectrumState createState() => _DepthSpectrumState();
}

class _DepthSpectrumState extends State<DepthSpectrum> {
  // @override
  // void initState() {
  //   super.initState();
  //   currentTheme.addListener(() {
  //     setState(() {});
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Depth Spectrum',
      // theme: DSTheme.lightTheme,
      // darkTheme: DSTheme.darkTheme,
      // themeMode: currentTheme.currentTheme,
      home: Landing(camera: widget.camera), // Send camera to landing
    );
  }
}
