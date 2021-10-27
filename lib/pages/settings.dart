import 'package:flutter/material.dart';
import 'package:depth_spectrum/theme/colors.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: const Icon(Icons.settings),
          title: const Text("Settings"),
          backgroundColor: DSColors.darkred,
        ),
        body: const Center(
          child: Icon(
            Icons.settings,
            size: 100,
          ),
        ),
      ),
    );
  }
}
