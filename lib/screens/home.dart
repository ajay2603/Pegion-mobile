import 'package:flutter/material.dart';
import '../components/home/userlistitem.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Home extends StatefulWidget {
  late String userName;
  Home({super.key, required this.userName});

  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  Widget display = Center(
    child: Container(
      child: LoadingAnimationWidget.staggeredDotsWave(
        color: Color(0xFF6E00FF),
        size: 65,
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.only(left: 8),
          child: Row(
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
        ),
      ),
      body: display,
    );
  }
}
