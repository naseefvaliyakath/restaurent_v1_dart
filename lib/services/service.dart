import 'package:dio/dio.dart';
import 'package:restowrent_v_two/app_constans/api_link.dart';
class HttpService{
  Dio _dio = Dio();

  HttpService(){
    _dio = Dio(BaseOptions(
        baseUrl: BASE_URL,
        headers: {"Authorization" : "Bearer $API_KEY"}
    ));

    initializeInterceptors();
  }


  Future<Response> getRequest(String url) async{
    // TODO: implement getRequest

    Response response;
    try {
      response = await _dio.get(url);
    } on DioError catch (e) {
      print(e.message);
      throw Exception(e.message);
    }

    return response;
  }



  initializeInterceptors(){
    _dio.interceptors.add(InterceptorsWrapper(
        onRequest:(request, handler){
          // Do something before request is sent
          print("${request.method} | ${request.path}");
          return handler.next(request); //continue

        },
        onResponse:(response,handler) {
          // Do something with response data
          print("${response.statusCode} ${response.statusMessage} ${response.data}");
          return handler.next(response); // continue

        },
        onError: (DioError e, handler) {
          // Do something with response error
          print(e.message);
          return  handler.next(e);
        }
    ));
  }
}
