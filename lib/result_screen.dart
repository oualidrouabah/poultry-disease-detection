// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:developer';
import 'package:djaaja_siha/home_screen.dart';
import 'package:djaaja_siha/langage_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tflite/flutter_tflite.dart';

class Result extends StatefulWidget {
  final String image;
  const Result({super.key, required this.image});

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  String? imgPath;
  String label = "";
  var confidence;

  Future<void> _tfLteInit() async {
    try {
      await Tflite.loadModel(
        model: "assets/densenet_model.tflite",
        labels: "assets/labels.txt",
      );
    } catch (e) {
      log("Error in loading the model $e");
    }
    var recognitions = await Tflite.runModelOnImage(
      path: widget.image,
    );
    if (recognitions == null) {
      log("recognitions is Null");
      return;
    }
    log(recognitions.toString());

    setState(() {
      confidence = recognitions[0]['confidence'] * 100;
      label = recognitions[0]['label'].toString();
    });
  }

  @override
  void dispose() async{
    super.dispose();
    await Tflite.close();
  }

  @override
  void initState() {
    super.initState();
    _tfLteInit();
  }

  @override
  void didUpdateWidget(Result oldWidget) {
    if (oldWidget.image != widget.image) {
      _tfLteInit();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end:
              Alignment(0.8, 0.0), // 10% of the width, so there are ten blinds.
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
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    translation(context).title,
                    style: TextStyle(
                      fontSize: 18,
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    const SizedBox(height: 5),
                    Center(
                      child: Image.asset(
                        label == "Healthy"
                            ? 'assets/healthy_logo.png'
                            : 'assets/sick_logo.png',
                        scale: 1,
                      ),
                    ),
                    const SizedBox(height: 1),
                    Center(
                      child: Column(
                        children: [
                          Text(
                            translation(context).result,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          const SizedBox(height: 5),
                          label == "Healthy"
                              ? Text(
                                  translation(context).healthy,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.normal,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "${translation(context).suffer} : ",
                                      textAlign: TextAlign.center,
                                      style:const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.normal,
                                        color: Color.fromARGB(255, 232, 51, 51),
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    label == "Coccidiosis"
                                        ? Text(
                                            translation(context).coccidiosis,
                                            style:const TextStyle(
                                              fontSize: 22,
                                              color: Color.fromARGB(
                                                  255, 232, 51, 51),
                                              fontWeight: FontWeight.normal,
                                            ),
                                          )
                                        : label == "Salmonella"
                                            ? Text(
                                                translation(context).salmonella,
                                                style: const TextStyle(
                                                  fontSize: 22,
                                                  color: Color.fromARGB(
                                                      255, 232, 51, 51),
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              )
                                            : Text(
                                                translation(context)
                                                    .newCastleDisease,
                                                style:const TextStyle(
                                                  fontSize: 22,
                                                  color: Color.fromARGB(
                                                      255, 232, 51, 51),
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                  ],
                                )
                        ],
                      ),
                    ),
                    const SizedBox(height: 50),
                    IconButton(
                      icon: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.check,
                            size: 30,
                            color: Colors.white,
                          ),
                          Text(
                            translation(context).ok,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 18),
                          )
                        ],
                      ),
                      onPressed: () => Navigator.push(context,
                          MaterialPageRoute(builder: (_) =>const HomeScreen())),
                      style: ButtonStyle(
                          fixedSize:
                              const MaterialStatePropertyAll(Size(190, 70)),
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.only(
                                  top: 10, bottom: 10, left: 10, right: 10)),
                          backgroundColor: MaterialStateProperty.all(
                              Theme.of(context).primaryColor),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)))),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
