import 'dart:convert';
import 'dart:html';

import "package:flutter/material.dart";
import 'package:http/http.dart' as http;
import 'package:pegion/screens/showalertdialog.dart';

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
  late var Http;
  late var context;

  _Auth() {
    Http = http.Client();
    display = SignIn(
      changeSec: authDisplay,
      handleSignIn: handleSignIn,
    );
  }

  void handleSignIn(Map data) async {
    bool isEmptyFound = false;
    data.forEach((key, value) {
      if (!isEmptyFound && value == "") {
        showAlertDialog(context, 'Message', '"$key" is empty');
        isEmptyFound = true;
        return;
      }
    });
    if (isEmptyFound) {
      return;
    }
    try {
      final response = await Http.post(
          Uri.parse('http://localhost:5050/api/user-auth/auth-user-login'),
          body: {'userName': data['userName'], 'password': data['password']});
      final Map result = jsonDecode(response.body);
    } catch (err) {
      print(err);
      showAlertDialog(context, 'Error', 'Error in connecting server');
    }
  }

  void handleSignUp(Map data) async {
    bool isEmptyFound = false;
    data.forEach((key, value) {
      if (!isEmptyFound && value == "") {
        showAlertDialog(context, 'Message', '"$key" is empty');
        isEmptyFound = true;
        return;
      }
    });
    if (isEmptyFound) {
      return;
    }
    if (data['password'] != data['cnfPassword']) {
      showAlertDialog(
          context, "Warning", "Password and confirm Password should be same");
      return;
    }
    try {
      final response = await Http.post(
          Uri.parse('http://localhost:5050/api/user-auth/add-new-user'),
          body: {
            'firstName': data['userName'],
            'lastName': data['lastName'],
            'userName': data['userName'],
            'password': data['password']
          });
      final Map result = jsonDecode(response.body);
    } catch (err) {
      print(err);
      showAlertDialog(context, 'Error', 'Error in connecting server');
    }
  }

  void authDisplay(AuthDisplay displayType) {
    setState(() {
      if (displayType == AuthDisplay.signIn) {
        display = SignIn(
          changeSec: authDisplay,
          handleSignIn: handleSignIn,
        );
      } else if (displayType == AuthDisplay.signUp) {
        display = SignUp(
          changeSec: authDisplay,
          handleSignUp: handleSignUp,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 35),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 70,
                child: Text(
                  'Pegion',
                  style: TextStyle(
                    fontSize: 43,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 64, 0, 148),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              SingleChildScrollView(child: display),
            ],
          ),
        ),
      ),
    );
  }
}
