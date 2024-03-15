// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:camera/camera.dart';
import 'package:djaaja_siha/about.dart';
import 'package:djaaja_siha/diseases_lib.dart';
import 'package:djaaja_siha/langage_constant.dart';
import 'package:djaaja_siha/main.dart';
import 'package:djaaja_siha/take_picture.dart';
import 'package:djaaja_siha/upload_picture.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'dart:ui' as ui;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).hintColor,
      key: _scaffoldKey,
      drawer: cstmDrawer(context),
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
              mainAxisAlignment: MainAxisAlignment.start,
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
                          scale: 1.2,
                        ),
                      ),
                      const SizedBox(height: 1),
                      Center(
                        child: Text(
                          AppLocalizations.of(context)!.wlcmtext,
                          textAlign: TextAlign.center,
                          style:const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 0, 168, 132),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  fixedSize:const MaterialStatePropertyAll(Size(190, 190)),
                                  padding: MaterialStateProperty.all(
                                      const EdgeInsets.only(
                                          top: 40,
                                          bottom: 40,
                                          left: 26,
                                          right: 26)),
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
                                children: [
                                  const Icon(
                                    Icons.camera_alt,
                                    size: 77,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    AppLocalizations.of(context)!.takepics,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 18),
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
                                  fixedSize:const MaterialStatePropertyAll(Size(190, 190)),
                                  padding: MaterialStateProperty.all(
                                      const EdgeInsets.only(
                                          top: 40,
                                          bottom: 40,
                                          left: 18,
                                          right: 18)),
                                  backgroundColor: MaterialStateProperty.all(
                                      const Color.fromARGB(255, 0, 168, 132)),
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30)))),
                              icon: Column(
                                children: [
                                  const Icon(
                                    Icons.upload,
                                    size: 77,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    AppLocalizations.of(context)!.uploadpics,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 18),
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

  cstmDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
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
                    AppLocalizations.of(context)!.title,
                    style: TextStyle(
                        fontSize: 18,
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

