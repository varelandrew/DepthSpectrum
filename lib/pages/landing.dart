import 'package:flutter/material.dart';
import 'package:depth_spectrum/pages/settings.dart';
import 'package:depth_spectrum/pages/camera.dart';
import 'package:depth_spectrum/pages/history.dart'; 
import 'package:depth_spectrum/pages/display.dart'; 

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController(initialPage: 1);
    return PageView(
      scrollDirection: Axis.horizontal,
      controller: controller,
      children: const <Widget>[
        SettingsPage(),
        CameraPage(),
        HistoryPage(),
      ],
    ); 
  }
}
