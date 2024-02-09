import 'package:flutter/material.dart';
import '../../components/home/userlistitem.dart';
import 'package:http/http.dart';
import 'package:cookie_jar/cookie_jar.dart';

class ChatList extends StatefulWidget {
  late var list;
  ChatList({required this.list});
  @override
  _ChatList createState() => _ChatList();
}

class _ChatList extends State<ChatList> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: UserListItem(userName: 'ajay'),
    );
  }
}
