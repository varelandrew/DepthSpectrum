import 'dart:io';
import 'package:path_provider/path_provider.dart';

// Gets storage directory by platform
Future<String> getStorageDirectory() async {
  if (Platform.isAndroid) {
    return (await getExternalStorageDirectory())!.path;
  } else {
    return (await getApplicationDocumentsDirectory()).path;
  }
}

// Should build model from image
bool buildModel(String path) {
  List<String> splitPath = path.split("/");
  splitPath.last = splitPath.last.split(".").first + ".gltf";
  final String modelPath = splitPath.join("/");
  File image = File(path);
  // create and save model in here

  //
  return true;
}
