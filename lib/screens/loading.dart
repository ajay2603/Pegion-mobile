import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:pegion/components/showalertdialog.dart';
import '../consts.dart';

class LoadingPage extends StatefulWidget {
  late Function goToAuth;
  late Function goToHome;
  LoadingPage({super.key, required this.goToAuth, required this.goToHome});

  @override
  // ignore: library_private_types_in_public_api
  _LoadingPage createState() => _LoadingPage();
}

class _LoadingPage extends State<LoadingPage> {
  double gaph = 100;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  _LoadingPage() {
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
      print(err.toString());
      widget.goToAuth();
    }

    try {
      var response = await http.post(
          Uri.parse("$domain/api/user-auth/auth-session-login"),
          body: {'userName': userName, 'logID': logID});
      var result = jsonDecode(response.body);
      if (result['stat']) {
        widget.goToHome(result['userName']);
      } else {
        widget.goToAuth();
      }
    } on HttpException catch (err) {
      print(err.toString());
      showAlertDialog(context, "Error", "Network error");
    } catch (err) {
      print(err.toString());
    }
  }

  List<String> dots = ["   ", ".  ", ".. ", "...", " ..", "  ."];
  int indx = 0;

  void startTimer() {
    Timer.periodic(const Duration(milliseconds: 300), (timer) {
      if (indx == 5) {
        setState(() {
          indx = 0;
        });
      } else {
        setState(() {
          indx++;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xFF6E00FF),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Center(
                  child: Text(
                    "PEGION",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 35,
                        fontFamily: "Comfortaa"),
                  ),
                ),
                SizedBox(
                  height: gaph,
                ),
                const SizedBox(
                  height: 175,
                  child: Image(
                    image: AssetImage('assets/images/pegion_ico.png'),
                  ),
                ),
                SizedBox(
                  height: gaph,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Validating User ${dots[indx]}",
                      style: const TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
