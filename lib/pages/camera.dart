import 'package:flutter/material.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({ Key? key }) : super(key: key);

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  final GlobalKey<ScaffoldState> _scaffoldDrawerKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        key: _scaffoldDrawerKey,
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: const <Widget>[
              // SizedBox(
              //   height: 50,
              //   child: DrawerHeader(
              //     child: Text("Color scales"),
              //     decoration: BoxDecoration(
              //       color: Colors.red,
              //     ),
              //   ),
              // ),
              ListTile(
                title: Text("Scale 1"),
              ),
              ListTile(
                title: Text("Scale 2"),
              ),
            ],
          ),
        ),
        body: Stack(
          children: [
            IconButton(
              onPressed: () => _scaffoldDrawerKey.currentState!.openDrawer(), 
              icon: const Icon(
                Icons.menu,
                color: Colors.black)
            ),
            const Center(
              child: Icon(
                Icons.camera_alt,
                size: 100,
              ),
            ),
          ],
        ),
      ),
    );
  }
}