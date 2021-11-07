import 'package:flutter/material.dart';
import 'package:depth_spectrum/theme/theme.dart';
import 'package:depth_spectrum/pages/about.dart';

class Settings extends StatefulWidget {
  const Settings({ Key? key }) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: const Icon(Icons.settings),
          title: const Text("Settings"),
        ),
        body: ListView(
          children: [
            ListTile(
              leading: const Icon(Icons.brightness_4_rounded),
              title: const Text('Theme'),
              onTap: () {
                currentTheme.toggleTheme();
              }
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('About us'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const About()
                  )
                );
              }
            ),
          ],
        ),
      ),
    );
  }
}