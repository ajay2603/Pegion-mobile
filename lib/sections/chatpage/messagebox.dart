import 'package:flutter/material.dart';

class MessageBox extends StatefulWidget {
  @override
  _MessageBox createState() => _MessageBox();
}

class _MessageBox extends State<MessageBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 213, 213, 214),
      height: 60,
      child: Center(
        child: Padding(
          padding: EdgeInsets.only(left: 15, right: 5),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter your message",
                  ),
                ),
              ),
              IconButton(
                  onPressed: () {},
                  splashColor: Colors.transparent,
                  icon: Icon(
                    Icons.send_rounded,
                    color: Color(0xFF6E00FF),
                    size: 30,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
