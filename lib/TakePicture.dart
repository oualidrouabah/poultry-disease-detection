import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class TakePicture extends StatefulWidget {
  final List<CameraDescription>? cameras;

  const TakePicture({Key? key, required this.cameras}) : super(key: key);
  @override
  _TakePictureState createState() => _TakePictureState();
}

class _TakePictureState extends State<TakePicture> {
  late CameraController _cameraController;

  Future initCamera(CameraDescription cameraDescription) async {
    _cameraController =
        CameraController(cameraDescription, ResolutionPreset.high);
    try {
      await _cameraController.initialize().then((_) {
        if (!mounted) return;
        setState(() {});
      });
    } on CameraException catch (e) {
      debugPrint("camera error $e");
    }
  }

  @override
  void initState() {
    super.initState();
    initCamera(widget.cameras![0]);
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
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
        ),
        body: Stack(
          children:[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: _cameraController.value.isInitialized
                  ? CameraPreview(_cameraController)
                  : const Center(child: CircularProgressIndicator(
                    color: Color(0xFF0fc09c),
                    backgroundColor: Color(0xffe5eee9),
                    strokeWidth: 5,
                  )
                  ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: FloatingActionButton(
                      backgroundColor: Theme.of(context).primaryColor,
                      onPressed: () async {
                        /*try {
                          await _cameraController.takePicture().then((value) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => DisplayPicture(imagePath: value.path)));
                          });
                        } catch (e) {
                          debugPrint("error $e");
                        }*/
                      },
                      child: Builder(
                        builder: (context) {
                          return Icon(Icons.camera_alt, color: Theme.of(context).hintColor,);
                        }
                      ),
                      
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
    );
  }
}
