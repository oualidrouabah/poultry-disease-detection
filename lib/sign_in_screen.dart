// ignore_for_file: avoid_print

import 'package:djaaja_siha/langage_constant.dart';
import 'package:flutter/material.dart';
import 'package:djaaja_siha/home_screen.dart';
import 'package:djaaja_siha/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'authentification/auth_service.dart';
import 'authentification/user_model.dart';
import 'authentification/user_provide.dart';
import 'change_language_login.dart';

class Singup extends StatefulWidget {
  const Singup({super.key});

  @override
  State<Singup> createState() => _SingupState();
}

class _SingupState extends State<Singup> {
  final AuthService _authService = AuthService();

  bool _passwordVisible = false;
  bool _passwordVisibleConfirmation = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phonecontroller = TextEditingController();

  bool _isLogin = false;
  bool _isPasswordError = false;

  void _toggleFormMode() {
    setState(() {
      _isLogin = !_isLogin;
      _isPasswordError = false;
      _passwordVisible = true;
      _passwordVisibleConfirmation = true;
    });
  }

  void _navigateToHomePage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  @override
  void initState() {
    super.initState();
    _toggleFormMode();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _nameController.dispose();
    _phonecontroller.dispose();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          height: MediaQuery.of(context).size.height,
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
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  const SizedBox(
                    height: 50,
                  ),
                  Text(
                    translation(context).createaccount,
                    style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _nameController,
                    cursorColor: Theme.of(context).primaryColor,
                    style: TextStyle(color: Theme.of(context).primaryColor),
                    decoration: InputDecoration(
                      hintStyle:
                          TextStyle(color: Theme.of(context).primaryColor),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).primaryColor, width: 0.0),
                      ),
                      prefixIcon: const Icon(Icons.person_outline_outlined),
                      prefixIconColor: WidgetStateColor.resolveWith((states) =>
                          states.contains(WidgetState.focused)
                              ? Theme.of(context).primaryColor
                              : Colors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            color: Theme.of(context).primaryColor, width: 1),
                      ),
                      labelText: translation(context).name,
                      labelStyle: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                      focusedBorder:const OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.grey, width: 1),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _emailController,
                    cursorColor: Theme.of(context).primaryColor,
                    style: TextStyle(color: Theme.of(context).primaryColor),
                    decoration: InputDecoration(
                      hintText: "example@mail.com",
                      hintStyle:
                          TextStyle(color: Theme.of(context).primaryColor),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).primaryColor, width: 0.0),
                      ),
                      prefixIcon: const Icon(Icons.email_outlined),
                      prefixIconColor: WidgetStateColor.resolveWith((states) =>
                          states.contains(WidgetState.focused)
                              ? Theme.of(context).primaryColor
                              : Colors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            color: Theme.of(context).primaryColor, width: 1),
                      ),
                      labelText: translation(context).email,
                      labelStyle: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _phonecontroller,
                    cursorColor: Theme.of(context).primaryColor,
                    style: TextStyle(color: Theme.of(context).primaryColor),
                    decoration: InputDecoration(
                      hintStyle:
                          TextStyle(color: Theme.of(context).primaryColor),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).primaryColor, width: 0.0),
                      ),
                      prefixIcon: const Icon(Icons.phone_android_outlined),
                      prefixIconColor: WidgetStateColor.resolveWith((states) =>
                          states.contains(WidgetState.focused)
                              ? Theme.of(context).primaryColor
                              : Colors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            color: Theme.of(context).primaryColor, width: 1),
                      ),
                      labelText: translation(context).phone,
                      labelStyle: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                      focusedBorder:const OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.grey, width: 1),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _passwordController,
                    obscureText: _passwordVisible,
                    cursorColor: Colors.grey,
                    style: TextStyle(color: Theme.of(context).primaryColor),
                    decoration: InputDecoration(
                      errorText:
                          _isPasswordError ? translation(context).passwordsnotmatch : null,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).primaryColor, width: 0.0),
                      ),
                      prefixIcon: const Icon(Icons.lock_outline),
                      prefixIconColor: WidgetStateColor.resolveWith((states) =>
                          states.contains(WidgetState.focused)
                              ? Theme.of(context).primaryColor
                              : Colors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            color: Theme.of(context).primaryColor, width: 1),
                      ),
                      labelText: translation(context).password,
                      labelStyle:
                          TextStyle(color: Theme.of(context).primaryColor),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Theme.of(context).primaryColor,
                        ),
                        onPressed: () {
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _confirmPasswordController,
                    obscureText: _passwordVisibleConfirmation,
                    cursorColor: Theme.of(context).primaryColor,
                    style: TextStyle(color: Theme.of(context).primaryColor),
                    decoration: InputDecoration(
                      errorText:
                          _isPasswordError ? translation(context).passwordsnotmatch : null,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).primaryColor, width: 0.0),
                      ),
                      prefixIcon: const Icon(Icons.lock_outline),
                      prefixIconColor: WidgetStateColor.resolveWith((states) =>
                          states.contains(WidgetState.focused)
                              ? Theme.of(context).primaryColor
                              : Colors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            color: Theme.of(context).primaryColor, width: 1),
                      ),
                      labelText: translation(context).confirmpassword,
                      labelStyle: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.grey, width: 1),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _passwordVisibleConfirmation
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Theme.of(context).primaryColor,
                        ),
                        onPressed: () {
                          setState(() {
                            _passwordVisibleConfirmation =
                                !_passwordVisibleConfirmation;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    translation(context).orsignupwith,
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: Image.asset(
                          'assets/google.png',
                        ),
                        color: Theme.of(context).primaryColor,
                        onPressed: () async {
                          // Call signInWithGoogle method from AuthService
                          UserModel? user =
                              await AuthService().signInWithGoogle();

                          // Check if user is not null to proceed
                          if (user != null) {
                            Provider.of<UserProvider>(context, listen: false)
                                .setUser(user);
                            final SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            await prefs.setString('userModel', user.toJson());
                            // User signed in successfully, navigate to appropriate screen
                            _navigateToHomePage();
                          } else {
                            // Handle sign in failure
                            // You can show an error message or perform any other action
                            // For example, showing a snackbar with the error message
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    translation(context).failedsigningoogle),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () async {
                      print("create pressed");

                      print("is login");
                      if (_passwordController.text !=
                          _confirmPasswordController.text) {
                        setState(() {
                          _isPasswordError = true; // Set error flag to true
                        });
                        return; // Exit function if passwords do not match
                      } else {
                        setState(() {
                          _isPasswordError = false;
                          //_errorMessage = '';
                        });

                        UserModel? user =
                            await _authService.createUserWithEmailAndPassword(
                          _emailController.text,
                          _passwordController.text,
                          _nameController.text,
                          "",
                          _phonecontroller.text,
                        );
                        if (user != null) {
                          print("user not null sign");
                          _navigateToHomePage();
                        } else {
                          setState(() {
                            ScaffoldMessenger.of(context).showSnackBar(
                               SnackBar(
                                  content: Text(
                                      translation(context).failedregister)),
                            );
                          });
                        }
                        UserModel? userLog =
                            await _authService.signInWithEmailAndPassword(
                          _emailController.text,
                          _passwordController.text,
                        );
                        if (userLog != null) {
                          Provider.of<UserProvider>(context, listen: false)
                              .setUser(user);
                          final SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          await prefs.setString('userModel', userLog.toJson());
                          _navigateToHomePage();
                        } else {
                          setState(() {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(
                                      translation(context).failedregister)),
                            );
                          });
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      translation(context).createaccount,
                      style:const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        translation(context).alreadyhaveaccount,
                        style:const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Login()),
                          );
                        },
                        child: Text(
                          translation(context).login,
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const ChangeLanguage(),
                ],
              ),
            ),
          ),
        ));
  }
}
