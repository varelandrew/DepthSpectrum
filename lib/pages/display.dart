import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:depth_spectrum/theme/colors.dart';

const String modelViewer = '''
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

        <title>Babylon.js sample code</title>

        <!-- Babylon.js -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/dat-gui/0.6.2/dat.gui.min.js"></script>
        <script src="https://preview.babylonjs.com/ammo.js"></script>
        <script src="https://preview.babylonjs.com/cannon.js"></script>
        <script src="https://preview.babylonjs.com/Oimo.js"></script>
        <script src="https://preview.babylonjs.com/earcut.min.js"></script>
        <script src="https://preview.babylonjs.com/babylon.js"></script>
        <script src="https://preview.babylonjs.com/materialsLibrary/babylonjs.materials.min.js"></script>
        <script src="https://preview.babylonjs.com/proceduralTexturesLibrary/babylonjs.proceduralTextures.min.js"></script>
        <script src="https://preview.babylonjs.com/postProcessesLibrary/babylonjs.postProcess.min.js"></script>
        <script src="https://preview.babylonjs.com/loaders/babylonjs.loaders.js"></script>
        <script src="https://preview.babylonjs.com/serializers/babylonjs.serializers.min.js"></script>
        <script src="https://preview.babylonjs.com/gui/babylon.gui.min.js"></script>
        <script src="https://preview.babylonjs.com/inspector/babylon.inspector.bundle.js"></script>

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
    </head>
<body>
    <canvas id="renderCanvas"></canvas>
    <script>
        var canvas = document.getElementById("renderCanvas");

        var engine = null;
        var scene = null;
        var sceneToRender = null;
        var createDefaultEngine = function() { return new BABYLON.Engine(canvas, true, { preserveDrawingBuffer: true, stencil: true,  disableWebGL2Support: false}); };
        var createScene = function () {
        
            // This creates a basic Babylon Scene object (non-mesh)
            var scene = new BABYLON.Scene(engine);
        
            // This creates and positions a free camera (non-mesh)
            var camera = new BABYLON.ArcRotateCamera("camera1", 0, Math.PI / 2, 100, new BABYLON.Vector3(0, 0, 0), scene);
        	camera.attachControl(canvas, false);
        
            // This targets the camera to scene origin
            camera.setTarget(BABYLON.Vector3.Zero());
        
            // This creates a light, aiming 0,1,0 - to the sky (non-mesh)
            var light = new BABYLON.HemisphericLight("light1", new BABYLON.Vector3(0, 1, 0), scene);
        
            // Default intensity is 1. Let's dim the light a small amount
            light.intensity = 0.7;
        
            var mesh = BABYLON.Mesh.CreateBox("box01", 50, scene);
            mesh.position = new BABYLON.Vector3(0, 0, 0);
        
        	var brickWallDiffURL = "http://i.imgur.com/Rkh1uFK.png";
        	var brickWallNHURL = "http://i.imgur.com/GtIUsWW.png";
        	var stoneDiffURL = "http://i.imgur.com/VSbN3Fc.png";
        	var stoneNHURL = "http://i.imgur.com/zVGaZNi.png";
        
            var stoneDiffuseTexture = new BABYLON.Texture(stoneDiffURL, scene);
            var stoneNormalsHeightTexture = new BABYLON.Texture(stoneNHURL, scene);
            var wallDiffuseTexture = new BABYLON.Texture(brickWallDiffURL, scene);
            var wallNormalsHeightTexture = new BABYLON.Texture(brickWallNHURL, scene);
        	var normalsHeightTexture = stoneNormalsHeightTexture;
        
            var material = new BABYLON.StandardMaterial("mtl01", scene);
            material.diffuseTexture = stoneDiffuseTexture;
            material.bumpTexture = stoneNormalsHeightTexture;
            material.useParallax = true;
            material.useParallaxOcclusion = true;
            material.parallaxScaleBias = 0.1;
            material.specularPower = 1000.0;
        	material.specularColor = new BABYLON.Color3(0.5, 0.5, 0.5);
            mesh.material = material;
        
        	var configObject = {
        		scaleBias: 0.1,
        		renderMode: "Parallax Occlusion",
        		texture: "Stone"
        	}
        	
        	var oldgui = document.querySelector("#datGUI");
        	if (oldgui != null)
        	{
        		oldgui.remove();
        	}
        	
        	var gui = new dat.GUI();	
        	gui.domElement.style.marginTop = "50px";
        	gui.domElement.id = "datGUI";
        	
        	gui.add(configObject, 'scaleBias', 0.01, 0.2).onChange(function(value) {
        		material.parallaxScaleBias = value;
        	});
        	
        	gui.add(configObject, 'renderMode', ['Parallax Occlusion', 'Parallax', 'Bump', "Flat"])
        		.onChange(function (value) {
        			switch (value) {
        	            case "Flat":
        	                material.bumpTexture = null;
        	                break;
        	            case "Bump":
        	                material.bumpTexture = normalsHeightTexture;
        	                material.useParallax = false;
        	                break;
        	            case "Parallax":
        	                material.bumpTexture = normalsHeightTexture;
        	                material.useParallax = true;
        	                material.useParallaxOcclusion = false;
        	                break;
        	            case "Parallax Occlusion":
        	                material.bumpTexture = normalsHeightTexture;
        	                material.useParallax = true;
        	                material.useParallaxOcclusion = true;
        	                break;
        			}
        	});
        
        	gui.add(configObject, 'texture', ["stone", "wall"])
        		.onChange(function (value) {
        			switch (value) {
        				case "stone":
        					material.diffuseTexture = stoneDiffuseTexture;
        					normalsHeightTexture = stoneNormalsHeightTexture;
        					break;
        				case "wall":
        					material.diffuseTexture = wallDiffuseTexture;
        					normalsHeightTexture = wallNormalsHeightTexture;
        					break;
        			}
        			material.bumpTexture = normalsHeightTexture;
        	});
        	
            return scene;
        
        };
                window.initFunction = async function() {
                    
                    
                    var asyncEngineCreation = async function() {
                        try {
                        return createDefaultEngine();
                        } catch(e) {
                        console.log("the available createEngine function failed. Creating the default engine instead");
                        return createDefaultEngine();
                        }
                    }

                    window.engine = await asyncEngineCreation();
        if (!engine) throw 'engine should not be null.';
        window.scene = createScene();};
        initFunction().then(() => {sceneToRender = scene        
            engine.runRenderLoop(function () {
                if (sceneToRender && sceneToRender.activeCamera) {
                    sceneToRender.render();
                }
            });
        });

        // Resize
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
          backgroundColor: DSColors.darkred,
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
            },
            onWebResourceError: (WebResourceError webViewErr) {
              print('Error: ${webViewErr.description}');
            },
          );
        }));
  }
}
