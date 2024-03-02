// ignore_for_file: use_build_context_synchronously

import 'package:djaaja_siha/HomeScreen.dart';
import 'package:djaaja_siha/NoConnectionScreen.dart';
import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      checkConnection();
    });    
  }

  Future<void> checkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>const NoConnectionScreen()),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>const HomeScreen()),
      );
    }
  }
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Theme.of(context).hintColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(
              image: AssetImage('assets/logo.png'),
              width: 300,
              height: 300,
            ),
            const SizedBox(height: 70),
            Builder(builder: (context) {
              return CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
              );
            }
            )
          ],
        ),
      ),
    );
  }
}
