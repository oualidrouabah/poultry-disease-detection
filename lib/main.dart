import 'package:djaaja_siha/SplashScreen.dart';
import 'package:djaaja_siha/Theme.dart';
import 'package:flutter/material.dart';

main() {
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


