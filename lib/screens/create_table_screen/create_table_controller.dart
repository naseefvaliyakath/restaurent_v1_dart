import 'package:get/get.dart';

class CreateTableController extends GetxController {
  int leftChairCount = 0;
  int rightChairCount = 0;

  void addLeftChair() {
    leftChairCount ++;
    update();
  }

  void removeLeftChair() {
    if (leftChairCount > 0) {
      leftChairCount --;
      update();
    }
  }

  void addRightChair() {
    rightChairCount ++;
    update();
  }

  void removeRightChair() {
    if (rightChairCount > 0) {
      rightChairCount --;
      update();
    }
  }

}