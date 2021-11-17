import 'dart:io';
import 'package:flutter/material.dart';

void createModelServer(bundle, storageDir) {
  HttpServer.bind("localhost", 8080).then((server) {
    server.listen((HttpRequest request) {
      switch (request.method) {
        case 'GET':
          _handleGet(request, bundle, storageDir);
          break;
        default:
          request.response.statusCode = HttpStatus.methodNotAllowed;
          request.response.close();
      }
    });
  });
}

void _handleGet(HttpRequest request, AssetBundle bundle, String storageDir) {
  print(request.uri.pathSegments.join("/"));
  if (request.uri.pathSegments.length == 1 ||
      request.uri.pathSegments.first != "assets") {
    _badRequest(request);
    return;
  }
  switch (request.uri.pathSegments[1]) {
    case "jslibs":
      bundle.loadString(request.uri.pathSegments.join("/")).then((data) {
        request.response.headers.contentType =
            ContentType("application", "javascript", charset: "utf-8");
        request.response.write(data);
        request.response.close();
      });
      break;
    case "textures":
      request.response.headers.contentType = ContentType.binary;
      switch (request.uri.pathSegments.last) {
        case "texture.jpg":
          final f = File(storageDir + "/lastPhoto.jpg").readAsBytes();
          request.response
              .addStream(f.asStream())
              .whenComplete(() => request.response.close());
          break;
        case "depth.jpg":
          final f = File(storageDir + "/lastPhoto-depth.jpg").readAsBytes();
          request.response
              .addStream(f.asStream())
              .whenComplete(() => request.response.close());
          break;
      }
      break;
    default:
      bundle.loadString("assets/model_viewer.html").then((data) {
        request.response.headers.contentType = ContentType.html;
        request.response.write(data);
        request.response.close();
      });
      break;
  }
}

void _badRequest(request) {
  request.response.statusCode = HttpStatus.badRequest;
  request.response.close();
}
