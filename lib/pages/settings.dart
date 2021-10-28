import 'package:flutter/material.dart';
import 'package:depth_spectrum/theme/theme.dart';

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
          // actions: [
          //   IconButton(
          //     icon: const Icon(Icons.brightness_4_rounded),
          //     onPressed: () {
          //       currentTheme.toggleTheme();
          //     }, 
          //   )
          // ],
        ),
        body: ListView(
          children: [
            ListTile(
              leading: IconButton(
                icon: const Icon(Icons.brightness_4_rounded),
                onPressed: () {
                  currentTheme.toggleTheme();
                }, 
              ),
              title: const Text('Theme')
            ),
            const ListTile(
              leading: Icon(Icons.info),
              title: Text('About us')
            ),
          ],
        ),
      ),
    );
  }
}
