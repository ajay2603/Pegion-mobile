import 'package:flutter/material.dart';
import 'dart:async';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

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
    );
  }
}
