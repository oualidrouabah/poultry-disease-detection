// ignore_for_file: use_build_context_synchronously

import 'package:djaaja_siha/home_screen.dart';
import 'package:djaaja_siha/no_connection_screen.dart';
import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
     // checkConnection(context);
     Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>const HomeScreen()),
      );
    });    
  }

  Future<void> checkConnection(BuildContext context) async {
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
 /* Future<void> checkConnection_v2 (BuildContext context) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>const HomeScreen()),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>const NoConnectionScreen()),
      );
    }
  }*/

  
  @override
  Widget build(BuildContext context) {   
    return Scaffold(
      key: _scaffoldKey,
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
            })
          ],
        ),
      ),
    );
  }
}
