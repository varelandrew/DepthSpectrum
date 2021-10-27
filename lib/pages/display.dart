import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

const String modelViewer = '''
<!DOCTYPE html>
<html>
  <head>
    <style>
      html, body {
        overflow: hidden;
        width: 100%;
        height: 100%;
        margin: 0;
        padding: 0;
      }
      #renderCanvas {
        width: 100%;
        height: 100%;
        touch-action: none;
      }
    </style>
    <script src="https://cdn.babylonjs.com/babylon.js"></script>
    <script src="https://cdn.babylonjs.com/loaders/babylonjs.loaders.min.js"></script>
    <script src="https://code.jquery.com/pep/0.4.3/pep.js"></script>
  </head>
  <body>
    <canvas id="renderCanvas" touch-action="none"></canvas>
    <script>
      const canvas = document.getElementById("renderCanvas");
      const engine = new BABYLON.Engine(canvas, true);
      const createScene = function() {
        const scene = new BABYLON.Scene(engine);
        BABYLON.SceneLoader.ImportMeshAsync("", "https://assets.babylonjs.com/meshes/", "box.babylon");
        const camera = new BABYLON.ArcRotateCamera("camera", -Math.PI / 2, Math.PI / 2.5, 15, new BABYLON.Vector3(0, 0, 0));
        camera.attachControl(canvas, true);
        const light = new BABYLON.HemisphericLight("light", new BABYLON.Vector3(1, 1, 0));
        return scene;
      }
      const scene = createScene();
      engine.runRenderLoop(function () {
        scene.render();
      });
      window.addEventListener("resize", function () {
        engine.resize();  
      });
    </script> 
  </body>
</html>
''';

class DisplayPage extends StatefulWidget {
  const DisplayPage({Key? key}) : super(key: key);

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
    return Scaffold(
        appBar: AppBar(
          leading: const Icon(Icons.auto_graph),
          title: const Text("Model Viewer"),
          backgroundColor: const Color(0xFFD05353),
        ),
        body: Builder(builder: (BuildContext context) {
          return WebView(
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) {
                final String modelViewerBase64 =
                    base64Encode(const Utf8Encoder().convert(modelViewer));
                webViewController
                    .loadUrl('data:text/html;base64,$modelViewerBase64');
                _controller.complete(webViewController);
              });
        }));
  }
}
