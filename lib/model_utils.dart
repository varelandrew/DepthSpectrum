import 'dart:io';
import 'dart:math';
import 'package:image/image.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vector_math/vector_math.dart';

// Gets storage directory by platform
Future<String> getStorageDirectory() async {
  if (Platform.isAndroid) {
    return (await getExternalStorageDirectory())!.path;
  } else {
    return (await getApplicationDocumentsDirectory()).path;
  }
}

final Matrix3 toXYZ = Matrix3(0.4124564, 0.3575761, 0.1804375, 0.2126729,
    0.7151522, 0.0721750, 0.0193339, 0.1191920, 0.9503041);

// Should build model from image
bool buildDepthMap(File f) {
  final Image im = decodeImage(f.readAsBytesSync())!;
  Image depthMap = Image(im.width, im.height);
  // Read image pixels
  for (int x = 0; x < im.width; x++) {
    for (int y = 0; y < im.height; y++) {
      // Retrieve RGB values
      final int p = im.getPixel(x, y);
      Vector3 sRGB = Vector3(
          (p & 0xff) / 255, (p >> 8 & 0xff) / 255, (p >> 16 & 0xff) / 255);
      // Convert sRGB -> sRGB'
      Vector3 sRGBp = Vector3(
        (sRGB.x <= 0.04045) ? sRGB.x / 12.92 : 0,
        (sRGB.y <= 0.04045) ? sRGB.y / 12.92 : 0,
        (sRGB.z <= 0.04045) ? sRGB.z / 12.92 : 0,
      ); // TODO: FIX CONVERSION TO SRGBP
      // Multiply by matrix to convert sRGB' -> XYZ
      Vector3 XYZ = Vector3(toXYZ.dotRow(0, sRGBp), toXYZ.dotRow(1, sRGBp),
          toXYZ.dotRow(2, sRGBp));
    }
  }
  List<String> splitPath = f.path.split("/");
  splitPath.last = splitPath.last.split(".").first + ".";
  final String depthMapPath = splitPath.join("/");
  return true;
}
