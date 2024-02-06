import 'dart:convert';
import "package:flutter/material.dart";
import 'package:http/http.dart' as http;
import 'package:pegion/components/showalertdialog.dart';

import '../components/overlay.dart';
import '../sections/auth/signin.dart';
import '../sections/auth/signup.dart';

import '../enums.dart';
import '../consts.dart';

class Auth extends StatefulWidget {
  final Function goToHome;
  const Auth({super.key, required this.goToHome});

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
    OverlayManager.putOverlay(context);
    try {
      final response = await Http.post(
          Uri.parse('$domain/api/user-auth/auth-user-login'),
          body: {'userName': data['userName'], 'password': data['password']});
      final Map result = jsonDecode(response.body);
      if (result['stat']) {
        widget.goToHome();
      } else {
        if (result["err"]) {
          // ignore: use_build_context_synchronously
          showAlertDialog(
              context, 'Error', 'Error occured in validating user.');
        } else {
          if (result['usr']) {
            // ignore: use_build_context_synchronously
            showAlertDialog(
                context, 'Wrong Password', 'Enter correct Password');
          } else {
            // ignore: use_build_context_synchronously
            showAlertDialog(context, 'Invalid User',
                'User name not found retry or\nSign Up now.');
          }
        }
      }
    } catch (err) {
      print(err);
      // ignore: use_build_context_synchronously
      showAlertDialog(context, 'Error', err.toString());
    } finally {
      OverlayManager.removeOverlay();
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
    OverlayManager.putOverlay(context);
    try {
      final response = await Http.post(
          Uri.parse('$domain/api/user-auth/add-new-user'),
          body: {
            'firstName': data['userName'],
            'lastName': data['lastName'],
            'userName': data['userName'],
            'password': data['password']
          });
      final Map result = jsonDecode(response.body);
      if (result['stat']) {
        authDisplay(AuthDisplay.signIn);
      } else {
        if (!result['err']) {
          // ignore: use_build_context_synchronously
          showAlertDialog(context, 'Invalid', 'User already exist.');
        } else {
          // ignore: use_build_context_synchronously
          showAlertDialog(context, 'Error', 'Error occured in server');
        }
      }
    } catch (err) {
      print(err);
      // ignore: use_build_context_synchronously
      showAlertDialog(context, 'Error', 'Error in connecting server');
    } finally {
      OverlayManager.removeOverlay();
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
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 35,
              child: Image(
                image: AssetImage('assets/images/pegion_ico.png'),
              ),
            ),
            SizedBox(width: 20),
            Text(
              'Pegion',
              style: TextStyle(
                fontSize: 35,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: display,
        ),
      ),
    );
  }
}
