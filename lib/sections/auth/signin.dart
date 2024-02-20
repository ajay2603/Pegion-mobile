import 'package:flutter/material.dart';
import '../../components/forms/textinputin.dart';
import '../../global/enums.dart';

class SignIn extends StatefulWidget {
  final Function changeSec;
  final Function handleSignIn;

  const SignIn(
      {super.key, required this.changeSec, required this.handleSignIn});

  @override
  // ignore: library_private_types_in_public_api
  _SignIn createState() => _SignIn();
}

class _SignIn extends State<SignIn> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Map submit() {
    Map<String, String> signInData = {
      'userName': _userNameController.text,
      'password': _passwordController.text,
    };
    return signInData;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 15),
            child: Text(
              "Sign In",
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
          TextInputIn(
            controller: _userNameController,
            lableText: 'User Name',
            prefixIcon: const Icon(Icons.person),
          ),
          const SizedBox(
            height: 25,
          ),
          TextInputIn(
            controller: _passwordController,
            lableText: 'Password',
            prefixIcon: const Icon(Icons.lock),
            obscureText: true,
          ),
          const SizedBox(
            height: 30,
          ),
          Center(
            child: ElevatedButton(
              onPressed: () => {
                widget.handleSignIn(submit()),
              },
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(220, 55),
              ),
              child: const Text(
                "Sigin In",
                style: TextStyle(fontFamily: 'Montserrat', fontSize: 25),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          const Center(
            child: Text(
              'New to Pegion?',
              style: TextStyle(fontSize: 18),
            ),
          ),
          Center(
            child: TextButton(
              onPressed: () => {widget.changeSec(AuthDisplay.signUp)},
              child: const Text(
                "Sign Up",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
