import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:restowrent_v_two/model/category_respons/category_response.dart';
import 'package:restowrent_v_two/model/foods_respons/food_response.dart';

import '../app_constans/api_link.dart';
import '../commoen/dio_error.dart';
import '../model/my_response.dart';
import '../services/service.dart';

class FoodsRepo {
  HttpService _httpService = HttpService();

  FoodsRepo() {
    _httpService = Get.put(HttpService());
  }

  Future<MyResponse> getTodayFoods() async {
    // TODO: implement getNewsHeadline

    try {
      final response = await _httpService.getRequest(TODAY_FOOD_URL);
      FoodResponse parsedResponse = FoodResponse.
      fromJson(response.data);
      return MyResponse(
          statusCode: 1,
          status: 'Success',
          data: parsedResponse,
          message: response.statusMessage.toString());
    } on DioError catch (e) {
      return MyResponse(statusCode: 0, status: 'Error', message: MyDioError.dioError(e));
    }
  }

  Future<MyResponse> getAllFoods() async {
    // TODO: implement getNewsHeadline

    try {
      final response = await _httpService.getRequest(ALL_FOOD_URL);
      FoodResponse parsedResponse = FoodResponse.fromJson(response.data);
      return MyResponse(
          statusCode: 1,
          status: 'Success',
          data: parsedResponse,
          message: response.statusMessage.toString());
    } on DioError catch (e) {
      return MyResponse(statusCode: 0, status: 'Error', message: MyDioError.dioError(e));
    }
  }


  Future<MyResponse> searchTodayFoods(String query, String fdIsToday) async {
    // TODO: implement getNewsHeadline

    try {
      // fdIsToday has no effect
      final response = await _httpService.getRequestWithBody(SEARCH_TODAY_FOOD,{'fdName':query,'fdIsToday': fdIsToday});
      FoodResponse parsedResponse = FoodResponse.fromJson(response.data);
      return MyResponse(
          statusCode: 1,
          status: 'Success',
          data: parsedResponse,
          message: response.statusMessage.toString());
    } on DioError catch (e) {
      return MyResponse(statusCode: 0, status: 'Error', message: MyDioError.dioError(e));
    }
  }

  Future<MyResponse> searchAllFoods(String query, String fdIsToday) async {
    // TODO: implement getNewsHeadline

    try {
      // fdIsToday has no effect
      final response = await _httpService.getRequestWithBody(SEARCH_ALL_FOOD,{'fdName':query,'fdIsToday': fdIsToday});
      FoodResponse parsedResponse = FoodResponse.fromJson(response.data);
      return MyResponse(
          statusCode: 1,
          status: 'Success',
          data: parsedResponse,
          message: response.statusMessage.toString());
    } on DioError catch (e) {
      return MyResponse(statusCode: 0, status: 'Error', message: MyDioError.dioError(e));
    }
  }

  Future<MyResponse> getCategory() async {
    // TODO: implement getNewsHeadline

    try {
      final response = await _httpService.getRequestWithBody(GET_CATEGORY, {'fdShopId': 10});
      CategoryResponse parsedResponse = CategoryResponse.fromJson(response.data);
      return MyResponse(
          statusCode: 1,
          status: 'Success',
          data: parsedResponse,
          message: response.statusMessage.toString());
    } on DioError catch (e) {
      return MyResponse(statusCode: 0, status: 'Error', message: MyDioError.dioError(e));
    }
  }



}
