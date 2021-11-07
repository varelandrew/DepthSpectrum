import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:depth_spectrum/pages/settings.dart';
import 'package:depth_spectrum/pages/camera.dart';
import 'package:depth_spectrum/pages/history.dart';

class Landing extends StatefulWidget {
  final CameraDescription camera;
  
  const Landing({Key? key, required this.camera}) : super(key: key);

  @override
  State<Landing> createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController(initialPage: 1);
    return PageView(
      scrollDirection: Axis.horizontal,
      controller: controller,
      children: <Widget>[
        const Settings(),
        Camera(camera: widget.camera), // Send camera to our camera class
        const History(),
      ],
    );
  }
}
