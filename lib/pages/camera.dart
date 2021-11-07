import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:depth_spectrum/model_utils.dart';
import 'package:depth_spectrum/theme/colors.dart';

class Camera extends StatefulWidget {
  final CameraDescription camera;

  const Camera({Key? key, required this.camera}) : super(key: key);

  @override
  _CameraState createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    // Controller for displaying current output of camera
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );

    _initializeControllerFuture = _controller.initialize();
  }

  // Avoid exception: setState() called after dispose()
  @override
  void setState(fn) {
    if (mounted) {
      super.setState(() {});
    }
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: DSColors.black,
        appBar: AppBar(backgroundColor: Colors.transparent),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: const <Widget>[
              SizedBox(
                height: 70,
                child: DrawerHeader(
                  child: Text("Color scales"),
                  decoration: BoxDecoration(color: DSColors.darkred),
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
        // Display camera preview if initialized, else display loading indicator
        body: FutureBuilder<void>(
          future: _initializeControllerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return CameraPreview(_controller);
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
        // Take a picture with onPressed callback
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          backgroundColor: DSColors.red,
          onPressed: () async {
            // Ensure initialization and attempt to take picture
            await _initializeControllerFuture;
            final XFile image = await _controller.takePicture();
            // Copy temporary image to files/lastPhoto.png
            final File imFile = File(image.path);
            String imPath = await getStorageDirectory() + "/lastPhoto.png";
            imFile.copy(imPath);
            // Display image if taken
            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => DisplayImage(
                  imagePath: image.path,
                ),
              ),
            );
          },
          child: const Icon(Icons.camera_alt)),
      ),
    );
  }
}

// Temporary display class
class DisplayImage extends StatelessWidget {
  final String imagePath;

  const DisplayImage({Key? key, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: DSColors.red,
        title: const Text('Picture display')
      ),
      body: Image.file(File(imagePath))
    );
  }
}
