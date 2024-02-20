import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pegion/global/consts.dart';
import '../sections/home/chatlist.dart';
import '../global/socket.dart';

class Home extends StatefulWidget {
  late String userName;
  late Function goToAuth;
  Home({super.key, required this.userName, required this.goToAuth}) {
    if (getSocket() == null) initSocket();
  }

  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  Future<void> logout() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/${authFile}');
      await file.writeAsString("", mode: FileMode.write);
      socketDisconnect();
      print("log details removed success");
    } catch (err) {
      print(err);
    } finally {
      widget.goToAuth();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.only(left: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                    height: 33,
                    child: Image(
                      image: AssetImage('assets/images/pegion_ico.png'),
                    ),
                  ),
                  SizedBox(width: 20),
                  Text(
                    'Pegion',
                    style: TextStyle(
                      fontSize: 30,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () => {logout()},
                child: Icon(
                  Icons.logout,
                ),
              ),
            ],
          ),
        ),
      ),
      body: ChatList(userName: widget.userName),
    );
  }
}
