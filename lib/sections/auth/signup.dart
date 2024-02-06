import 'dart:convert';

import 'package:flutter/material.dart';
import '../../components/textinputup.dart';
import '../../components/txt_ip_su_usr.dart';
import '../../enums.dart';

class SignUp extends StatefulWidget {
  final Function changeSec;
  final Function handleSignUp;

  const SignUp(
      {super.key, required this.changeSec, required this.handleSignUp});

  @override
  // ignore: library_private_types_in_public_api
  _SignUp createState() => _SignUp();
}

class _SignUp extends State<SignUp> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _cnfPasswordController = TextEditingController();

  Map submit() {
    Map<String, String> signUpData = {
      'firstName': _firstNameController.text.trim(),
      'lastName': _userNameController.text.trim(),
      'userName': _userNameController.text.trim(),
      'password': _passwordController.text.trim(),
      'cnfPassword': _cnfPasswordController.text.trim()
    };
    return signUpData;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 15),
              child: Text(
                "Sign Up",
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 30,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            TextInputUp(
                controller: _firstNameController, lableText: "First Name"),
            const SizedBox(
              height: 20,
            ),
            TextInputUp(
                controller: _lastNameController, lableText: "Last Name"),
            const SizedBox(
              height: 20,
            ),
            TxtIpSuUsr(controller: _userNameController),
            const SizedBox(
              height: 20,
            ),
            TextInputUp(controller: _passwordController, lableText: "Password"),
            const SizedBox(
              height: 20,
            ),
            TextInputUp(
                controller: _cnfPasswordController,
                lableText: "Confirm Password"),
            const SizedBox(
              height: 25,
            ),
            Center(
              child: ElevatedButton(
                onPressed: () => {widget.handleSignUp(submit())},
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(220, 55),
                ),
                child: const Text(
                  "Sigin Up",
                  style: TextStyle(fontFamily: 'Montserrat', fontSize: 25),
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            const Center(
              child: Text(
                'Already a user?',
                style: TextStyle(fontSize: 18),
              ),
            ),
            Center(
              child: TextButton(
                onPressed: () => {
                  widget.changeSec(AuthDisplay.signIn),
                },
                child: const Text(
                  "Sign In",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
