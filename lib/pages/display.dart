import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Display extends StatefulWidget {
  const Display({Key? key}) : super(key: key);

  @override
  _DisplayState createState() => _DisplayState();
}

class _DisplayState extends State<Display> {
  late WebViewController _controller;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: const Icon(Icons.auto_graph),
          title: const Text("Model Viewer"),
        ),
        body: Builder(builder: (BuildContext context) {
          return WebView(
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              _controller = webViewController;
              _loadModelViewerFromAssets();
            },
            onWebResourceError: (WebResourceError webViewErr) {
              debugPrint('Error: ${webViewErr.description}');
            },
          );
        }));
  }

  _loadModelViewerFromAssets() async {
    String fileText = await rootBundle.loadString("assets/model_viewer.html");
    _controller.loadUrl(Uri.dataFromString(fileText,
            mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
        .toString());
  }
}
