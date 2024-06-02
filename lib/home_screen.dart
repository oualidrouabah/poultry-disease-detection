// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'package:camera/camera.dart';
import 'package:djaaja_siha/about.dart';
import 'package:djaaja_siha/diseases_lib.dart';
import 'package:djaaja_siha/langage_constant.dart';
import 'package:djaaja_siha/login_screen.dart';
import 'package:djaaja_siha/my_app.dart';
import 'package:djaaja_siha/take_picture.dart';
import 'package:djaaja_siha/upload_picture.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'dart:ui' as ui;
import 'authentification/auth_service.dart';
import 'authentification/user_provide.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final AuthService _authService = AuthService();

  _getWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }
  
  @override
  Widget build(BuildContext context) {
    final buttonWidth= _getWidth(context)*0.4;
    var user = Provider.of<UserProvider>(context).user;
    
    return Scaffold(
      backgroundColor: Theme.of(context).hintColor,
      key: _scaffoldKey,
      drawer: cstmDrawer(context, user),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment(
                0.8, 0.0), // 10% of the width, so there are ten blinds.
            colors: [
              Color.fromARGB(31, 255, 255, 255),
              Color.fromARGB(38, 0, 238, 107)
            ], // red to yellow
            tileMode: TileMode.mirror, // repeats the gradient over the canvas
          ),
        ),
        child: SafeArea(
          child: Container(
            margin: const EdgeInsets.only(top: 18, left: 24, right: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      translation(context).title,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Color.fromARGB(255, 0, 168, 132),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    RotatedBox(
                      quarterTurns: 135,
                      child: IconButton(
                        icon: const Icon(Icons.bar_chart_rounded),
                        color: const Color.fromARGB(255, 0, 168, 132),
                        iconSize: 25,
                        onPressed: () =>
                            _scaffoldKey.currentState?.openDrawer(),
                      ),
                    )
                  ],
                ),
                Expanded(
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      const SizedBox(height: 5),
                      Center(
                        child: Image.asset(
                          'assets/logo.png',
                          scale: MediaQuery.of(context).size.width*0.002,
                        ),
                      ),
                      const SizedBox(height: 1),
                      Center(
                        child: Text(
                          AppLocalizations.of(context)!.wlcmtext,
                          textAlign: TextAlign.center,
                          style:TextStyle(
                              fontSize: MediaQuery.of(context).size.width*0.04,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(255, 0, 168, 132),
                          ),
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height*0.05),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconButton(
                              onPressed: () async {
                                await availableCameras().then((value) =>
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                const TakePicture())));
                              },
                              style: ButtonStyle(
                                  fixedSize:MaterialStatePropertyAll(Size(buttonWidth, buttonWidth)),
                                  padding: MaterialStateProperty.all(
                                      const EdgeInsets.only(
                                          top: 20,
                                          bottom: 20,
                                          left: 18,
                                          right: 18)),
                                  backgroundColor: MaterialStateProperty.all(
                                      const Color.fromARGB(255, 0, 168, 132)),
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30)
                                      )
                                    )
                              ),
                              icon: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.camera_alt,
                                    size: buttonWidth*0.4,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    AppLocalizations.of(context)!.takepics,
                                    style: TextStyle(
                                      color: Colors.white, 
                                      fontSize: buttonWidth*0.1
                                    ),
                                  )
                                ],
                              )),
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => const Upload()
                                    )
                                );
                              },
                              style: ButtonStyle(
                                  fixedSize:MaterialStatePropertyAll(Size(buttonWidth, buttonWidth)),
                                  padding: MaterialStateProperty.all(
                                      const EdgeInsets.only(
                                          top: 20,
                                          bottom: 20,
                                          left: 18,
                                          right: 18
                                      )
                                  ),
                                  backgroundColor: MaterialStateProperty.all(
                                      const Color.fromARGB(255, 0, 168, 132)),
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30)))),
                              icon: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.upload,
                                    size: buttonWidth*0.4,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    AppLocalizations.of(context)!.uploadpics,
                                    style: TextStyle(
                                      color: Colors.white, 
                                      fontSize: buttonWidth*0.1
                                    ),
                                  )
                                ],
                              )
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  cstmDrawer(BuildContext context, user) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 45,
                    backgroundColor: Theme.of(context).hintColor,
                    child: ClipOval(
                      child: Image.asset(
                        'assets/logo.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Text(
                    "Welcome ${user.name}",
                    style: TextStyle(
                        fontSize: 20,
                        color: Theme.of(context).hintColor,
                        fontWeight: FontWeight.bold,
                      ),
                  ),
                ],
              )),
          ListTile(
            leading: const Icon(Icons.medical_information_outlined),
            title: Text(AppLocalizations.of(context)!.drawer1),
            onTap: () {
              //_showAlertDialogLib(context);
               Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const DiseaseLib()
                )
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.language_outlined),
            title: Text(AppLocalizations.of(context)!.drawer2),
            onTap: () {
              _showAlertDialogLanguage(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: Text(AppLocalizations.of(context)!.drawer4),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>const AboutScreen()
                )
              );
            },
          ),
            ListTile(
              leading: const Icon(Icons.logout),
              title:const Text("Logout"),
              onTap: () async {
                await _authService.signOut();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) =>const Login()),
                );
              },
            )
          
        ],
      ),
    );
  }

  _showAlertDialogLanguage(cntx) {
    ui.Locale defaultLocale = ui.window.locale;
    String selectedLanguageCode = defaultLocale.languageCode;
    return showDialog(
      context: cntx,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: Theme.of(context).hintColor,
              title: Text(AppLocalizations.of(context)!.drawer2),
              content: SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RadioListTile(
                      //activeColor: selectedLanguageCode == 'en'
                      //    ? Colors.green 
                      //    : Colors.white,
                      activeColor: Colors.green,
                      title:const Text('English'),
                      value: 'en',
                      groupValue: selectedLanguageCode,
                      onChanged: (value) {
                        setState(() {
                          selectedLanguageCode = value.toString();
                        });
                      },
                    ),
                    RadioListTile(
                      //activeColor: selectedLanguageCode == 'fr'
                      //    ? Colors.green // Change color when selected
                      //    : Colors.white,
                      activeColor: Colors.green,
                      title:const Text('français'),
                      value: 'fr',
                      groupValue: selectedLanguageCode,
                      onChanged: (value) {
                        setState(() {
                          selectedLanguageCode = value.toString();
                        });
                      },
                    ),
                    RadioListTile(
                      //activeColor: selectedLanguageCode == 'ar'
                      //    ? Colors.green // Change color when selected
                      //    : Colors.white,
                      activeColor: Colors.green,
                      title:const Text('العربية'),
                      value: 'ar',
                      groupValue: selectedLanguageCode,
                      onChanged: (value) {
                        setState(() {
                          selectedLanguageCode = value.toString();
                        });
                      },
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); 
                  },
                  child: Text(translation(context).cancel, style: TextStyle(color: Theme.of(context).primaryColor),),
                ),
                TextButton(
                  onPressed: () async {
                    Locale loc= await setLocale(selectedLanguageCode);
                    MyApp.setLocale(context, loc);
                    Navigator.pop(context); 
                  },
                  child: Text(translation(context).confirmation, style: TextStyle(color: Theme.of(context).primaryColor)),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

