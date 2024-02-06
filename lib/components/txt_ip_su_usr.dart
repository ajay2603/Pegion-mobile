import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as Http;
import '../consts.dart';

class TxtIpSuUsr extends StatefulWidget {
  final TextEditingController controller;
  TxtIpSuUsr({super.key, required this.controller});

  @override
  _TxtTxtIpSuUsr createState() => _TxtTxtIpSuUsr();
}

class _TxtTxtIpSuUsr extends State<TxtIpSuUsr> {
  late var http;
  _TxtTxtIpSuUsr() {
    http = Http.Client();
  }

  Color fColor = Color(0xFF6E00FF);
  bool isTextNull = true;

  void checkUser() async {
    String userName = widget.controller.text.trim();
    if (userName == '') {
      setState(() {
        isTextNull = true;
        fColor = Color(0xFF6E00FF);
        return;
      });
    } else {
      setState(() {
        isTextNull = false;
      });
    }
    try {
      final response = await http.post(
        Uri.parse('$domain/api/user-auth/check-user-exist'),
        body: {"userName": userName},
      );
      final result = jsonDecode(response.body);
      if (result['stat'] && !result['err']) {
        setState(() {
          fColor = Colors.red;
        });
      } else if (!result['stat'] && !result['err']) {
        fColor = Colors.green;
      } else {
        print("Error in fetching data");
      }
      if (userName == '') {
        setState(() {
          fColor = Color(0xFF6E00FF);
        });
      }
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      style: const TextStyle(
          fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Montserrat'),
      onChanged: (value) {
        checkUser();
      },
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: (isTextNull) ? Color.fromARGB(255, 144, 144, 144) : fColor,
              width: 2.5),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: fColor, width: 2.5),
          borderRadius: BorderRadius.circular(10),
        ),
        labelText: 'User Name',
        labelStyle:
            TextStyle(fontSize: 20, color: (isTextNull) ? null : fColor),
        filled: true,
        fillColor: const Color.fromARGB(255, 227, 227, 227),
      ),
    );
  }
}
