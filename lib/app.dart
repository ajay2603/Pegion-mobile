import 'package:flutter/material.dart';

import './screens/auth.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      home: const Auth(),
    );
  }
}
