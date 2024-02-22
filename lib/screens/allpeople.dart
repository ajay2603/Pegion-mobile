import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pegion/components/home/userlistitem.dart';
import 'package:pegion/components/showalertdialog.dart';
import 'package:pegion/global/consts.dart';
import 'package:http/http.dart' as Http;

class People extends StatefulWidget {
  late String userName;
  late Function moveToTop;
  People({required this.moveToTop});

  @override
  _People createState() => _People();
}

class _People extends State<People> {
  late var http;
  var list = [];

  _People() {
    this.http = Http.Client();
    getList('');
  }

  Widget display = Center(
    child: Container(
      child: LoadingAnimationWidget.staggeredDotsWave(
        color: Color(0xFF6E00FF),
        size: 65,
      ),
    ),
  );

  void getList(String searchVal) async {
    try {
      var response = await http.get(Uri.parse(
          '$domain/api/fetch/user-details/get-search-users-list?userName=${searchVal}'));

      print(response.body);
      var result = jsonDecode(response.body);
      if (result['stat']) {
        setState(() {
          list = List.from(result['list']); // Update the list here
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
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          automaticallyImplyLeading: false,
          title: Padding(
            padding: EdgeInsets.only(left: 8),
            child: Row(
              children: [
                GestureDetector(
                  child: Icon(Icons.arrow_back_ios_rounded),
                  onTap: () => Navigator.pop(context),
                ),
                SizedBox(
                  width: 15,
                ),
                Text(
                  'People',
                  style: TextStyle(
                    fontSize: 30,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    onChanged: (value) {
                      getList(value.trim());
                    },
                    decoration: InputDecoration(
                        hintText: "Search user here",
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color.fromARGB(255, 144, 144, 144),
                              width: 1.5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color(0xFF6E00FF), width: 1.5),
                          borderRadius: BorderRadius.circular(10),
                        )),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: (list.length != 0)
                ? ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      return UserListItem(
                        key: ValueKey(list[
                            index]), // Use ValueKey with a unique identifier
                        userName: list[index],
                        moveToTop: widget.moveToTop,
                      );
                    },
                  )
                : Center(
                    child: Text("No User Found"),
                  ),
          ),
        ],
      ),
    );
  }
}
