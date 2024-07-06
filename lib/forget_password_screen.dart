import 'package:djaaja_siha/langage_constant.dart';
import 'package:flutter/material.dart';
import 'authentification/auth_service.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final AuthService _authService = AuthService();

  final TextEditingController _emailController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(
                children: [
                  IconButton(
                    icon:const Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              CircleAvatar(
                radius: 50,
                backgroundColor: Theme.of(context).primaryColor,
                child: const Icon(Icons.sentiment_dissatisfied, size: 55, color: Colors.yellow),
              ),
              const SizedBox(height: 20),
              Text(
                translation(context).forgotpassword,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                translation(context).entermail,
                style: TextStyle(fontSize: 16, color: Theme.of(context).primaryColor),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
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
                    labelText: translation(context).email,
                    labelStyle:TextStyle(
                      color:  Theme.of(context).primaryColor,
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1), 
                    ),
                  ),
                ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () async{
                  await _authService.resetPassword(_emailController.text);
                	Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(translation(context).emailsend)),
                  );
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    minimumSize:const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    translation(context).submit,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}