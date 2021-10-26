import 'package:flutter/material.dart';

class DisplayPage extends StatelessWidget {
  const DisplayPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Icon(
          Icons.photo,
          size: 100),
      ),
    );
  }
}