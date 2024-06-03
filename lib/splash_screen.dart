// ignore_for_file: use_build_context_synchronously, unused_import

import 'package:djaaja_siha/home_screen.dart';
import 'package:djaaja_siha/login_screen.dart';
import 'package:djaaja_siha/no_connection_screen.dart';
import 'package:djaaja_siha/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

import 'authentification/user_model.dart';
import 'authentification/user_provide.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  
  Future<UserModel?> getUserModel() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString('userModel');
    if (userJson != null) {
      return UserModel.fromJson(userJson);
    }
    return null;
  }

  
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () async {
      UserModel? user = await getUserModel();
      print(user);
      Provider.of<UserProvider>(context, listen: false).setUser(user);
      if (user == null){
        print("user null");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) =>const Login()),
        );
        return;
      } 
      print("user not null");    
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) =>const HomeScreen()),
      );
    });    
  }

  Future<void> checkConnection(BuildContext context) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) =>const NoConnectionScreen()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) =>const HomeScreen()),
      );
    }
  }
 /* Future<void> checkConnection_v2 (BuildContext context) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) =>const HomeScreen()),
      );
    } else {
      Navigator.pushReplacement(
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
