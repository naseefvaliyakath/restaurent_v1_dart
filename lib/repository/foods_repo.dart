import 'package:get/get.dart';

import '../services/service.dart';

class FoodsRepo {
  HttpService _httpService = HttpService();

  FoodsRepo() {
    _httpService = Get.put(HttpService());
  }

  Future getTodayFoods() async {
    // TODO: implement getNewsHeadline

    try {
      final response = await _httpService.getRequest('food/getAllFood');
      print(response.data);
      return response;
    } on Exception catch (e) {
      print(e);
      return null;
    }
  }
}
