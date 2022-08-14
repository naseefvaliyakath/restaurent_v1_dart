import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:restowrent_v_two/widget/snack_bar.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../../app_constans/api_link.dart';
import '../../../commoen/dio_error.dart';
import '../../../model/table_chair_set/table_chair_set.dart';
import '../../../model/table_chair_set/table_chair_set_response.dart';
import '../../../services/service.dart';

class CreateTableController extends GetxController {
  final HttpService _httpService = Get.find<HttpService>();

  int leftChairCount = 0;
  int rightChairCount = 0;
  int topChairCount = 0;
  int bottomChairCount = 0;

  String tableShape = '1';
  int roomId = -1;

  final RoundedLoadingButtonController btnControllerCreateTable = RoundedLoadingButtonController();

  @override
  void onInit() async {
    await getRoomIdFromArgs();
    super.onInit();
  }

  updateTableShape(String shapeId) {
    tableShape = shapeId;
    update();
  }
  //insert table chair set
  Future insertTable() async {
    try {
      if(!CheckAllChairIsZero())
      {
        Map<String, dynamic> tableChairSet = {
          'fdShopId': 10,
          'tableShape':tableShape,
          'room_id':roomId,
          'leftChairCount':leftChairCount,
          'rightChairCount':rightChairCount,
          'topChairCount':topChairCount,
          'bottomChairCount':bottomChairCount,
        };

        final response = await _httpService.insertWithBody(INSERT_TABLE, tableChairSet);

        TableChairSetResponse parsedResponse = TableChairSetResponse.fromJson(response.data);
        if (parsedResponse.error) {
          btnControllerCreateTable.error();
        } else {
          setAllChairZero();
          btnControllerCreateTable.success();
          update();
        }
      }
      else{
        btnControllerCreateTable.error();
        AppSnackBar.errorSnackBar('No chair added', 'Pleas add at least one chair');
      }


    } on DioError catch (e) {
      btnControllerCreateTable.error();
      AppSnackBar.errorSnackBar('Error', MyDioError.dioError(e));
    } catch (e) {
      btnControllerCreateTable.error();
      AppSnackBar.errorSnackBar('Error','Something Wrong !!');
    } finally {
      Future.delayed(const Duration(seconds: 1), () {
        btnControllerCreateTable.reset();
      });
      update();
    }
  }

  //to get roomId argmet from tale manage screen
  getRoomIdFromArgs() {
    print('get args');
    int roomIdGet = -1;
    var args = Get.arguments ?? {'roomId': -1};
    roomIdGet  = args['roomId'] ?? -1;
    //assign room id to global variable
    roomId = roomIdGet;
    print('get room id $roomId');
  }

  bool CheckAllChairIsZero() {
    if (leftChairCount == 0 && rightChairCount == 0 && topChairCount == 0 && bottomChairCount == 0) {
      return true;
    } else {
      return false;
    }
  }

  setAllChairZero() {
    leftChairCount = 0;
    rightChairCount = 0;
    topChairCount = 0;
    bottomChairCount = 0;
    update();
  }

  void addLeftChair() {
    leftChairCount++;
    update();
  }

  void removeLeftChair() {
    if (leftChairCount > 0) {
      leftChairCount--;
      update();
    }
  }

  void addRightChair() {
    rightChairCount++;
    update();
  }

  void removeRightChair() {
    if (rightChairCount > 0) {
      rightChairCount--;
      update();
    }
  }

  void addTopChair() {
    topChairCount++;
    update();
  }

  void removeTopChair() {
    if (topChairCount > 0) {
      topChairCount--;
      update();
    }
  }

  void addBottomChair() {
    bottomChairCount++;
    update();
  }

  void removeBottomChair() {
    if (bottomChairCount > 0) {
      bottomChairCount--;
      update();
    }
  }
}
