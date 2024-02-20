import 'dart:io';

import 'package:socket_io_client/socket_io_client.dart' as IO;
import './consts.dart';
import './user.dart';

IO.Socket? socket;

void initSocket() async {
  try {
    socket = IO.io(
      domain,
      IO.OptionBuilder()
          .setTransports(['websocket']) // for Flutter or Dart VM
          .setQuery({
            'userName': getUserG(),
            'logID': getLogIdG()
          }) // add your query here
          .disableAutoConnect() // disable auto-connection
          .build(),
    );
    socket?.connect();
    socket?.onConnect((data) {
      print("connected to socket");
    });
  } catch (err) {
    print(err);
  }
}

IO.Socket? getSocket() {
  return socket;
}

void socketDisconnect() {
  socket?.disconnect();
}
