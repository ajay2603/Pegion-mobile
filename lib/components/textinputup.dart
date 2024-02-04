import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TextInputUp extends StatefulWidget {
  final TextEditingController controller;
  final String lableText;
  bool obscureText;

  TextInputUp({
    super.key,
    required this.controller,
    required this.lableText,
    this.obscureText = false,
  });

  @override
  // ignore: library_private_types_in_public_api
  _TextInputUp createState() => _TextInputUp();
}

class _TextInputUp extends State<TextInputUp> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      style: const TextStyle(
          fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Montserrat'),
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFF6E00FF), width: 2.5),
          borderRadius: BorderRadius.circular(10),
        ),
        labelText: widget.lableText,
        labelStyle: const TextStyle(fontSize: 20),
        filled: true,
        fillColor: const Color.fromARGB(255, 227, 227, 227),
      ),
      obscureText: widget.obscureText,
    );
  }
}
