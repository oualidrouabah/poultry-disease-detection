import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../home_screen.dart';
import 'auth_service.dart';
import 'user_model.dart';
import 'user_provide.dart';

class AuthHandler {
  final AuthService _authService = AuthService();

  void _navigateToHomePage(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  Future<void> login(BuildContext context, String email, String password) async {
    UserModel? user = await _authService.signInWithEmailAndPassword(email, password);
    if (user != null) {
      Provider.of<UserProvider>(context, listen: false).setUser(user);
      _navigateToHomePage(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to sign in. Please check your credentials.')),
      );
    }
  }

  Future<void> signup(BuildContext context, String email, String password, String name) async {
    UserModel? user = await _authService.createUserWithEmailAndPassword(email, password, name);
    if (user != null) {
      Provider.of<UserProvider>(context, listen: false).setUser(user);
      _navigateToHomePage(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to register. Please try again.')),
      );
    }
  }
}
