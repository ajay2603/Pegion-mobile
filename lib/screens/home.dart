import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pegion/components/showalertdialog.dart';
import 'package:pegion/global/consts.dart';
import '../components/home/userlistitem.dart';
import '../global/socket.dart';
import '../screens/allpeople.dart';
import '../global/user.dart';
import 'package:http/http.dart' as HTTP;

class Home extends StatefulWidget {
  late String userName;
  late Function goToAuth;
  Home({super.key, required this.userName, required this.goToAuth}) {
    if (getSocket() == null) initSocket();
  }

  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  late var http;
  bool loading = true;
  _Home() {
    http = HTTP.Client();
    getList();
    handleEvents();
  }

  Future<void> logout() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/${authFile}');
      await file.writeAsString("", mode: FileMode.write);
      socketDisconnect();
      print("log details removed success");
    } catch (err) {
      print(err);
    } finally {
      widget.goToAuth();
    }
  }

  List list = [];

  void getList() async {
    var userName = getUserG();
    var logID = getLogIdG();
    try {
      var response = await http.post(
          Uri.parse('$domain/api/fetch/user-details/get-user-chats'),
          body: {"userName": userName, "logID": logID});

      var result = jsonDecode(response.body);
      if (result['stat']) {
        setState(() {
          list = result['chats']; // Add this line
        });
        loading = false;
      } else {
        showAlertDialog(context, 'Error', 'Error in fetching data');
      }
    } catch (err) {
      print("Error in connecting to network");
      print(err);
      showAlertDialog(context, 'Error', 'Error in connecting server');
    }
  }

  void handleEvents() {
    var socket = getSocket();
    socket?.on('newLiveChat', (user) {
      if (!list.contains(user)) {
        list.insert(0, user);
      }
      moveToTop(user);
    });
  }

  void moveToTop(user) {
    List updatedList = [...list];
    updatedList.remove(user);
    updatedList.insert(0, user);
    setState(() {
      list = updatedList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          title: Padding(
            padding: EdgeInsets.only(left: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(
                      height: 33,
                      child: Image(
                        image: AssetImage('assets/images/pegion_ico.png'),
                      ),
                    ),
                    SizedBox(width: 20),
                    Text(
                      'Pegion',
                      style: TextStyle(
                        fontSize: 30,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () => {logout()},
                  child: Icon(
                    Icons.logout,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: (loading)
          ? Center(
              child: Container(
                child: LoadingAnimationWidget.staggeredDotsWave(
                  color: Color(0xFF6E00FF),
                  size: 65,
                ),
              ),
            )
          : Padding(
              padding: EdgeInsets.only(top: 10),
              child: (list.isNotEmpty) // Check if list is not empty
                  ? ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        return UserListItem(
                          key: ValueKey(list[
                              index]), // Use ValueKey with a unique identifier
                          userName: list[index],
                          moveToTop: moveToTop,
                        );
                      },
                    )
                  : Center(
                      child: Text("No recent chats"),
                    ),
            ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.person_add_alt_1_rounded,
          size: 28,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => People(
                moveToTop: moveToTop,
              ),
            ),
          );
        },
      ),
    );
  }
}
