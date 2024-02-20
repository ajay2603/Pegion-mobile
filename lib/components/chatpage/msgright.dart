import 'package:flutter/material.dart';

class MsgRight extends StatefulWidget {
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
                  "HelloHelloHellHelloHloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHelloHello",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "5:30 PM",
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
