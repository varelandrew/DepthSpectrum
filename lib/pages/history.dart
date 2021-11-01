import 'package:flutter/material.dart';
import 'package:depth_spectrum/pages/display.dart';

class History extends StatelessWidget {
  const History({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: const Icon(Icons.photo_library),
          title: const Text("Photo history"),
        ),
        body: ListView(
          children: <Widget>[
            const Padding(padding: EdgeInsets.all(5)),
            ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                    "https://i2.kym-cdn.com/photos/images/original/001/023/910/f0c.jpg"),
              ),
              title: const Text("Photo 1"),
            ),
            const Padding(padding: EdgeInsets.all(5)),
            ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                    "https://media-exp1.licdn.com/dms/image/C5603AQEdAojqU6D-Cw/profile-displayphoto-shrink_400_400/0/1631410513596?e=1640822400&v=beta&t=36AkiwTverFPRiBJosm1VRC22bl5BXrUh2GzPggJw6s"),
              ),
              title: const Text("Photo 2"),
            ),
            const Padding(padding: EdgeInsets.all(5)),
            ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                      "https://i.kym-cdn.com/entries/icons/mobile/000/035/807/cover1.jpg"),
                ),
                title: const Text("Photo 3"),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Display()));
                }),
          ],
        ),
      ),
    );
  }
}
