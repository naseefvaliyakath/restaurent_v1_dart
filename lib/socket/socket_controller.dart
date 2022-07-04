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
      //print(data);
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
            .setPath('/socket.io') // disable auto-connection
            .build());
  }

  //emit data
  sendDataAck(data) {
    try {
      //check interet coectio then only coect else it try to coect again ad again
      socket.connect();
      socket.emitWithAck('kitchen_orders', data, ack: (dataAck) {
        if (dataAck == 'success') {
          print('suceess');
          return false;
        } else {
          if (dataAck == 'error') {
            AppSnackBar.errorSnackBar('Error', 'Something wnt to wrong !');
            return true;
          } else {
            AppSnackBar.errorSnackBar('Error', 'Something wnt to wrong !');
            return true;
          }
        }
      });
    }catch (e) {
      return true;
      rethrow;
    }
  }


}
