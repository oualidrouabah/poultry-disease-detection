// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_typing_uninitialized_variables

import 'dart:io' as io;
import 'package:djaaja_siha/change_passwoed_screen.dart';
import 'package:djaaja_siha/langage_constant.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'authentification/user_model.dart';
import 'change_information_screen.dart';
import 'package:flutter/foundation.dart' show kIsWeb;


class UserInformationScreen extends StatefulWidget {
  final UserModel? user;
  const UserInformationScreen({super.key, this.user});

  @override
  // ignore: library_private_types_in_public_api
  _UserInformationScreenState createState() => _UserInformationScreenState();
}

class _UserInformationScreenState extends State<UserInformationScreen> {
  
  var _image;
  final ImagePicker _picker = ImagePicker();
  UserModel? _userModel;

  @override
  void initState() {
    super.initState();
    _userModel = widget.user;
  }

Future<void> _pickImage() async {
  final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

  if (pickedFile != null) {
    if (kIsWeb) {
      // For Web
      setState(() {
        _image = pickedFile;  // XFile for web
      });
    } else {
      // For mobile
      setState(() {
        _image = io.File(pickedFile.path);
      });
    }
    print("pickedFile ${pickedFile.path}" );
    await _uploadImage();
  }
}

Future<void> _uploadImage() async {
  if (_image == null) return;

  User? user = FirebaseAuth.instance.currentUser;
  try {
    if (user != null) {
      // Upload to Firebase Storage
      String fileName = 'profile_pictures/${user.uid}.png';
      print('Uploading image to $fileName');

      UploadTask uploadTask;

      if (kIsWeb) {
        // For Web
        uploadTask = FirebaseStorage.instance.ref().child(fileName).putData(await _image!.readAsBytes());
      } else {
        // For mobile
        uploadTask = FirebaseStorage.instance.ref().child(fileName).putFile(_image! as io.File);
      }

      TaskSnapshot taskSnapshot = await uploadTask;
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();

      // Update Firestore
      await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
        'picture': downloadUrl,
      });

      // Update local state
      setState(() {
        _userModel = _userModel!.copyWith(picture: downloadUrl);
      });
    }
  } catch (e) {
    print('Failed to upload image: $e');
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).hintColor,
          ),
        ),
        title: Text(
          translation(context).myaccount,
          style: TextStyle(
            fontSize: 26,
            color: Theme.of(context).hintColor,
          ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment(0.8, 0.0), // 10% of the width, so there are ten blinds.
            colors: [
              Color.fromARGB(31, 255, 255, 255),
              Color.fromARGB(38, 0, 238, 107)
            ],
            tileMode: TileMode.mirror, // repeats the gradient over the canvas
          ),
        ),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundColor: Theme.of(context).hintColor,
                    radius: 50,
                    backgroundImage: _userModel!.picture.isEmpty
                        ? Image.asset(
                            height: 10,
                            width: 10,
                            "assets/user.png",
                          ).image	
                        : NetworkImage(
                          _userModel!.picture, 
                          scale: 1.0
                        ) as ImageProvider,
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: CircleAvatar(
                        radius: 15,
                        backgroundColor: Colors.white,
                        child: IconButton(
                          onPressed: _pickImage,
                          icon: Icon(
                            Icons.edit,
                            size: 15,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  ProfileInfoTile(
                    title: translation(context).name,
                    content: _userModel!.name,
                  ),
                  SizedBox(height: 20),
                  ProfileInfoTile(
                    title: translation(context).phone,
                    content: _userModel!.phone,
                  ),
                  SizedBox(height: 20),
                  ProfileInfoTile(
                    title: translation(context).email,
                    content: _userModel!.email,
                  ),
                  SizedBox(height: 40),
                  changePasswordButton(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileInfoTile extends StatelessWidget {
  final String title;
  final String content;
  final bool isMultiline;

  const ProfileInfoTile({
    super.key, 
    required this.title,
    required this.content,
    this.isMultiline = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 1),
        GestureDetector(
          onTap: () {
            print("change $content");
            Navigator.push(
              context, 
              MaterialPageRoute(
                builder: (context) => ChangeInformationScreen(
                  title: title,
                  content: content,
                )
              )
            );
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    content,
                    maxLines: isMultiline ? 3 : 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Icon(Icons.edit, size: 16),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

changePasswordButton(context) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      minimumSize: const Size(double.infinity, 50),
      backgroundColor: Theme.of(context).primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    onPressed: () {
      Navigator.push(
        context, 
        MaterialPageRoute(
          builder: (context) => ChangePasswordScreen()
        )
      );
    },
    child: Text(
      translation(context).changepass,
      style: TextStyle(
        fontSize: 20,
        color: Colors.white,
      ),
    ),
  );
}
