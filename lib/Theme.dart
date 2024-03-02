import 'package:flutter/material.dart';

class MyTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: const Color(0xFF0fc09c),
    hintColor: Color(0xffe5eee9),
      
    buttonTheme:const ButtonThemeData(
      buttonColor: Color(0xFF0fc09c),
      textTheme: ButtonTextTheme.primary,
    ),
    textTheme:const TextTheme(
      displayLarge: TextStyle(fontSize: 500.0, fontWeight: FontWeight.bold),
      displayMedium: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
      displaySmall: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
    )
  );

  static ThemeData darkTheme() {
    return ThemeData(
      // Define your dark theme properties here
      brightness: Brightness.dark,
      primaryColor:const Color(0xFF24897b),
      // Add more properties as needed
    );
  }
}
