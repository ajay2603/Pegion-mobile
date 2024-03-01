import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:http/http.dart' as Http;

import './screens/loading.dart';
import './screens/home.dart';
import './screens/auth.dart';

class MyApp extends StatefulWidget {
  @override
  _MyApp createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  late Widget display = LoadingPage(
    goToAuth: goToAuth,
    goToHome: goToHome,
  );
  late Widget auth = Auth(goToHome: goToHome);

  var http = Http.Client();

  void goToHome(userName) {
    setState(() {
      display = Home(userName: userName, goToAuth: goToAuth);
    });
  }

  void goToAuth() {
    setState(() {
      display = Auth(goToHome: goToHome);
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor:
            Colors.transparent, // Change this to match your AppBar color
      ),
    );
    return MaterialApp(
      title: "Pegion",
      theme: ThemeData().copyWith(
        scaffoldBackgroundColor: const Color(0xFFFFFFFF),
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: const MaterialColor(
            0xFF6E00FF,
            <int, Color>{
              50: Color.fromRGBO(110, 0, 255, 0.1),
              100: Color.fromRGBO(110, 0, 255, 0.2),
              200: Color.fromRGBO(110, 0, 255, 0.3),
              300: Color.fromRGBO(110, 0, 255, 0.4),
              400: Color.fromRGBO(110, 0, 255, 0.5),
              500: Color.fromRGBO(110, 0, 255, 0.6), // Primary color
              600: Color.fromRGBO(110, 0, 255, 0.7),
              700: Color.fromRGBO(110, 0, 255, 0.8),
              800: Color.fromRGBO(110, 0, 255, 0.9),
              900: Color.fromRGBO(110, 0, 255, 1),
            }, // Primary color
          ),
        ),
      ),
      home: display,
    );
  }
}
