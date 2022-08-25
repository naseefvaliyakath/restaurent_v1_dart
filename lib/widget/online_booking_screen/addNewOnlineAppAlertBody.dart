import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:restowrent_v_two/screens/select_online_app_screen/controller/select_online_app_controller.dart';
import 'dart:io';

import '../../app_constans/app_colors.dart';
import '../add_food_screen/chose_image.dart';
import '../add_food_screen/show_picked_img_card.dart';
import '../app_min_button.dart';
import '../app_round_mini_btn.dart';
import '../big_text.dart';
import '../progress_button.dart';
import '../text_field_widget.dart';
import '../two_button-bottom_sheet.dart';

class AddNewOnlineAppAlertBody extends StatefulWidget {
  const AddNewOnlineAppAlertBody({Key? key}) : super(key: key);

  @override
  State<AddNewOnlineAppAlertBody> createState() => _AddNewOnlineAppAlertBodyState();
}

class _AddNewOnlineAppAlertBodyState extends State<AddNewOnlineAppAlertBody> {
  File? imageFile;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SelectOnlineAppController>(builder: (ctrl) {
      return SizedBox(
        width: 1.sw * 0.6,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // upload image
            imageFile != null
                ? ShowPickedImgCard(
                    file: imageFile,
                    cancellEvent: () {
                      setState(() {
                        imageFile = null;
                      });
                    },
                    choseFileEvent: () {
                      TwoBtnBottomSheet.bottomSheet(
                        b1Name: 'From Gallery',
                        b2Name: 'From Camara',
                        b1Function: _getFromGallary,
                        b2Function: _getFromcammara,
                      );
                    },
                  )
                : InkWell(
                    onTap: () {
                      TwoBtnBottomSheet.bottomSheet(
                        b1Name: 'From Gallery',
                        b2Name: 'From Camara',
                        b1Function: _getFromGallary,
                        b2Function: _getFromcammara,
                      );
                    },
                    child: const ChooseImage(),
                  ),
            // name textfield

            15.verticalSpace,
            TextFieldWidget(
              hintText: 'Enter App Name ....',
              textEditingController: ctrl.onlineAppNameTD,
              borderRadius: 15.r,
              onChange: (_) {},
            ),
            10.verticalSpace,
            SizedBox(
              height: 45.h,
              child: IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Flexible(
                      fit: FlexFit.tight,
                      child: ProgressButton(
                        btnCtrlName: 'submitOnlineApp',
                        text: 'Submit',
                        ctrl: ctrl,
                        color: Colors.green,
                        onTap: () async {
                          FocusManager.instance.primaryFocus?.unfocus();
                          ctrl.file = imageFile;
                          await ctrl.validateAppDetails(context);
                          ctrl.getOnlineApp();
                        },
                      ),
                    ),
                    10.horizontalSpace,
                    Flexible(
                      fit: FlexFit.tight,
                      child: AppMIniButton(
                          text: 'Close',
                          bgColor: Colors.redAccent,
                          onTap: () {
                            Navigator.pop(context);
                          }),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  void _getFromGallary() async {
    XFile? pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery, maxWidth: 1080, maxHeight: 1080);
    _cropImage(pickedFile!.path);
    Navigator.pop(context);
  }

  void _getFromcammara() async {
    XFile? pickedFile = await ImagePicker().pickImage(source: ImageSource.camera, maxWidth: 1080, maxHeight: 1080);
    _cropImage(pickedFile!.path);
    Navigator.pop(context);
  }

  _cropImage(filepath) async {
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
            toolbarColor: Colors.white,
            toolbarWidgetColor: Colors.black54,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        ),
      ],
    );

    if (croppedFile != null) {
      setState(() {
        imageFile = File(croppedFile.path);
      });
    }
  }
}
