import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:depth_spectrum/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:image/image.dart';

class Display extends StatefulWidget {
  const Display({Key? key}) : super(key: key);
  //Display(tPath, dPath, {Key? key}) : super(key: key) {
  //  texPath = tPath;
  //  dispPath = dPath;
  //}
  //late String texPath;
  //late String dispPath;

  @override
  _DisplayState createState() => _DisplayState();
}

class _DisplayState extends State<Display> {
  final GlobalKey webViewKey = GlobalKey();
  InAppWebViewController? webViewController;
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: false,
      ),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.auto_graph),
        title: const Text("Model Viewer"),
        backgroundColor: DSColors.red,
      ),
      body: InAppWebView(
        key: webViewKey,
        initialUrlRequest: URLRequest(
          url: Uri.parse("http://localhost:8080/assets/model_viewer.html"),
        ),
        initialOptions: options,
        onWebViewCreated: (controller) {
          webViewController = controller;
        },
        onLoadStop: (controller, uri) {},
      ),
    );
  }
}

/*
Uri parseUrlParams() {
  final tFile = File(widget.texPath);
  final tImage = decodeImage(tFile.readAsBytesSync())!;
  final int width = tImage.width;
  final int height = tImage.height;
  final tBytes = File(widget.texPath).readAsBytesSync();
  final String tEncoded = Uri.encodeComponent(base64Encode(tBytes));
  final dBytes = File(widget.dispPath).readAsBytesSync();
  final String dEncoded = Uri.encodeComponent(base64Encode(dBytes));
  return Uri.parse(
      "https://localhost:8080/assets/model_viewer.html?tex=${tEncoded}&disp=${dEncoded}&width=${width}&height=${height}");
} 

final tFile = File(widget.texPath);
final tImage = decodeImage(tFile.readAsBytesSync())!;
final int width = tImage.width;
final int height = tImage.height;
final tBytes = File(widget.texPath).readAsBytesSync();
final String tEncoded = Uri.encodeComponent(base64Encode(tBytes));
final dBytes = File(widget.dispPath).readAsBytesSync();
final String dEncoded = Uri.encodeComponent(base64Encode(dBytes));
final data = Uint8List.fromList(utf8.encode(
    "tex=${tEncoded}&disp=${dEncoded}&width=${width}&height=${height}"));
controller.postUrl(
    url: Uri.parse("http://localhost:8080/assets/model_viewer.html"),
    postData: data);
*/