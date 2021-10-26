import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Photo history"),
          backgroundColor: Colors.red,
        ),
        body: const Center(
          child: Icon(
            Icons.history,
            size: 100,
          ),
        ),
      ),
    );
  }
}