// ignore_for_file: deprecated_member_use

import 'dart:developer';
import 'package:camera/camera.dart';
import 'package:djaaja_siha/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'authentification/user_provide.dart';
import 'my_app.dart';

List<CameraDescription> cameras = [];

    
Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  try {
    cameras = await availableCameras();
  } on CameraException catch (e) {
    log('Error in fetching the cameras: $e');
  }
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  //FirebaseAuth.instance.setPersistence(Persistence.LOCAL);
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: const MyApp(),
    ),);
}