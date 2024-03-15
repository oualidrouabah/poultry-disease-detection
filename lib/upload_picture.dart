import 'dart:io';
import 'package:djaaja_siha/result_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Upload extends StatefulWidget {
  const Upload({super.key});

  @override
  State<Upload> createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  XFile? image;

  imagePicker() async {
    final ImagePicker picker = ImagePicker();
    final img = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      image = img;
    });
  }

  @override
  void initState() {
    super.initState();
    imagePicker();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).hintColor,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: image == null
            ? Center(
                child: Container(
                  color: Theme.of(context).hintColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.noselect,
                        textAlign: TextAlign.center,
                        style:const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 0, 168, 132),
                        ),
                      ),
                      const SizedBox(height: 40),
                      IconButton(
                          onPressed: () {
                            imagePicker();
                          },
                          style: ButtonStyle(
                            fixedSize:const MaterialStatePropertyAll(Size(190, 70)),
                            padding: MaterialStateProperty.all(
                                  const EdgeInsets.only(
                                      top: 10,
                                      bottom: 10,
                                      left: 10,
                                      right: 10)),
                              backgroundColor: MaterialStateProperty.all(
                                  Theme.of(context).primaryColor),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(20)))),
                          icon: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.upload,
                                size: 30,
                                color: Colors.white,
                              ),
                              Text(
                                AppLocalizations.of(context)!.uploadpics,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 18),
                              )
                            ],
                          )),
                    ],
                  ),
                ),
              )
            : Stack(children: [
                Center(child: Image.file(File(image!.path))),
                Container(
                  padding: const EdgeInsets.only(top: 40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.arrow_back),
                          ),
                        ],
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.7,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              imagePicker();
                            },
                            style: ElevatedButton.styleFrom(
                              shape: const CircleBorder(),
                              backgroundColor: Theme.of(context).primaryColor,
                              //minimumSize: Size(100, 50),
                              fixedSize: const Size(200, 70),
                            ),
                            child: Icon(
                              Icons.refresh_outlined,
                              color: Theme.of(context).hintColor,
                              size: 50,
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) =>  Result(image: image!.path)
                                    )
                                );
                            },
                            style: ElevatedButton.styleFrom(
                              shape: const CircleBorder(),
                              backgroundColor: Theme.of(context).primaryColor,
                              fixedSize: const Size(200, 70),
                            ),
                            child: Icon(
                              Icons.check,
                              color: Theme.of(context).hintColor,
                              size: 50,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ]),
      ),
    );
  }
}
