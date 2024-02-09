import 'dart:convert';
import 'dart:ui';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:http/http.dart' as Http;

import 'package:path_provider/path_provider.dart';
import 'package:pegion/components/home/userlistitem.dart';

import './screens/loading.dart';
import './screens/home.dart';
import './screens/auth.dart';

import './components/showalertdialog.dart';

import 'consts.dart';

class App extends StatefulWidget {
  @override
  _App createState() => _App();
}

class _App extends State<App> {
  late Widget display = LoadingPage();
  late Widget auth = Auth(goToHome: goToHome);

  var http = Http.Client();

  _App() {
    validateSession();
  }

  void validateSession() async {
    var userName;
    var logID;
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/${authFile}');
      String jsText = await file.readAsString();
      var authDetails = jsonDecode(jsText);
      userName = authDetails['userName'];
      logID = authDetails['logID'];
    } catch (err) {
      print(err);
      setState(() {
        display = auth;
      });
    }

    try {
      var response = await http.post(
          Uri.parse("$domain/api/user-auth/auth-session-login"),
          body: {'userName': userName, 'logID': logID});
      var result = jsonDecode(response.body);
      if (result['stat']) {
        setState(() {
          display = Home(userName: userName);
        });
      } else {
        display = auth;
      }
    } catch (err) {
      showAlertDialog(context, "Error", err.toString());
    }
  }

  void goToHome(userName) {
    setState(() {
      display = Home(userName: userName);
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
