// ignore_for_file: sized_box_for_whitespace, use_build_context_synchronously, library_private_types_in_public_api
import 'dart:developer';
import 'dart:io';
import 'package:djaaja_siha/main.dart';
import 'package:djaaja_siha/result_screen.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TakePicture extends StatefulWidget {
  const TakePicture({super.key});

  @override
  _TakePictureState createState() => _TakePictureState();
}

class _TakePictureState extends State<TakePicture> with WidgetsBindingObserver {
  CameraController? controller;
  bool _isCameraInitialized = false;
  final resolutionPresets = ResolutionPreset.values;
  ResolutionPreset currentResolutionPreset = ResolutionPreset.high;
  double _minAvailableZoom = 1.0;
  double _maxAvailableZoom = 1.0;
  double _currentZoomLevel = 1.0;
  double _minAvailableExposureOffset = 0.0;
  double _maxAvailableExposureOffset = 0.0;
  double _currentExposureOffset = 0.0;
  FlashMode? _currentFlashMode;
  bool _isCameraPermissionGranted = false;
  

  void onNewCameraSelected(CameraDescription cameraDescription) async {
    final previousCameraController = controller;
    final CameraController cameraController = CameraController(
      cameraDescription,
      currentResolutionPreset,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );
    // Dispose the previous controller
    await previousCameraController?.dispose();

    // Replace with the new controller
    if (mounted) {
      setState(() {
        controller = cameraController;
      });
    }

    // Update UI if controller updated
    cameraController.addListener(() {
      if (mounted) setState(() {});
    });

    // Initialize controller
    try {
      await cameraController.initialize();
    } on CameraException catch (e) {
      log('Error initializing camera: $e');
    }

    // Update the Boolean
    if (mounted) {
      setState(() {
        _isCameraInitialized = controller!.value.isInitialized;
      });
    }
    cameraController
        .getMaxZoomLevel()
        .then((value) => _maxAvailableZoom = value);
    cameraController
        .getMinZoomLevel()
        .then((value) => _minAvailableZoom = value);
    cameraController
        .getMinExposureOffset()
        .then((value) => _minAvailableExposureOffset = value);
    cameraController
        .getMaxExposureOffset()
        .then((value) => _maxAvailableExposureOffset = value);
    _currentFlashMode = controller!.value.flashMode;
  }

