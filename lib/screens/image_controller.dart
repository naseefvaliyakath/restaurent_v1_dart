import 'package:dio/dio.dart';
import 'package:get/get.dart' hide MultipartFile,FormData,Response;
import 'package:image_picker/image_picker.dart';
class ImageController extends GetxController{
  PickedFile? _pickedFile;
  PickedFile? get pickedFile=>_pickedFile;
  bool _isLoading =false;

  final _picker = ImagePicker();
  // Implementing the image picker
  Future<void> pickImage() async {
    _pickedFile=
    await _picker.getImage(source: ImageSource.gallery);
    update();

  }

  Future<bool> upload() async {
    update();
    bool success = false;

    Response response = (await updateProfile(_pickedFile!));
    _isLoading = false;
    if (response.statusCode == 200) {
      // Map map = jsonDecode(await response.data);
      // String message = map["message"];
      success =true;
      // _pickedFile = null;
      //await getUserInfo();
      print('hhhh'+response.data);
    } else {
      print("error posting the image");
    }
    update();
    return success;

  }


  // Future<http.StreamedResponse> updateProfile(PickedFile? data) async {
  //   http.MultipartRequest request = http.MultipartRequest('POST', Uri.parse('https://mobizate.com/node/upload'));
  //   // request.headers.addAll(<String,String>{'Authorization': 'Bearer $token'});
  //   if(GetPlatform.isMobile && data != null) {
  //     File _file = File(data.path);
  //     request.files.add(http.MultipartFile('image', _file.readAsBytes().asStream(), _file.lengthSync(), filename: _file.path.split('/').last));
  //   }
  //   Map<String, String> _fields = Map();
  //   _fields.addAll(<String, String>{
  //     'f_name': 'naseef',  'email': 'maill'
  //   });
  //   request.fields.addAll(_fields);
  //   http.StreamedResponse response = await request.send();
  //   return response;
  // }

  Future<Response> updateProfile(PickedFile file) async {
    String fileName = file.path.split('/').last;
    FormData formData = FormData.fromMap({
      "image":
      await MultipartFile.fromFile(file.path, filename:fileName),
      "text":"{'naseef':'hhh','int':1}",

    });
    Dio dio = Dio();
    Response  response = await dio.post("https://mobizate.com/node/uploads", data: formData);
    return response;
  }

}