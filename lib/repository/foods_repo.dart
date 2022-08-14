import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:restowrent_v_two/model/category_respons/category_response.dart';
import 'package:restowrent_v_two/model/foods_respons/food_response.dart';
import 'package:restowrent_v_two/model/room_respons/room_response.dart';
import 'package:restowrent_v_two/model/settled_order_response/settled_order_array.dart';
import 'package:restowrent_v_two/model/table_chair_set/table_chair_set.dart';

import '../app_constans/api_link.dart';
import '../commoen/dio_error.dart';
import '../model/my_response.dart';
import '../model/table_chair_set/table_chair_set_response.dart';
import '../services/service.dart';
import '../widget/snack_bar.dart';

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
    catch (e) {
      rethrow;
      return MyResponse(statusCode: 0, status: 'Error', message: 'Error');
    } finally {

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
    catch (e) {
      return MyResponse(statusCode: 0, status: 'Error', message: 'Error');
    } finally {

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
    catch (e) {
      return MyResponse(statusCode: 0, status: 'Error', message: 'Error');
    } finally {

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
    catch (e) {
      return MyResponse(statusCode: 0, status: 'Error', message: 'Error');
    } finally {

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
    catch (e) {
      return MyResponse(statusCode: 0, status: 'Error', message: 'Error');
    } finally {

    }
  }


  Future<MyResponse> geTableSet(int fdShopId) async {
    // TODO: implement getNewsHeadline

    try {
      final response = await _httpService.getRequestWithBody(GET_TABLE_SET, {'fdShopId': fdShopId});
      TableChairSetResponse? parsedResponse = TableChairSetResponse.fromJson(response.data);
      return MyResponse(
          statusCode: 1,
          status: 'Success',
          data: parsedResponse,
          message: response.statusMessage.toString());
    } on DioError catch (e) {
      return MyResponse(statusCode: 0, status: 'Error', message: MyDioError.dioError(e));
    }
    catch (e) {
      rethrow;
      return MyResponse(statusCode: 0, status: 'Error', message: 'Error');
    } finally {

    }
  }

  Future<MyResponse> getRoom() async {
    // TODO: implement getNewsHeadline

    try {
      final response = await _httpService.getRequestWithBody(GET_ALL_ROOMS, {'fdShopId': 10});
      RoomResponse parsedResponse = RoomResponse.fromJson(response.data);
      return MyResponse(
          statusCode: 1,
          status: 'Success',
          data: parsedResponse,
          message: response.statusMessage.toString());
    } on DioError catch (e) {
      return MyResponse(statusCode: 0, status: 'Error', message: MyDioError.dioError(e));
    }
    catch (e) {
      return MyResponse(statusCode: 0, status: 'Error', message: 'Error');
    } finally {

    }
  }

  Future<MyResponse> getAllSettledOrder() async {
    // TODO: implement getNewsHeadline

    try {
      final response = await _httpService.getRequest(ALL_SETTLED_ORDER);
      SettledOrderArray parsedResponse = SettledOrderArray.fromJson(response.data);
      return MyResponse(
          statusCode: 1,
          status: 'Success',
          data: parsedResponse,
          message: response.statusMessage.toString());
    } on DioError catch (e) {
      return MyResponse(statusCode: 0, status: 'Error', message: MyDioError.dioError(e));
    }
    catch (e) {
      return MyResponse(statusCode: 0, status: 'Error', message: 'Error');
    } finally {

    }
  }

}
