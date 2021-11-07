import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("About Depth Spectrum")),
      body: Column (
        children: const [
          Padding(padding: EdgeInsets.all(10)),
          Center(
            child: Text(
              "We are Depth Spectrum!",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          Padding(padding: EdgeInsets.all(10))
        ],
      ),
    );
  }
}