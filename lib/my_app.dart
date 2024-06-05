import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:djaaja_siha/langage_constant.dart';
import 'package:djaaja_siha/splash_screen.dart';
import 'package:djaaja_siha/theme.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

ui.Locale defaultLocale = ui.window.locale;
Locale local = Locale(defaultLocale.languageCode);

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
  static void setLocale(BuildContext context, Locale newLocal) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocal);
  }
}

class _MyAppState extends State<MyApp> {
  void setLocale(Locale newLocal) {
    setState(() {
      local = newLocal;
    });
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) => {setLocale(locale)});
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
        Locale('fr'),
      ],
      locale: local,
      debugShowCheckedModeBanner: false,
      title: "Chicken AI",
      theme: MyTheme.lightTheme,
      home: const SplashScreen(),
    );
  }
}
