import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pegion/screens/chatpage.dart';
import '../../global/consts.dart';
import 'package:http/http.dart' as Http;
import '../../global/user.dart';

class UserListItem extends StatefulWidget {
  late String userName;
  UserListItem({required this.userName});
  @override
  _UserListItem createState() => _UserListItem(userName: userName);
}

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 15),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                  width: 2, color: Color.fromARGB(255, 213, 213, 214)),
            ),
            child: ClipOval(
              child: Image.asset(
                'assets/images/prf-load.png',
                height: 47,
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 15,
                width: 200,
                child: Container(
                  color: const Color.fromARGB(255, 205, 205, 205),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              SizedBox(
                height: 15,
                width: 70,
                child: Container(
                  color: const Color.fromARGB(255, 205, 205, 205),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class User extends StatelessWidget {
  late String userName;
  late String name;
  late String pic;

  User({required this.userName, required this.name, required this.pic});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatPage(
              chatUserName: userName,
            ),
          ),
        );
      },
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) {
              return const Color.fromARGB(
                  255, 213, 213, 214); // This is the color of the ripple
            }
            return null; // Defer to the widget's default.
          },
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 5),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                    width: 2, color: Color.fromARGB(255, 213, 213, 214)),
              ),
              child: ClipOval(
                child: Image.network(
                  '$domain$pic',
                  height: 47,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                Text(
                  userName,
                  style: TextStyle(
                      color: Color.fromARGB(255, 102, 102, 102),
                      fontStyle: FontStyle.italic),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _UserListItem extends State<UserListItem> {
  Widget disp = Loading();
  late var http;
  late String userName;

  _UserListItem({required this.userName}) {
    http = Http.Client();
    getUser();
  }

  void getUser() async {
    try {
      var response = await http.get(Uri.parse(
          '$domain/api/fetch/user-details/chat-list-info?userName=$userName'));
      var result = jsonDecode(response.body);
      setState(() {
        disp = User(
          pic: result['profilePicPath'],
          userName: userName,
          name: (userName == getUserG())
              ? "Me"
              : (result['firstName'] + " " + result['lastName']),
        );
      });
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      /*decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(width: 2, color: Color(0xFFE5E7EB)))),*/
      height: 70,
      child: disp,
    );
  }
}
