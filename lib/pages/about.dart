import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("About Depth Spectrum")),
      body: const Center(
        child: Text("We are Depth Spectrum")
      ),
    );
  }
}