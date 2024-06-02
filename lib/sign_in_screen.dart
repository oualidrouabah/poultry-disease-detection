import 'package:djaaja_siha/home_screen.dart';
import 'package:djaaja_siha/login_screen.dart';
import 'package:flutter/material.dart';

import 'authentification/auth_service.dart';
import 'authentification/user_model.dart';


class Singup extends StatefulWidget {
  const Singup({super.key});

  @override
  State<Singup> createState() => _SingupState();
}

class _SingupState extends State<Singup>{
  bool _passwordVisible = false;
  bool _passwordVisibleConfirmation = false;
  final AuthService _authService = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  
  bool _isLogin = true;
  String _errorMessage = '';
  bool _isPasswordError = false;
  bool _isEmailError = false;

  void _toggleFormMode() {
    setState(() {
      _isLogin = !_isLogin;
      _errorMessage = '';
      _isPasswordError = false;
      _isEmailError = false;
    });
  }

  void _navigateToHomePage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) =>const HomeScreen()),
    );
  }
  
  @override
  void initState() {
    super.initState();
     _passwordVisible = false;
    _passwordVisibleConfirmation = false;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
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
            //color:const Color.fromARGB(255, 239, 254, 243),
            padding: const EdgeInsets.all(20),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children:<Widget> [
                const SizedBox(height: 50,),
                Text(
                    'Create Account',
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color:Theme.of(context).primaryColor
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _nameController,
                    cursorColor: Theme.of(context).primaryColor,
                    style:TextStyle(color: Theme.of(context).primaryColor),
                    decoration: InputDecoration(
                      hintStyle:TextStyle(color: Theme.of(context).primaryColor),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 0.0),
                      ),
                      prefixIcon:const Icon(Icons.person_outline_outlined),
                      prefixIconColor: WidgetStateColor.resolveWith((states) =>
                              states.contains(WidgetState.focused)
                              ? Theme.of(context).primaryColor
                              : Colors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1),
                      ),
                      labelText: 'Name',
                      labelStyle: TextStyle(
                        color:  Theme.of(context).primaryColor,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1), 
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  
                  TextField(
                    controller: _emailController,
                    cursorColor: Theme.of(context).primaryColor,
                    style:TextStyle(color: Theme.of(context).primaryColor),
                    decoration: InputDecoration(
                      hintText: "example@mail.com",
                      hintStyle:TextStyle(color: Theme.of(context).primaryColor),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 0.0),
                      ),
                      prefixIcon:const Icon(Icons.email_outlined),
                      prefixIconColor: WidgetStateColor.resolveWith((states) =>
                              states.contains(WidgetState.focused)
                              ? Theme.of(context).primaryColor
                              : Colors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1),
                      ),
                      labelText: 'Email',
                      labelStyle:TextStyle(
                        color:  Theme.of(context).primaryColor,
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1), 
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                  TextField(                    
                    cursorColor: Theme.of(context).primaryColor,
                    style:TextStyle(color: Theme.of(context).primaryColor),
                    decoration: InputDecoration(
                      hintStyle:TextStyle(color: Theme.of(context).primaryColor),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 0.0),
                      ),
                      prefixIcon:const Icon(Icons.phone_android_outlined),
                      prefixIconColor: WidgetStateColor.resolveWith((states) =>
                              states.contains(WidgetState.focused)
                              ? Theme.of(context).primaryColor
                              : Colors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:  BorderSide(color: Theme.of(context).primaryColor, width: 1),
                      ),
                      labelText: 'Phone',
                      labelStyle: TextStyle(
                        color:  Theme.of(context).primaryColor,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1), 
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                  TextField(
                    controller: _passwordController,
                    obscureText: _passwordVisible,
                    cursorColor: Colors.grey,
                    style:TextStyle(color: Theme.of(context).primaryColor),
                    decoration: InputDecoration(
                      enabledBorder:  OutlineInputBorder(
                        borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 0.0),
                      ),
                      prefixIcon:const Icon(Icons.lock_outline),
                      prefixIconColor: WidgetStateColor.resolveWith((states) =>
                              states.contains(WidgetState.focused)
                              ? Theme.of(context).primaryColor
                              : Colors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:  BorderSide(color: Theme.of(context).primaryColor, width: 1),
                      ),
                      labelText: 'Password',
                      labelStyle:TextStyle(
                        color:  Theme.of(context).primaryColor
                      ),
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
                    style:TextStyle(color: Theme.of(context).primaryColor),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 0.0),
                      ),
                      prefixIcon:const Icon(Icons.lock_outline),
                      prefixIconColor: WidgetStateColor.resolveWith((states) =>
                              states.contains(WidgetState.focused)
                              ? Theme.of(context).primaryColor
                              : Colors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1),
                      ),
                      labelText: 'Confirm password',
                      labelStyle: TextStyle(
                        color:  Theme.of(context).primaryColor,
                      ),
                      focusedBorder:  OutlineInputBorder(
                        borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1), 
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
                            _passwordVisibleConfirmation = !_passwordVisibleConfirmation;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  Text(
                    'Or sign up using',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor
                    ),
                  ),
                  const SizedBox(height: 20, ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(width: 20,),
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Theme.of(context).primaryColor,
                            width: 2,
                          ),
                        ),
                        child: IconButton(
                          icon:const Icon (Icons.facebook),
                          color:Theme.of(context).primaryColor,
                          onPressed: () {},
                        ),
                      ),
                      const SizedBox(width: 20),
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Theme.of(context).primaryColor,
                            width: 2,
                          ),
                        ),
                        child: IconButton(
                          icon:const Icon(Icons.g_mobiledata_outlined),
                          color:Theme.of(context).primaryColor,
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async{
                      if (_isLogin) {                       
                        UserModel? user = await _authService.createUserWithEmailAndPassword(
                          _emailController.text,
                          _passwordController.text,
                          _nameController.text,
                        );
                        if (user != null) {
                          _navigateToHomePage();
                        } else {
                          setState(() {
                            _errorMessage = 'Failed to register. Please try again.';
                            print(_errorMessage);
                          });
                        }
                      }

                      UserModel? user = await _authService.signInWithEmailAndPassword(
                          _emailController.text,
                          _passwordController.text,
                        );
                        if (user != null) {
                          _navigateToHomePage();
                        } else {
                          setState(() {
                            _errorMessage = 'Failed to sign in. Please check your credentials.';
                            print(_errorMessage);
                          });
                        }

                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      minimumSize:const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child:const Text(
                      'Create Account',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        'Already have an account?',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const Login()),
                          );
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      )
    );
  }
}