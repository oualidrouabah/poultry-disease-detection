import 'package:flutter/material.dart';

class MyTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: const Color(0xFF0fc09c),
    hintColor:const Color(0xffe5eee9),    
    textTheme:const TextTheme(
      titleLarge: TextStyle(
                  fontFamily:'Raleway' ,
                  fontSize: 50, 
                  fontWeight: FontWeight.normal,
                ),
      displayLarge: TextStyle(fontSize: 35.0, fontWeight: FontWeight.bold),
      displayMedium: TextStyle(fontSize: 21.0, fontWeight: FontWeight.normal, color: Color(0xffe5eee9)),
      displaySmall: TextStyle(fontSize: 15.0, fontWeight: FontWeight.normal, color: Color(0xffe5eee9)),
    )
  );

  static ThemeData darkTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor:const Color(0xFF121212),
      hintColor:const Color(0xff575757),
      
      textTheme:const TextTheme(
        displayLarge: TextStyle(fontSize: 500.0, fontWeight: FontWeight.bold,color: Color(0xffe5eee9)),
        displayMedium: TextStyle(fontSize: 18.0, fontWeight: FontWeight.normal, color: Color(0xffe5eee9)),
        displaySmall: TextStyle(fontSize: 20.0, fontWeight: FontWeight.normal, color: Color(0xffe5eee9)),
      )
    );
  }
}
