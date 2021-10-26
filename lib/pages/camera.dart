import 'package:flutter/material.dart';

class CameraPage extends StatelessWidget {
  const CameraPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Icon(
            Icons.camera_alt,
            size: 100,
          ),
        ),
      ),
    );
  }
}