import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class TakePictureScreen extends StatefulWidget {
  final CameraDescription camera;

  const TakePictureScreen({super.key, required this.camera});

  @override
  _TakePictureScreenState createState() => _TakePictureScreenState();
}

class _TakePictureScreenState extends State<TakePictureScreen> {
  late CameraController _controller;
  Future<void>? _initializeControllerFuture;

  @override
  void initState() {
    print("widget.camera: ${widget.camera}");
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Camera Example')),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            print("widget.camera: ${widget.camera}");
            await _initializeControllerFuture;
            final image = await _controller.takePicture();
            Image.file(File(image.path));
            // Handle the captured image (e.g., display it or save it).
            // You can use Image.file(File(image.path)) to display the image.
          } catch (e) {
            print('Error taking picture: $e');
          }
        },
        child: const Icon(Icons.camera),
      ),
    );
  }
}
