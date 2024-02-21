import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as Http;
import 'package:pegion/components/chatpage/msgdisp.dart';
import 'package:pegion/global/user.dart';
import '../global/consts.dart';
import '../sections/chatpage/messagebox.dart';
import '../global/socket.dart';

class ChatPage extends StatefulWidget {
  late String chatUserName;
  ChatPage({required this.chatUserName});
  @override
  _ChatPage createState() => _ChatPage(chatUserName: chatUserName);
}

class LoadingName extends StatefulWidget {
  @override
  _LoadingName createState() => _LoadingName();
}

class _LoadingName extends State<LoadingName> {
  _LoadingName() {
    startTimer();
  }

  List<String> dots = ["   ", ".  ", ".. ", "...", " ..", "  ."];
  int indx = 0;

  void startTimer() {
    Timer.periodic(const Duration(milliseconds: 200), (timer) {
      if (indx == 5) {
        setState(() {
          indx = 0;
        });
      } else {
        setState(() {
          indx++;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return (Text(
      "Fetching data${dots[indx]}",
      style: TextStyle(fontSize: 18),
    ));
  }
}

class _ChatPage extends State<ChatPage> {
  late var http;
  late String chatUserName;
  _ChatPage({required this.chatUserName}) {
    http = Http.Client();
    getUser();
    getPrevMessages();
    handleEvents();
  }

  Widget imgDisp = Image.asset(
    'assets/images/prf-load.png',
    height: 42,
  );

  Widget nameDisp = LoadingName();

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
          (getUserG() == chatUserName)
              ? "Me"
              : '${result['firstName']} ${result['lastName']}',
          style: TextStyle(fontSize: 18),
        );
      });
    } catch (err) {
      print(err);
    }
  }

  List prevChat = [];
  void getPrevMessages() async {
    try {
      var response = await http.post(
          Uri.parse('$domain/api/messages/chats/fetch-previous-messages'),
          body: {
            'toUser': chatUserName,
            'userName': getUserG(),
            'logID': getLogIdG()
          });
      var result = jsonDecode(response.body);
      setState(() {
        prevChat = result['messages'];
      });
    } catch (err) {
      print(err);
    }
  }

  List liveChat = [];

  bool msgExist(id) {
    for (var msg in liveChat) {
      if (msg['id'] == id) {
        return true;
      }
    }
    return false;
  }

  void addNewMsg(Map<String, String> msg) {
    setState(() {
      liveChat.add(msg);
    });
  }

  void removeMsg(id) {
    setState(() {
      liveChat.removeWhere((msg) => msg['id'] == id);
    });
  }

  void updateMsgTime(id, time) {
    setState(() {
      for (var msg in liveChat) {
        if (msg['id'] == id) {
          msg['time'] = time;
          return;
        }
      }
    });
  }

  void addNewMsgStr(data) async {
    var msg = data['msg'];
    List users = [data['from'], data['to']];
    if (msgExist(msg['id'])) {
      return;
    }
    if (data['from'] != chatUserName || data['to'] != chatUserName) {
      return;
    }
    Map<String, String> newMsg = {
      'id': msg['id'],
      'text': msg['text'],
      'user': msg['user'],
      'time': msg['time']
    };
    addNewMsg(newMsg);
  }

  void handleEvents() {
    var socket = getSocket();
    socket?.on("resLiveMsg", (data) {
      addNewMsgStr(data);
    });
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
                      nameDisp,
                      SizedBox(
                        height: 3,
                      ),
                      Text(
                        chatUserName,
                        style: TextStyle(
                          fontSize: 13,
                          fontStyle: FontStyle.italic,
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
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              reverse: true,
              child: Column(
                children: [
                  Column(
                    children: [for (var msg in prevChat) MsgDisp(details: msg)],
                  ),
                  Column(
                    children: [for (var msg in liveChat) MsgDisp(details: msg)],
                  )
                ],
              ),
            ),
          ),
          MessageBox(
            chatUser: widget.chatUserName,
            addNewMsg: addNewMsg,
            removeMsg: removeMsg,
            updateMsgTime: updateMsgTime,
          ),
        ],
      ),
    );
  }
}
