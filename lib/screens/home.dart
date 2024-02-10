import 'package:flutter/material.dart';
import '../sections/home/chatlist.dart';

class Home extends StatefulWidget {
  late String userName;
  Home({super.key, required this.userName});

  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.only(left: 8),
          child: Row(
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
        ),
      ),
      body: ChatList(userName: widget.userName),
    );
  }
}
