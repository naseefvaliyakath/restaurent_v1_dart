import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:restowrent_v_two/app_constans/hive_costants.dart';
class MyLocalStorage extends GetxController {

  // to save  details temperly
  Future<void> setData(String key , dynamic data) async {
    try {
      await Hive.initFlutter();
      var box = await Hive.openBox(HIVE_BOX_NAME);
      box.put(key,data );
      print('Hive added data');
    } catch (e) {
      rethrow;
    }


  }

  //to read  data
  Future<dynamic> readData(String key) async {
    try {
      await Hive.initFlutter();
      var box = await Hive.openBox(HIVE_BOX_NAME);
      var result = box.get(key);
      print('Hive Result : $result');
      return result;

    } catch (e) {
      rethrow;
    }
  }

  //to remove  data
  Future<void> removeData(String key) async {
    try {
      await Hive.initFlutter();
      var box = await Hive.openBox(HIVE_BOX_NAME);
      box.delete(key);
      print('Hive delete data');
    } catch (e) {
     rethrow;
    }
  }

}
