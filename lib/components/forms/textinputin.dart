import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TextInputIn extends StatefulWidget {
  final TextEditingController controller;
  final String lableText;
  final Icon prefixIcon;
  bool obscureText;

  TextInputIn({
    super.key,
    required this.controller,
    required this.lableText,
    required this.prefixIcon,
    this.obscureText = false,
  });

  @override
  // ignore: library_private_types_in_public_api
  _TextInputIn createState() => _TextInputIn();
}

class _TextInputIn extends State<TextInputIn> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      style: const TextStyle(fontSize: 16),
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
              color: Color.fromARGB(255, 144, 144, 144), width: 2.5),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFF6E00FF), width: 2.5),
          borderRadius: BorderRadius.circular(10),
        ),
        labelText: widget.lableText,
        prefixIcon: widget.prefixIcon,
        labelStyle: const TextStyle(fontSize: 20),
        filled: true,
        fillColor: const Color.fromARGB(255, 227, 227, 227),
      ),
      obscureText: widget.obscureText,
    );
  }
}
