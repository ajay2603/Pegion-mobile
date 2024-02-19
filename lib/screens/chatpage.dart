import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as Http;
import '../consts.dart';

class ChatPage extends StatefulWidget {
  late String chatUserName;
  ChatPage({required this.chatUserName});
  @override
  _ChatPage createState() => _ChatPage(chatUserName: chatUserName);
}

class _ChatPage extends State<ChatPage> {
  late var http;
  late String chatUserName;
  _ChatPage({required this.chatUserName}) {
    http = Http.Client();
    getUser();
  }

  Widget imgDisp = Image.asset(
    'assets/images/prf-load.png',
    height: 42,
  );

  Widget nameDisp = Container(
    height: 17,
    width: 150,
    color: Color.fromARGB(255, 207, 207, 207),
  );

  void getUser() async {
    try {
      var response = await http.get(Uri.parse(
          '$domain/api/fetch/user-details/chat-list-info?userName=${chatUserName}'));
      var result = jsonDecode(response.body);

      setState(() {
        imgDisp = Image.network(
          '$domain${result['profilePicPath']}',
          height: 42,
        );

        nameDisp = Text(
          '${result['firstName']} ${result['lastName']}',
          style: TextStyle(fontSize: 18),
        );
      });
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    child: Icon(Icons.arrow_back_ios_rounded),
                    onTap: () => Navigator.pop(context),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        width: 3,
                        color: Color.fromARGB(255, 73, 0, 170),
                      ),
                    ),
                    child: ClipOval(
                      child: imgDisp,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SingleChildScrollView(
                        child: nameDisp,
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      SingleChildScrollView(
                        child: SingleChildScrollView(
                          child: Text(
                            chatUserName,
                            style: TextStyle(
                              fontSize: 13,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(
                    Icons.videocam_outlined,
                    size: 33,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Icon(
                    Icons.call_outlined,
                    size: 28,
                  )
                ],
              )
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Text('Chat Area'),
            ),
          ),
          Container(
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
                        icon: Icon(
                          Icons.send_rounded,
                          color: Color(0xFF6E00FF),
                          size: 30,
                        ))
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
