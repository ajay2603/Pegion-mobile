import "package:flutter/material.dart";

import '../sections/auth/signin.dart';
import '../sections/auth/signup.dart';

import '../enums.dart';

class Auth extends StatefulWidget {
  const Auth({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _Auth createState() => _Auth();
}

class _Auth extends State<Auth> {
  late Widget display;

  _Auth() {
    display = SignIn(changeSec: authDisplay);
  }

  void authDisplay(AuthDisplay displayType) {
    setState(() {
      if (displayType == AuthDisplay.signIn) {
        display = SignIn(changeSec: authDisplay);
      } else if (displayType == AuthDisplay.signUp) {
        display = SignUp(changeSec: authDisplay);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text(
                  'Pegion',
                  style: TextStyle(
                    fontSize: 43,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 64, 0, 148),
                  ),
                ),
                const SizedBox(height: 30),
                display,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
