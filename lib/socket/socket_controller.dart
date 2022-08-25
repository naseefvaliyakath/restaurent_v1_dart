import 'package:get/get.dart';
import 'package:restowrent_v_two/widget/snack_bar.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;


class SocketController extends GetxController {
  late IO.Socket socket;

  @override
  void onClose() {
    socket.dispose();
    super.onClose();
  }

  @override
  Future<void> onInit() async {
    await initSocket();
    socket.on("connect_error", (data) {
      print(data);
    });

    socket.on("connect", (data) {
      print('socket connected');
    });

    socket.on("disconnect", (data) {
      print('socket disconnect');
    });
    super.onInit();
  }

  //initialize socket
  initSocket() async {
    socket = IO.io(
        'https://mobizate.com',
        IO.OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .disableAutoConnect()
            .setPath('/socket.io/') // disable auto-connection
            .build());
  }




}
