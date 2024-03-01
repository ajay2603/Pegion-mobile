import 'package:pegion/global/user.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import './consts.dart';

IO.Socket? socket = null;

void initSocket() async {
  try {
    Map query = {
      'userName': getUserG(),
      'logID': getLogIdG(),
      'fcmToken': getFcmToken()
    };
    IO.OptionBuilder options =
        IO.OptionBuilder().setTransports(['websocket']).setQuery(query);
    socket = IO.io(
      domain,
      options
          .disableAutoConnect() // disable auto-connection
          .build(),
    );
    socket?.connect();
    socket?.onConnect((data) {
      print("connected to socket");
      setSocket(socket);
    });
  } catch (err) {
    print("Error occured");
    print(err);
  }
}

void setSocket(soc) {
  socket = soc;
}

IO.Socket? getSocket() {
  return socket;
}

void socketDisconnect() {
  print("disconnected");
  socket?.disconnect();
}
