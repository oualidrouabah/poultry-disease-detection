import 'package:djaaja_siha/langage_constant.dart';
import 'package:flutter/material.dart';
import 'authentification/auth_service.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});
  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final AuthService _authService = AuthService();
  
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();

  bool _passwordVisible = false;
  bool _newPasswordVisible = false;

  Future<void> _changePassword(context) async {
      String currentPassword = _passwordController.text;
      String newPassword = _newPasswordController.text;

      try {
        await _authService.changePassword(context, currentPassword, newPassword);

      } catch (e) {
        setState(() {
        });
      }
  }

  @override
  void initState() {
    super.initState();
    _passwordVisible = true;
    _newPasswordVisible = true;
  }

  @override
  void dispose() {
    super.dispose();
    _passwordController.dispose();
    _newPasswordController.dispose();
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
                    icon: const Icon(Icons.arrow_back),
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
                child: const Icon(Icons.sentiment_very_satisfied,
                    size: 55, color: Colors.yellow),
              ),
              const SizedBox(height: 20),
              Text(
                translation(context).chngepass,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                translation(context).enteroldnewpass,
                style: TextStyle(
                    fontSize: 16, color: Theme.of(context).primaryColor),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              TextField(
                controller: _passwordController,
                obscureText: _passwordVisible,
                cursorColor: Theme.of(context).primaryColor,
                style: TextStyle(color: Theme.of(context).primaryColor),
                decoration: InputDecoration(
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
                  hintStyle: TextStyle(color: Theme.of(context).primaryColor),
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
                  labelText: translation(context).oldpass,
                  labelStyle: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              TextField(
                controller: _newPasswordController,
                obscureText: _newPasswordVisible,
                cursorColor: Theme.of(context).primaryColor,
                style: TextStyle(color: Theme.of(context).primaryColor),
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(
                      _newPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Theme.of(context).primaryColor,
                    ),
                    onPressed: () {
                      setState(() {
                        _newPasswordVisible = !_newPasswordVisible;
                      });
                    },
                  ),
                  hintStyle: TextStyle(color: Theme.of(context).primaryColor),
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
                  labelText: translation(context).newpass,
                  labelStyle: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () async{
                  _changePassword(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  translation(context).changepass,
                  style:const TextStyle(
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
