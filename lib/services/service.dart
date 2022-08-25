import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:restowrent_v_two/app_constans/api_link.dart';

import '../commoen/dio_error.dart';
import '../widget/snack_bar.dart';

class HttpService {
  Dio _dio = Dio();

  HttpService() {
    _dio = Dio(BaseOptions(baseUrl: BASE_URL, headers: {"Authorization": "Bearer $API_KEY"}));

    initializeInterceptors();
  }

  Future<Response> getRequest(String url) async {
    // TODO: implement getRequest

    Response response;
    try {
      response = await _dio.get(url);
    } on DioError catch (e) {
      throw Exception(e.message);
    } catch (e) {
      rethrow;
    } finally {}

    return response;
  }

  Future<Response> getRequestWithBody(String url, body) async {
    // TODO: implement getRequest

    Response response;
    try {
      response = await _dio.get(url, queryParameters: body);
    } on DioError catch (e) {
      throw Exception(e.message);
    } catch (e) {
      rethrow;
    } finally {}

    return response;
  }

  //delete with id
  Future<Response> delete(String url, body) async {
    // TODO: implement getRequest

    Response response;
    try {
      response = await _dio.delete(url, data: json.encode(body));
    } on DioError catch (e) {
      throw Exception(e.message);
    } catch (e) {
      rethrow;
    } finally {}

    return response;
  }

  // remove and add today food ..etc
  Future<Response> updateData(String url, dynamic body) async {
    Response response;
    try {
      response = await _dio.put(url, data: json.encode(body));
    } on DioError catch (e) {
      throw Exception(e.message);
    } catch (e) {
      rethrow;
    } finally {}
    return response;
  }

  //insert with body
  Future<Response> insertWithBody(String url, body) async {
    // TODO: implement getRequest

    Response response;
    try {
      response = await _dio.post(url, data: body);
    } on DioError catch (e) {
      throw Exception(e.message);
    } catch (e) {
      rethrow;
    } finally {}

    return response;
  }

  Future<Response> insertFood({
    required File? file,
    required fdName,
    required fdCategory,
    required fdPrice,
    required fdThreeBiTwoPrsPrice,
    required fdHalfPrice,
    required fdQtrPrice,
    required fdIsLoos,
  }) async {
    FormData formData;
    print('naseef');
    print(file);

    if (file != null) {
      print('file has');
      String fileName = file.path.split('/').last;
      formData = FormData.fromMap({
        "myFile": await MultipartFile.fromFile(file.path, filename: fileName),
        "fdName": fdName,
        "fdCategory": fdCategory,
        "fdFullPrice": fdPrice,
        "fdThreeBiTwoPrsPrice": fdThreeBiTwoPrsPrice,
        "fdHalfPrice": fdHalfPrice,
        "fdQtrPrice": fdQtrPrice,
        "fdIsLoos": fdIsLoos,
        "cookTime": 0,
        "fdShopId": 10,
      });
    } else {
      print('file not');
      formData = FormData.fromMap({
        "myFile": null,
        "fdName": fdName,
        "fdCategory": fdCategory,
        "fdFullPrice": fdPrice,
        "fdThreeBiTwoPrsPrice": fdThreeBiTwoPrsPrice,
        "fdHalfPrice": fdHalfPrice,
        "fdQtrPrice": fdQtrPrice,
        "fdIsLoos": fdIsLoos,
        "cookTime": 0,
        "fdShopId": 10,
      });
    }

    Response response;
    try {
      response = await _dio.post('food/insertFood', data: formData);
    } on DioError catch (e) {
      // AppSnackBar.errorSnackBar('Error', MyDioError.dioError(e));
      throw Exception(e.message);
    } catch (e) {
      rethrow;
    } finally {

    }

    return response;
  }

  Future<Response> updateFood(
      {required File? file,
      required fdName,
      required fdCategory,
      required fdPrice,
      required fdThreeBiTwoPrsPrice,
      required fdHalfPrice,
      required fdQtrPrice,
      required fdIsLoos,
      required cookTime,
      required fdShopId,
      required fdImg,
      required fdIsToday,
      required fdId}) async {
    FormData formData;
    print('naseef');
    print(file);

    if (file != null) {
      print('file has');
      String fileName = file.path.split('/').last;
      formData = FormData.fromMap({
        "myFile": await MultipartFile.fromFile(file.path, filename: fileName),
        "fdName": fdName,
        "fdCategory": fdCategory,
        "fdFullPrice": fdPrice,
        "fdThreeBiTwoPrsPrice": fdThreeBiTwoPrsPrice,
        "fdHalfPrice": fdHalfPrice,
        "fdQtrPrice": fdQtrPrice,
        "fdIsLoos": fdIsLoos,
        "cookTime": 0,
        "fdShopId": 10,
        "fdImg": fdImg,
        "fdIsToday": fdIsToday,
        "fdId": fdId,
      });
    } else {
      print('file not');
      formData = FormData.fromMap({
        "myFile": null,
        "fdName": fdName,
        "fdCategory": fdCategory,
        "fdFullPrice": fdPrice,
        "fdThreeBiTwoPrsPrice": fdThreeBiTwoPrsPrice,
        "fdHalfPrice": fdHalfPrice,
        "fdQtrPrice": fdQtrPrice,
        "fdIsLoos": fdIsLoos,
        "cookTime": 0,
        "fdShopId": 10,
        "fdIsToday": fdIsToday,
        "fdId": fdId,
      });
    }

    Response response;
    try {
      response = await _dio.put('food/updateFood', data: formData);
    } on DioError catch (e) {
      // AppSnackBar.errorSnackBar('Error', MyDioError.dioError(e));
      throw Exception(e.message);
    }

    return response;
  }

//insert online app
  Future<Response> insertOnlineApp({
    required File? file,
    required fdShopId,
    required appName,

  }) async {
    FormData formData;
    print(file);

    if (file != null) {
      print('file has');
      String fileName = file.path.split('/').last;
      formData = FormData.fromMap({
        "myFile": await MultipartFile.fromFile(file.path, filename: fileName),
        "fdShopId": fdShopId,
        "appName": appName
      });
    } else {
      print('file not');
      formData = FormData.fromMap({
        "myFile": null,
        "fdShopId": fdShopId,
        "appName": appName
      });
    }

    Response response;
    try {
      response = await _dio.post('online_apps/addOnlineApp', data: formData);
    } on DioError catch (e) {
      // AppSnackBar.errorSnackBar('Error', MyDioError.dioError(e));
      throw Exception(e.message);
    } catch (e) {
      rethrow;
    } finally {

    }

    return response;
  }

  initializeInterceptors() {
    _dio.interceptors.add(InterceptorsWrapper(onRequest: (request, handler) {
      // Do something before request is sent
      print("${request.method} | ${request.path}");
      return handler.next(request); //continue
    }, onResponse: (response, handler) {
      // Do something with response data
      print("response naseef ${response.statusCode} ${response.statusMessage} ${response.data}");
      return handler.next(response); // continue
    }, onError: (DioError e, handler) {
      // Do something with response error
      print('error naseef' + e.message);
      AppSnackBar.errorSnackBar('Error', MyDioError.dioError(e));
      return handler.next(e);
    }));
  }
}
