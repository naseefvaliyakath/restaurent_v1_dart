import 'package:get/get.dart';
import 'package:restowrent_v_two/socket/socket_controller.dart';
import '../../../model/kitchen_order_response/kitchen_order.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../../model/kitchen_order_response/order_bill.dart';

class OrderViewController extends GetxController {
  IO.Socket _socket = Get.find<SocketController>().socket;
  bool isLoading = false;
  bool isloading2 = false;

  //tochane tapped coloer of ordr status tab
  int tappedIndex = 0;

  List<KitchenOrder>? _billingItems = [];

  List<KitchenOrder>? get billingItems => _billingItems;

  @override
  void onInit() async {
    _socket.connect();
    setUpKitchenOrderListner();
    super.onInit();
  }

  setUpKitchenOrderListner() {
    try {
      KitchenOrder order =
          KitchenOrder(fdOrderType: '', totelPrice: 0, fdOrderStatus: '', id: 0, errorCode: '', totalSize: 0, error: true);
      _socket.on('kitchen_orders_recive', (data) {
        order = KitchenOrder.fromJson(data);
        //no error
        if (!order.error) {
          _billingItems!.add(order);
          update();
        }
        else{
          return;
        }
      });
    } catch (e) {
      rethrow;
    }
  }

  //to change tapped category
  setStatusTappedIndex(int val) {
    tappedIndex = val;
    update();
  }

  showLoading() {
    isLoading = true;
  }

  hideLoading() {
    isLoading = false;
  }
}
