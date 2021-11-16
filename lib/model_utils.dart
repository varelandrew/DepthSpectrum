import 'dart:io';
import 'package:image/image.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vector_math/vector_math.dart';
import 'dart:ffi';

final Matrix3 toXYZ = Matrix3(0.4124564, 0.3575761, 0.1804375, 0.2126729,
    0.7151522, 0.0721750, 0.0193339, 0.1191920, 0.9503041);

final DynamicLibrary cPowLib = Platform.isAndroid
    ? DynamicLibrary.open("libc_pow.so")
    : DynamicLibrary.process();
final double Function(double a, double b) c_pow = cPowLib
    .lookup<NativeFunction<Double Function(Double a, Double b)>>("c_pow")
    .asFunction();

enum Colorblindness { protanopia, deuteranopia, tritanopia }

bool insidesRGB(Vector2 xy) {
  final Vector2 r = Vector2(0.64, 0.33);
  final Vector2 g = Vector2(0.3, 0.6);
  final Vector2 b = Vector2(0.15, 0.06);
  final double as_x = xy.x - r.x;
  final double as_y = xy.y - r.y;
  bool s_ab = (g.x - r.x) * as_y - (g.y - r.y) * as_x > 0;
  if ((b.x - r.x) * as_y - (b.y - r.y) * as_x > 0 == s_ab) {
    return false;
  }
  if ((b.x - g.x) * (xy.y - g.y) - (b.y - g.y) * (xy.x - g.x) > 0 != s_ab) {
    return false;
  }
  return true;
}

// Should build model from image
bool buildDepthMap(File f, Colorblindness cb) {
  final Image im = decodeImage(f.readAsBytesSync())!;
  Image depthMap = Image(im.width, im.height);
  // Set copunctal point
  Vector2 cp;
  switch (cb) {
    case Colorblindness.protanopia:
      cp = Vector2(0.747, 0.253);
      break;
    case Colorblindness.deuteranopia:
      cp = Vector2(1.080, -0.800);
      break;
    case Colorblindness.tritanopia:
      cp = Vector2(0.171, 0.000);
      break;
  }
  // Read image pixels
  for (int x = 0; x < im.width; x++) {
    for (int y = 0; y < im.height; y++) {
      // Retrieve RGB values
      final int p = im.getPixel(x, y);
      final Vector3 sRGB = Vector3(
          (p & 0xff) / 255, (p >> 8 & 0xff) / 255, (p >> 16 & 0xff) / 255);
      // Linearize sRGB values to sRGB'
      final Vector3 sRGBp = Vector3(
        (sRGB.x <= 0.04045)
            ? sRGB.x / 12.92
            : c_pow((sRGB.x + 0.055) / 1.055, 2.4),
        (sRGB.y <= 0.04045)
            ? sRGB.y / 12.92
            : c_pow((sRGB.y + 0.055) / 1.055, 2.4),
        (sRGB.z <= 0.04045)
            ? sRGB.z / 12.92
            : c_pow((sRGB.z + 0.055) / 1.055, 2.4),
      );
      // Transform by matrix to convert sRGB' -> CIE XYZ
      final Vector3 XYZ = toXYZ.transform(sRGBp);
      // Translate XYZ into xyY space for CIE
      final double sumXYZ = XYZ.x + XYZ.y + XYZ.z;
      Vector2 xy = Vector2(XYZ.x / sumXYZ, XYZ.y / sumXYZ);
      if (x == im.width ~/ 2 && y == im.height ~/ 2) {
        print(sRGB);
        //print(cp);
        print(xy);
        //print(insideColorspace(cp));
        //print(insideColorspace(xy));
      }
    }
  }
  List<String> splitPath = f.path.split("/");
  splitPath.last = splitPath.last.split(".").first + ".";
  final String depthMapPath = splitPath.join("/");
  return true;
}

// Gets storage directory by platform
Future<String> getStorageDirectory() async {
  if (Platform.isAndroid) {
    return (await getExternalStorageDirectory())!.path;
  } else {
    return (await getApplicationDocumentsDirectory()).path;
  }
}





/*
final Matrix3 tosRGB = Matrix3(3.2404542, -1.5371385, -0.4985314, -0.9692660,
    1.8760108, 0.0415560, 0.0556434, -0.2040259, 1.0572252);

bool insideColorspace(Vector2 xy) {
  // Get xyz from xy
  final Vector3 xyz = Vector3(xy.x, xy.y, (1 - xy.x - xy.y));
  // Convert xyz to linearized sRGB
  Vector3 sRGB = tosRGB.transform(xyz);
  // Gamma correct sRGB
  sRGB = Vector3(
      sRGB.x <= 0.0031308
          ? sRGB.x * 12.92
          : 1.055 * c_pow(sRGB.x, (1 / 2.4)) - 0.055,
      sRGB.y <= 0.0031308
          ? sRGB.y * 12.92
          : 1.055 * c_pow(sRGB.y, (1 / 2.4)) - 0.055,
      sRGB.y <= 0.0031308
          ? sRGB.y * 12.92
          : 1.055 * c_pow(sRGB.y, (1 / 2.4)) - 0.055);
  if (sRGB.x < 0.0 ||
      sRGB.x > 1.0 ||
      sRGB.y < 0.0 ||
      sRGB.y > 1.0 ||
      sRGB.z < 0.0 ||
      sRGB.z > 1.0) {
    return false;
  }
  // Check r + g + b = 1
  final double sum =
      double.parse((sRGB.x + sRGB.y + sRGB.z).toStringAsFixed(2));
  return sum == 1.0;
} 

void test() {
  File f = File(
      "/storage/emulated/0/Android/data/com.example.depth_spectrum/files/test.txt");
  if (f.existsSync()) {
    f.deleteSync();
  }
  List<Vector2> inl = <Vector2>[];
  List<Vector2> outl = <Vector2>[];
  Random rng = new Random();
  for (int i = 0; i < 1000; i++) {
    Vector2 v = Vector2(rng.nextDouble(), rng.nextDouble());
    if (insidesRGB(v)) {
      inl.add(v);
    } else {
      outl.add(v);
    }
  }
  print(inl.length);
  print(outl.length);
  for (int i = 0; i < inl.length - 1; i++) {
    f.writeAsStringSync(
        "(${double.parse(inl[i].x.toStringAsFixed(2))}, ${double.parse(inl[i].y.toStringAsFixed(2))}), ",
        mode: FileMode.append);
  }
  f.writeAsStringSync(
      "(${double.parse(inl[inl.length - 1].x.toStringAsFixed(2))}, ${double.parse(inl[inl.length - 1].y.toStringAsFixed(2))})\n",
      mode: FileMode.append);
  for (int i = 0; i < outl.length - 1; i++) {
    f.writeAsStringSync(
        "(${double.parse(outl[i].x.toStringAsFixed(2))}, ${double.parse(outl[i].y.toStringAsFixed(2))}), ",
        mode: FileMode.append);
  }
  f.writeAsStringSync(
      "(${double.parse(outl[outl.length - 1].x.toStringAsFixed(2))}, ${double.parse(outl[outl.length - 1].y.toStringAsFixed(2))})\n",
      mode: FileMode.append);
} */