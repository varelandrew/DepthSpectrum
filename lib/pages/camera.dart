import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:depth_spectrum/consts.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({Key? key}) : super(key: key);

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  File? _image;

  Future getImage(ImageSource source) async {
    try {
      final _image = await ImagePicker().pickImage(source: source);
      if (_image == null) return;
      File tempImage = File(_image.path);
      setState(() => this._image = tempImage);
    } on Exception catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: const IconThemeData(
            color: DSColors.black,
          ),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: const <Widget>[
              SizedBox(
                height: 70,
                child: DrawerHeader(
                  child: Text("Color scales"),
                  decoration: BoxDecoration(
                    color: DSColors.darkred,
                  ),
                ),
              ),
              ListTile(
                leading: Image(
                    image: NetworkImage(
                        "https://media.discordapp.net/attachments/676149764764598300/902796804062580746/alexbanner.png")),
                title: Text("Scale 1"),
                subtitle: Text("Protanopia"),
              ),
              ListTile(
                leading: Image(
                    image: NetworkImage(
                        "https://cdn.discordapp.com/attachments/676149764764598300/902795432772648990/babylaugh.png")),
                title: Text("Scale 2"),
                subtitle: Text("Deuteranopia"),
              ),
            ],
          ),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              IconButton(
                  icon: const Icon(
                    Icons.camera_alt,
                    size: 100,
                  ),
                  onPressed: () => getImage(ImageSource.camera)),
              const Padding(padding: EdgeInsets.all(100)),
              IconButton(
                  icon: const Icon(
                    Icons.photo_library,
                    size: 100,
                  ),
                  onPressed: () => getImage(ImageSource.gallery)),
              _image != null
                  ? Image.file(_image!, height: 300, width: 300)
                  : const Icon(Icons.usb_rounded)
            ],
          ),
        ),
      ),
    );
  }
}

// No camera access
// class CameraPage extends StatelessWidget {
//   const CameraPage({ Key? key }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.transparent,
//           elevation: 0,
//           iconTheme: const IconThemeData(color: Colors.black,),
//         ),
//         drawer: Drawer(
//           child: ListView(
//             padding: EdgeInsets.zero,
//             children: const <Widget>[
//               // SizedBox(
//               //   height: 50,
//               //   child: DrawerHeader(
//               //     child: Text("Color scales"),
//               //     decoration: BoxDecoration(
//               //       color: Colors.red,
//               //     ),
//               //   ),
//               // ),
//               ListTile(
//                 title: Text("Scale 1"),
//               ),
//               ListTile(
//                 title: Text("Scale 2"),
//               ),
//             ],
//           ),
//         ),
//         body: const Center(
//           child: Icon(
//             Icons.camera_alt,
//             size: 100,
//           ),
//         ),
//       ),
//     );
//   }
// }

// Drawer no appbar
// class CameraPage extends StatefulWidget {
//   const CameraPage({ Key? key }) : super(key: key);
//
//   @override
//   _CameraPageState createState() => _CameraPageState();
// }
//
// class _CameraPageState extends State<CameraPage> {
//   final GlobalKey<ScaffoldState> _scaffoldDrawerKey = GlobalKey<ScaffoldState>(); // Drawer no appbar
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         key: _scaffoldDrawerKey, // drawer no appbar
//         // appBar: AppBar(
//         //   backgroundColor: Colors.transparent,
//         //   elevation: 0,
//         // ),
//         drawer: Drawer(
//           child: ListView(
//             padding: EdgeInsets.zero,
//             children: const <Widget>[
//               // SizedBox(
//               //   height: 50,
//               //   child: DrawerHeader(
//               //     child: Text("Color scales"),
//               //     decoration: BoxDecoration(
//               //       color: Colors.red,
//               //     ),
//               //   ),
//               // ),
//               ListTile(
//                 title: Text("Scale 1"),
//               ),
//               ListTile(
//                 title: Text("Scale 2"),
//               ),
//             ],
//           ),
//         ),
//         body: Stack(
//           children: [
//             IconButton(
//               onPressed: () => _scaffoldDrawerKey.currentState!.openDrawer(), 
//               icon: const Icon(
//                 Icons.menu,
//                 color: Colors.black)
//             ),
//             const Center(
//               child: Icon(
//                 Icons.camera_alt,
//                 size: 100,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }