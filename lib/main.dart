import 'package:camera/camera.dart';
import 'package:djaaja_siha/SplashScreen.dart';
import 'package:djaaja_siha/Theme.dart';
import 'package:flutter/material.dart';

List<CameraDescription> cameras = [];
Future<void> main() async{
  try {
    WidgetsFlutterBinding.ensureInitialized();
    cameras = await availableCameras();
  } on CameraException catch (e) {
    print('Error in fetching the cameras: $e');
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Djaaja Siha',
      theme: MyTheme.lightTheme, 
      home: SplashScreen(),
    );
  }
}


