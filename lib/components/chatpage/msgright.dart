import 'package:flutter/material.dart';

class MsgRight extends StatefulWidget {
  late String text;
  late String time;

  MsgRight({required this.text, required this.time});

  @override
  _MsgRight createState() => _MsgRight();
}

class _MsgRight extends State<MsgRight> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(top: 15, bottom: 10, left: 50, right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Color(0xFF6E00FF),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Text(
                  widget.text,
                  style: TextStyle(
                    color: Colors.white,
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
      alignment: Alignment.topRight,
    );
  }
}
