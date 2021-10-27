import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

const String ModelViewer = '''
<!DOCTYPE html><html>
  <head>
  </head>
  <body>
    <h1>holy shit it loaded</h1>
    <img src="https://i.kym-cdn.com/entries/icons/mobile/000/035/807/cover1.jpg"/>
  </body>
</html>
''';

class DisplayPage extends StatefulWidget {
  @override
  _DisplayPageState createState() => _DisplayPageState();
}

class _DisplayPageState extends State<DisplayPage> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Builder(builder: (BuildContext context) {
      return WebView(onWebViewCreated: (WebViewController webViewController) {
        final String ModelViewerBase64 =
            base64Encode(const Utf8Encoder().convert(ModelViewer));
        webViewController.loadUrl('data:text/html;base64,$ModelViewerBase64');
        _controller.complete(webViewController);
      });
    }));
  }
}
