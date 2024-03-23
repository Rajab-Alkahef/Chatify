// // import 'dart:io';

// // import 'package:camera/camera.dart';
// // import 'package:flutter/material.dart';

// // class TakePictureScreen extends StatefulWidget {
// //   final CameraDescription camera;

// //   const TakePictureScreen({super.key, required this.camera});

// //   @override
// //   _TakePictureScreenState createState() => _TakePictureScreenState();
// // }

// // class _TakePictureScreenState extends State<TakePictureScreen> {
// //   late CameraController _controller;
// //   Future<void>? _initializeControllerFuture;

// //   @override
// //   void initState() {
// //     print("widget.camera: ${widget.camera}");
// //     super.initState();
// //     _controller = CameraController(
// //       widget.camera,
// //       ResolutionPreset.medium,
// //     );
// //     _initializeControllerFuture = _controller.initialize();
// //   }

// //   @override
// //   void dispose() {
// //     _controller.dispose();
// //     super.dispose();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: const Text('Camera Example')),
// //       body: FutureBuilder<void>(
// //         future: _initializeControllerFuture,
// //         builder: (context, snapshot) {
// //           if (snapshot.connectionState == ConnectionState.done) {
// //             return CameraPreview(_controller);
// //           } else {
// //             return const Center(child: CircularProgressIndicator());
// //           }
// //         },
// //       ),
// //       floatingActionButton: FloatingActionButton(
// //         onPressed: () async {
// //           try {
// //             print("widget.camera: ${widget.camera}");
// //             await _initializeControllerFuture;
// //             final image = await _controller.takePicture();
// //             Image.file(File(image.path));
// //             // Handle the captured image (e.g., display it or save it).
// //             // You can use Image.file(File(image.path)) to display the image.
// //           } catch (e) {
// //             print('Error taking picture: $e');
// //           }
// //         },
// //         child: const Icon(Icons.camera),
// //       ),
// //     );
// //   }
// // }

// import 'dart:io';

// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:gallery_saver/gallery_saver.dart';
// import 'package:path/path.dart' as path;
// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';

// class MainScreen extends StatefulWidget {
//   const MainScreen({super.key});

//   @override
//   State<MainScreen> createState() => _MainScreenState();
// }

// class _MainScreenState extends State<MainScreen> {
//   late List<CameraDescription> cameras;
//   late CameraController cameraController;

//   int direction = 0;

//   @override
//   void initState() {
//     startCamera(direction);
//     super.initState();
//   }

//   void startCamera(int direction) async {
//     cameras = await availableCameras();

//     cameraController = CameraController(
//       cameras[direction],
//       ResolutionPreset.high,
//       enableAudio: false,
//     );

//     await cameraController.initialize().then((value) {
//       if (!mounted) {
//         return;
//       }
//       setState(() {}); //To refresh widget
//     }).catchError((e) {
//       print(e);
//     });
//   }

//   @override
//   void dispose() {
//     cameraController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (cameraController.value.isInitialized) {
//       return Scaffold(
//         body: Stack(
//           children: [
//             CameraPreview(cameraController),
//             GestureDetector(
//               onTap: () {
//                 setState(() {
//                   direction = direction == 0 ? 1 : 0;
//                   startCamera(direction);
//                 });
//               },
//               child:
//                   button(Icons.flip_camera_ios_outlined, Alignment.bottomLeft),
//             ),
//             GestureDetector(
//               onTap: () async {
//                 // final XFile image = await cameraController.takePicture();
//                 // final Directory directory =
//                 //     await getApplicationDocumentsDirectory();
//                 // // await getExternalStorageDirectory();
//                 // final String downloadPath =
//                 //     path.join(directory.path, 'Download');
//                 // // Check if 'Download' directory exists
//                 // final Directory downloadDirectory = Directory(downloadPath);
//                 // if (!await downloadDirectory.exists()) {
//                 //   await downloadDirectory.create(
//                 //       recursive: true); // Create if it doesn't exist
//                 // }
//                 // final String imagePath =
//                 //     path.join(downloadPath, 'YourImageName.jpg');

//                 // // Save the image to the specified path
//                 // File savedImage = File(image.path);
//                 // print(savedImage);
//                 // await savedImage.copy(imagePath);
//                 // print(imagePath);
//                 // // .then((XFile? file) {
//                 // //   if (mounted) {
//                 // //     if (file != null) {
//                 // //       print("Picture saved to ${file.path}");
//                 // //     }
//                 // //   }
//                 // // });
//                 final XFile image = await cameraController.takePicture();

//                 // Check for storage permissions
//                 await _checkPermission();

//                 // Get the directory path for saving the image
//                 final String downloadsDirectoryPath =
//                     (await getExternalStorageDirectory())!.path;
//                 final String imagePath =
//                     path.join(downloadsDirectoryPath, 'YourImageName.jpg');
//                 print(imagePath);

//                 // Save the image to the specified path
//                 File savedImage = File(imagePath);
//                 await savedImage.create(recursive: true);
//                 await savedImage.writeAsBytes(await image.readAsBytes());
//               },
//               child: button(Icons.camera_alt_outlined, Alignment.bottomCenter),
//             ),
//             const Align(
//               alignment: AlignmentDirectional.topCenter,
//               child: Text(
//                 "My Camera",
//                 style: TextStyle(
//                   fontSize: 30,
//                 ),
//               ),
//             ),
//           // ]
//         ),
//       );
//     } else {
//       return const SizedBox();
//     }
//   }

//   Widget button(IconData icon, Alignment alignment) {
//     return Align(
//       alignment: alignment,
//       child: Container(
//         margin: const EdgeInsets.only(
//           left: 20,
//           bottom: 20,
//         ),
//         height: 50,
//         width: 50,
//         decoration: const BoxDecoration(
//           shape: BoxShape.circle,
//           color: Colors.white,
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black26,
//               offset: Offset(2, 2),
//               blurRadius: 10,
//             ),
//           ],
//         ),
//         child: Center(
//           child: Icon(
//             icon,
//             color: Colors.black54,
//           ),
//         ),
//       ),
//     );
//   }
// }

// Future<void> _checkPermission() async {
//   var status = await Permission.storage.status;
//   if (!status.isGranted) {
//     await Permission.storage.request();
//   }
// }
