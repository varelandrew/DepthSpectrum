import 'package:flutter/material.dart';

class CameraPage extends StatelessWidget {
  const CameraPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black)
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: const <Widget>[
              DrawerHeader(
                child: Text("Color scales"),
                decoration: BoxDecoration(
                  color: Colors.black,
                ),
              ),
              ListTile(
                title: Text("Scale 1"),
              ),
              ListTile(
                title: Text("Scale 2"),
              ),
            ],
          ),
        ),
        body: const Center(
          child: Icon(
            Icons.camera_alt,
            size: 100,
          ),
        ),
      ),
    );
  }
}