import 'package:djaaja_siha/langage_constant.dart';
import 'package:flutter/material.dart';

import 'my_app.dart';

class ChangeLanguage extends StatefulWidget {
  const ChangeLanguage({super.key});

  @override
  State<ChangeLanguage> createState() => _ChangeLanguageState();
}

class _ChangeLanguageState extends State<ChangeLanguage> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        TextButton(
          onPressed: () {
            changeLanguage(context, 'en');
          },
          child: Text(
            'English',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
                fontSize: 12,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            changeLanguage(context, 'fr');
          },
          child: Text(
            'Français',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
                fontSize: 12,
              ),
            ),
        ),
        TextButton(
          onPressed: () {
            changeLanguage(context, 'ar');
          },
          child: Text(
            'العربية',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }
  
  void changeLanguage(BuildContext context, String s) async{
    Locale _temp;
    switch (s) {
      case 'en':
        _temp = const Locale('en', 'US');
        break;
      case 'fr':
        _temp = const Locale('fr', 'FR');
        break;
      case 'ar':
        _temp = const Locale('ar', 'AR');
        break;
      default:
        _temp = const Locale('en', 'US');
    }
    
    MyApp.setLocale(context, _temp);
  }
}