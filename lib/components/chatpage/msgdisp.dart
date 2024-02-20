import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import '../../global/user.dart';
import './msgleft.dart';
import './msgright.dart';

class MsgDisp extends StatefulWidget {
  late Map details;
  MsgDisp({required this.details});

  _MsgDisp createState() => _MsgDisp();
}

class _MsgDisp extends State<MsgDisp> {
  String convertTo12HourFormat(String timestampString) {
    try {
      DateTime dateTime = DateTime.parse(timestampString).toLocal();
      String formattedTime = DateFormat('h:mm a').format(dateTime);
      return formattedTime;
    } catch (e) {
      print('Error parsing timestamp: $e');
      return timestampString; // Return original string if parsing fails
    }
  }

  Widget build(BuildContext context) {
    return (widget.details['user'] == getUserG())
        ? MsgRight(
            text: widget.details['text'],
            time: convertTo12HourFormat(widget.details['time']),
          )
        : MsgLeft(
            text: widget.details['text'],
            time: convertTo12HourFormat(widget.details['time']),
          );
  }
}
