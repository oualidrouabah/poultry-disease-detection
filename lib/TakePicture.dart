// ignore_for_file: sized_box_for_whitespace
import 'package:djaaja_siha/main.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class TakePicture extends StatefulWidget {
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
  bool _isRearCameraSelected = true;

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
      print('Error initializing camera: $e');
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
    onNewCameraSelected(cameras[0]);
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
      print('Error occured while taking picture: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
          title: const Text('Take Picture'),
          leading: IconButton(
            color: Theme.of(context).hintColor,
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: Theme.of(context).primaryColor,
          //rounded shape
          //shape: const RoundedRectangleBorder(
           // borderRadius: BorderRadius.only(
            //  bottomLeft: Radius.circular(10),
            //  bottomRight: Radius.circular(10),
            //),
          //)
        ),*/
      body: _isCameraInitialized
          ? SafeArea(
              child: Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: AspectRatio(
                      aspectRatio: 1 / controller!.value.aspectRatio,
                      child: controller!.buildPreview(),
                    ),
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            color: Theme.of(context).hintColor,
                            icon: const Icon(Icons.arrow_back),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          //todo here
                          //SizedBox(width: 100,),
                          DropdownButton<ResolutionPreset>(
                            dropdownColor: Colors.black87,
                            underline: Container(),
                            value: currentResolutionPreset,
                            items: [
                              for (ResolutionPreset preset in resolutionPresets)
                                DropdownMenuItem(
                                  value: preset,
                                  child: Text(
                                    preset
                                        .toString()
                                        .split('.')[1]
                                        .toUpperCase(),
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                )
                            ],
                            onChanged: (value) {
                              setState(() {
                                currentResolutionPreset = value!;
                                _isCameraInitialized = false;
                              });
                              onNewCameraSelected(controller!.description);
                            },
                            hint: const Text("Select item"),
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
                                  style: const TextStyle(color: Colors.black),
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
                      ///////////////////////////////////////77
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
                            //File imageFile = File(rawImage!.path);

                            //int currentUnix = DateTime.now().millisecondsSinceEpoch;
                            //final directory = await getApplicationDocumentsDirectory();
                            //String fileFormat = imageFile.path.split('.').last;

                            // await imageFile.copy(
                            //'${directory.path}/$currentUnix.$fileFormat',
                            //);
                          },
                          child: const Stack(
                            alignment: Alignment.center,
                            children: [
                              Icon(Icons.circle,
                                  color: Colors.white38, size: 80),
                              Icon(Icons.circle, color: Colors.white, size: 65),
                            ],
                          ),
                        )
                      ],
                    ),
                    Row(
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
                              _isCameraInitialized = false;
                            });
                            onNewCameraSelected(
                              //bool _isRearCameraSelected = true; // Define the variable _isRearCameraSelected
                              cameras[_isRearCameraSelected ? 1 : 0],
                            );
                            setState(() {
                              _isRearCameraSelected = !_isRearCameraSelected;
                            });
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
                    ],
                  ),          
                ],
              ),
            )
          : Container(),
    );
  }
}
