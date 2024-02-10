import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as Http;
import 'package:path_provider/path_provider.dart';
import 'package:pegion/components/showalertdialog.dart';
import '../../components/home/userlistitem.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../consts.dart';

class ChatList extends StatefulWidget {
  late var userName;
  ChatList({required this.userName});
  @override
  _ChatList createState() => _ChatList();
}

class _ChatList extends State<ChatList> {
  late var http;
  var list = [];

  Widget display = Center(
    child: Container(
      child: LoadingAnimationWidget.staggeredDotsWave(
        color: Color(0xFF6E00FF),
        size: 65,
      ),
    ),
  );

  void setList(list) {
    if (list.length != 0) {
      setState(() {
        display = SingleChildScrollView(
          child: Column(
            children: [
              for (var username in list) UserListItem(userName: username),
            ],
          ),
        );
      });
    } else {
      setState(() {
        display = Center(
          child: Text("No recent chats"),
        );
      });
    }
  }

  _ChatList() {
    this.http = Http.Client();
    getList();
  }

  void getList() async {
    var userName;
    var logID;
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/${authFile}');
      String jsText = await file.readAsString();
      var authDetails = jsonDecode(jsText);
      userName = authDetails['userName'];
      logID = authDetails['logID'];
    } catch (err) {
      print(err);
    }

    try {
      var response = await http.post(
          Uri.parse('$domain/api/fetch/user-details/get-user-chats'),
          body: {"userName": userName, "logID": logID});

      var result = jsonDecode(response.body);
      if (result['stat']) {
        setState(() {
          list = result['chats'];
          setList(list); // Add this line
        });
      } else {
        showAlertDialog(context, 'Error', 'Error in fetching data');
      }
    } catch (err) {
      print("Error in connecting to network");
      print(err);
      showAlertDialog(context, 'Error', 'Error in connecting server');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: display);
  }
}
