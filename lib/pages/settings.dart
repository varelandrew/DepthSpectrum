import 'package:flutter/material.dart'; 

class SettingsPage extends StatelessWidget {
  const SettingsPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: const Icon(Icons.settings),
          title: const Text("Settings"),
          backgroundColor: Colors.red,
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
