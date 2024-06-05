import 'package:djaaja_siha/authentification/auth_service.dart';
import 'package:djaaja_siha/authentification/user_model.dart';
import 'package:djaaja_siha/change_language_login.dart';
import 'package:djaaja_siha/home_screen.dart';
import 'package:djaaja_siha/langage_constant.dart';
import 'package:djaaja_siha/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'authentification/user_provide.dart';
import 'forget_password_screen.dart';


class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final AuthService _authService = AuthService();
  bool _passwordVisible = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _navigateToHomePage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  @override
  void initState() {
    super.initState();
    _passwordVisible = true;
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                //big icon of personne
                Center(
                  child: Image.asset(
                    height: 200,
                    width: 200,
                    'assets/logo.png',
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  translation(context).wlcm,
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  translation(context).signtocont,
                  style: TextStyle(
                    fontSize: 15,
                    color: Theme.of(context).primaryColor,
                  ),
                ),

                const SizedBox(height: 40),

                TextField(
                  controller: _emailController,
                  cursorColor: Theme.of(context).primaryColor,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                  decoration: InputDecoration(
                    hintText: "example@mail.com",
                    hintStyle: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
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
                  cursorColor: Theme.of(context).primaryColor,
                  style: TextStyle(color: Theme.of(context).primaryColor),
                  decoration: InputDecoration(
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
                      borderSide:
                          const BorderSide(color: Colors.grey, width: 1),
                    ),
                    labelText: translation(context).password,
                    labelStyle: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.grey, width: 1),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                          _passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Theme.of(context).primaryColor),
                      onPressed: () {
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 5),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ForgotPasswordScreen()),
                        );
                      },
                      child: Text(
                        textAlign: TextAlign.right,
                        translation(context).forgotpassword,
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    backgroundColor: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () async {
                    UserModel? user =
                        await _authService.signInWithEmailAndPassword(
                      _emailController.text,
                      _passwordController.text,
                    );
                    if (user != null) {
                      Provider.of<UserProvider>(context, listen: false)
                          .setUser(user);
                      final SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      await prefs.setString('userModel', user.toJson());
                      _navigateToHomePage();
                    } else {
                      setState(() {
                        ScaffoldMessenger.of(context).showSnackBar(
                           SnackBar(
                              content: Text(
                                  translation(context).failedsignin)),
                        );
                      });
                    }
                  },
                  child: Text(
                    translation(context).login,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  translation(context).orsignupwith,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                const SizedBox(height: 10),
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
                      //color:Theme.of(context).primaryColor,
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
                                  translation(context).failedsigningoogle,
                              )
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      translation(context).doensthaveacc,
                      style:const TextStyle(color: Colors.black),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Singup()),
                        );
                      },
                      child: Text(
                        translation(context).createaccount,
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
      ),
    );
  }
}
