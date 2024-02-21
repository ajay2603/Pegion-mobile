import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as HTTP;
import 'package:uuid/uuid.dart';
import '../../global/user.dart';
import '../../global/consts.dart';

class MessageBox extends StatefulWidget {
  late String chatUser;
  late Function addNewMsg;
  late Function removeMsg;
  late Function updateMsgTime;
  MessageBox(
      {required this.chatUser,
      required this.addNewMsg,
      required this.removeMsg,
      required this.updateMsgTime});

  @override
  _MessageBox createState() => _MessageBox();
}

class _MessageBox extends State<MessageBox> {
  late var uuid;
  late var http;
  _MessageBox() {
    uuid = Uuid();
    http = HTTP.Client();
  }

  TextEditingController _controller = new TextEditingController();

  void sendMessage() async {
    String id = uuid.v4();
    String text = _controller.text.trim();
    String user = getUserG();
    if (text == "") {
      return;
    }
    Map<String, String> msg = {
      'id': id,
      'text': text,
      'user': user,
      'time': 'Sending...'
    };
    widget.addNewMsg(msg);
    _controller.text = "";

    try {
      var response = await http
          .post(Uri.parse('${domain}/api/messages/chats/send-message'), body: {
        'toUser': widget.chatUser,
        'message': text,
        'msgId': id,
        'userName': getUserG(),
        'logID': getLogIdG()
      });
      var result = jsonDecode(response.body);
      print(result);
      if (result['stat']) {
        widget.updateMsgTime(id, result['time']);
      } else {
        print("else");
        widget.removeMsg(id);
      }
    } catch (err) {
      widget.removeMsg(id);
      print(err);
    }
  }

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
                  controller: _controller,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter your message",
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  sendMessage();
                },
                splashColor: Colors.transparent,
                icon: Icon(
                  Icons.send_rounded,
                  color: Color(0xFF6E00FF),
                  size: 30,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
