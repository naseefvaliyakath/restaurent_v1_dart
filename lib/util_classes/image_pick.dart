import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';


class ImagePick {
  static void getFromGallary(context) async {
    XFile? pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery, maxWidth: 1080, maxHeight: 1080);
    cropImage(pickedFile!.path);
    Navigator.pop(context);
  }

  static void getFromcammara(context) async {
    XFile? pickedFile = await ImagePicker()
        .pickImage(source: ImageSource.camera, maxWidth: 1080, maxHeight: 1080);
    cropImage(pickedFile!.path);
    Navigator.pop(context);
  }

  static cropImage(filepath) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: filepath,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        ),
      ],
    );
  }
}
