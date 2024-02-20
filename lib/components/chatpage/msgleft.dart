import 'package:flutter/material.dart';

class MsgLeft extends StatefulWidget {
  late String text;
  late String time;

  MsgLeft({required this.text, required this.time});

  @override
  _MsgLeft createState() => _MsgLeft();
}

class _MsgLeft extends State<MsgLeft> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(top: 15, bottom: 10, left: 15, right: 70),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 227, 227, 227),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  topLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Text(
                  widget.text,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              widget.time,
              style: TextStyle(
                  color: const Color.fromARGB(255, 110, 110, 110),
                  fontSize: 12),
            ),
          ],
        ),
      ),
      width: double.maxFinite,
    );
  }
}