  @override
  void initState() {
    getPermissionStatus();
    super.initState();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController? cameraController = controller;

    // App state changed before we got the chance to initialize.
    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      // Free up memory when camera not active
      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      // Reinitialize the camera with same properties
      onNewCameraSelected(cameraController.description);
    }
  }

  Future<XFile?> takePicture() async {
    final CameraController? cameraController = controller;
    if (cameraController!.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return null;
    }
    try {
      XFile file = await cameraController.takePicture();
      return file;
    } on CameraException catch (e) {
      log('Error occured while taking picture: $e');
      return null;
    }
  }

  void onViewFinderTap(TapDownDetails details, BoxConstraints constraints) {
    if (controller == null) {
      return;
    }
    final offset = Offset(
      details.localPosition.dx / constraints.maxWidth,
      details.localPosition.dy / constraints.maxHeight,
    );
    controller!.setExposurePoint(offset);
    controller!.setFocusPoint(offset);
  }

  getPermissionStatus() async {
    await Permission.camera.request();
    var status = await Permission.camera.status;
    if (status.isGranted) {
      log('Camera Permission: GRANTED');
      setState(() {
        _isCameraPermissionGranted = true;
      });
      // Set and initialize the new camera
      onNewCameraSelected(cameras[0]);
      //refreshAlreadyCapturedImages();
    } else {
      log('Camera Permission: DENIED');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isCameraInitialized
          ? _isCameraPermissionGranted
              ? SafeArea(
                  child: Stack(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: AspectRatio(
                          aspectRatio: 1 / controller!.value.aspectRatio,
                          child: controller!.buildPreview(),
                          /*
                          CameraPreview(
                          controller!,
                          child: LayoutBuilder(builder:
                              (BuildContext context, BoxConstraints constraints) {
                            return GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTapDown: (details) =>
                                  onViewFinderTap(details, constraints),
                            );
                          }),
                        )
                       */
                        ),
                      ),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              IconButton(
                                color: Theme.of(context).hintColor,
                                icon: const Icon(Icons.arrow_back),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                              
                            ],
                          ), ////////////////////////////////////
                          Container(
                            alignment: Alignment.bottomRight,
                            padding: const EdgeInsets.all(10.0),
                            //color: Colors.black87,
                            height: MediaQuery.of(context).size.height * 0.6,
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      '${_currentExposureOffset.toStringAsFixed(1)}x',
                                      style:
                                          const TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: RotatedBox(
                                    quarterTurns: 3,
                                    child: Container(
                                      height: 30,
                                      child: Slider(
                                        value: _currentExposureOffset,
                                        min: _minAvailableExposureOffset,
                                        max: _maxAvailableExposureOffset,
                                        activeColor: Colors.white,
                                        inactiveColor: Colors.white30,
                                        onChanged: (value) async {
                                          setState(() {
                                            _currentExposureOffset = value;
                                          });
                                          await controller!
                                              .setExposureOffset(value);
                                        },
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          ///////////////////////////////////////
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.black87,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    '${_currentZoomLevel.toStringAsFixed(1)}x',
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Slider(
                                  value: _currentZoomLevel,
                                  min: _minAvailableZoom,
                                  max: _maxAvailableZoom,
                                  activeColor: Colors.white,
                                  inactiveColor: Colors.white30,
                                  onChanged: (value) async {
                                    setState(() {
                                      _currentZoomLevel = value;
                                    });
                                    await controller!.setZoomLevel(value);
                                  },
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () async {
                                  XFile? rawImage = await takePicture();
                                  File imageFile = File(rawImage!.path);
                                  //print(imageFile.toString());
                                  //print(
                                    //  "taken image ################################################################################################");
                                  //show the taken image
                                  //setState(() {
                                    //_takenImage = rawImage;
                                  //});
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => ShowTakenImg(
                                              imgPath: imageFile.path)));
                                },
                                child: const Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Icon(Icons.circle,
                                        color: Colors.white38, size: 80),
                                    Icon(Icons.circle,
                                        color: Colors.white, size: 65),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () async {
                                    setState(() {
                                      _currentFlashMode = FlashMode.off;
                                    });
                                    await controller!.setFlashMode(
                                      FlashMode.off,
                                    );
                                  },
                                  child: Icon(
                                    Icons.flash_off,
                                    color: _currentFlashMode == FlashMode.off
                                        ? Colors.amber
                                        : Colors.white,
                                  ),
                                ),
                                InkWell(
                                  onTap: () async {
                                    setState(() {
                                      _currentFlashMode = FlashMode.auto;
                                    });
                                    await controller!.setFlashMode(
                                      FlashMode.auto,
                                    );
                                  },
                                  child: Icon(
                                    Icons.flash_auto,
                                    color: _currentFlashMode == FlashMode.auto
                                        ? Colors.amber
                                        : Colors.white,
                                  ),
                                ),
                                InkWell(
                                  onTap: () async {
                                    setState(() {
                                      _currentFlashMode = FlashMode.always;
                                    });
                                    await controller!.setFlashMode(
                                      FlashMode.always,
                                    );
                                  },
                                  child: Icon(
                                    Icons.flash_on,
                                    color: _currentFlashMode == FlashMode.always
                                        ? Colors.amber
                                        : Colors.white,
                                  ),
                                ),
                                InkWell(
                                  onTap: () async {
                                    setState(() {
                                      _currentFlashMode = FlashMode.torch;
                                    });
                                    await controller!.setFlashMode(
                                      FlashMode.torch,
                                    );
                                  },
                                  child: Icon(
                                    Icons.highlight,
                                    color: _currentFlashMode == FlashMode.torch
                                        ? Colors.amber
                                        : Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                        Text(
                          AppLocalizations.of(context)!.permissiondenied,
                        style:const TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 16),
                      Builder(builder: (context) {
                        return ElevatedButton(
                          onPressed: () {
                            getPermissionStatus();
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            backgroundColor: Theme.of(context).primaryColor,
                            //minimumSize: Size(100, 50),
                            fixedSize: const Size(190, 50),
                          ),
                          child: Text(
                            AppLocalizations.of(context)!.getperm,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        );
                      }),
                    ],
                  ),
                )
          : Container(
              color: Theme.of(context).hintColor,
              child: Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                ),
              ),
            ),
    );
  }
}

class ShowTakenImg extends StatefulWidget {
  const ShowTakenImg({super.key, required this.imgPath});
  final String imgPath;
  @override
  State<ShowTakenImg> createState() => _ShowTakenImgState();
}

class _ShowTakenImgState extends State<ShowTakenImg> {
  String? imgPath;
  
  @override
  void initState() {
    super.initState();
    imgPath = widget.imgPath;
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Image.file(
            File(imgPath!),
            fit: BoxFit.cover,
          ),
        ),
        Column(mainAxisAlignment: MainAxisAlignment.end, children: [
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    backgroundColor: Theme.of(context).primaryColor,
                    //minimumSize: Size(100, 50),
                    fixedSize: const Size(200, 70),
                  ),
                  child: Icon(
                    Icons.refresh_outlined,
                    color: Theme.of(context).hintColor,
                    size: 50,
                  ),
                ),
                const SizedBox(
                  width: 30,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>  Result(image: imgPath!)
                      )
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    backgroundColor: Theme.of(context).primaryColor,
                    fixedSize: const Size(200, 70),
                  ),
                  child: Icon(
                    Icons.check,
                    color: Theme.of(context).hintColor,
                    size: 50,
                  ),
                ),
              ],
            ),
          ),
        ])
      ],
    );
  }
}
