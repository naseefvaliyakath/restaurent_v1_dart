import 'dart:io';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:restowrent_v_two/screens/update_food_screen/controller/update_food_controller.dart';
import 'package:restowrent_v_two/widget/add_food_screen/chose_image.dart';
import 'package:restowrent_v_two/widget/big_text.dart';
import 'package:restowrent_v_two/widget/round_border_button.dart';

import '../../app_constans/app_colors.dart';
import '../../routes/route_helper.dart';
import '../../widget/add_food_screen/catogories.dart';
import '../../widget/add_food_screen/show_picked_img_card.dart';
import '../../widget/heading_rich_text.dart';
import '../../widget/loading_page.dart';
import '../../widget/my_toggle_switch.dart';
import '../../widget/notification_icon.dart';
import '../../widget/text_field_widget.dart';
import '../../widget/two_button-bottom_sheet.dart';
import '../../widget/update_food_screen/network_img_show_card.dart';
import '../all_food_screen/controller/all_food_controller.dart';

class UpdateFoodScreen extends StatefulWidget {
  const UpdateFoodScreen({Key? key}) : super(key: key);

  @override
  State<UpdateFoodScreen> createState() => _UpdateFoodScreenState();
}

class _UpdateFoodScreenState extends State<UpdateFoodScreen> {
  File? imageFile;
  int tappedIndex = 0;
  CrossFadeState state = CrossFadeState.showFirst;
  CrossFadeState statePic = CrossFadeState.showFirst;

  //update screen first time
  update({fdName, fdFullPrice, fdThreeBiTwoPrsPrice, fdHalfPrice, fdQtrPrice, fdIsLoos}) async {
    await Get.find<UpdateFoodController>()
        .updateInitialValue(fdName, fdFullPrice, fdThreeBiTwoPrsPrice, fdHalfPrice, fdQtrPrice, fdIsLoos);
  }

  @override
  Widget build(BuildContext context) {
    int id = Get.arguments['id'] ?? 0;
    String fdName = Get.arguments['fdName'] ?? '';
    String fdCategory = Get.arguments['fdCategory'] ?? '';
    double fdFullPrice = Get.arguments['fdFullPrice'] ?? 0;
    double fdThreeBiTwoPrsPrice = Get.arguments['fdThreeBiTwoPrsPrice'] ?? 0;
    double fdHalfPrice = Get.arguments['fdHalfPrice'] ?? 0;
    double fdQtrPrice = Get.arguments['fdQtrPrice'] ?? 0;
    String fdIsLoos = Get.arguments['fdIsLoos'] ?? '';
    int cookTime = Get.arguments['cookTime'] ?? 0;
    int fdShopId = Get.arguments['fdShopId'] ?? 0;
    String fdImg = Get.arguments['fdImg'] == 'no_data' ? 'https://mobizate.com/uploads/sample.jpg' : Get.arguments['fdImg'];
    String fdIsToday = Get.arguments['fdIsToday'] ?? '';

    print('fffddd  ' + fdImg);
    print('gggg' + fdName);

    update(
        fdName: fdName,
        fdFullPrice: fdFullPrice,
        fdThreeBiTwoPrsPrice: fdThreeBiTwoPrsPrice,
        fdHalfPrice: fdHalfPrice,
        fdQtrPrice: fdQtrPrice,
        fdIsLoos: fdIsLoos);

    // setting price toggle initially
    state = Get.find<UpdateFoodController>().priceToggle == false ? CrossFadeState.showFirst : CrossFadeState.showSecond;

    print('$fdFullPrice $fdHalfPrice $fdThreeBiTwoPrsPrice $fdQtrPrice');

    return WillPopScope(
      onWillPop: () async {
        Get.offNamed(RouteHelper.getAllFoodScreen());
        return true;
      },
      child: Scaffold(
        body: GetBuilder<UpdateFoodController>(builder: (ctrl) {
          return ctrl.isLoading
              ? const MyLoading()
              : SafeArea(
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    children: [
                      Container(
                        height: double.maxFinite,
                        width: double.maxFinite,
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //heading and notification icon
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                //back arroow
                                Flexible(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      IconButton(
                                        icon: Icon(
                                          Icons.arrow_back,
                                          size: 24.sp,
                                        ),
                                        onPressed: () {
                                          Get.offNamed(RouteHelper.getAllFoodScreen());
                                        },
                                        splashRadius: 24.sp,
                                      ),
                                      15.horizontalSpace,
                                      const HeadingRichText(name: 'Update Your Food'),
                                    ],
                                  ),
                                ),
                                //heading

                                //notification icon
                                const NotificationIcon(),
                              ],
                            ),
                            15.verticalSpace,
                            //select category
                            BigText(
                              text: 'Select Category :',
                              size: 17.sp,
                            ),
                            10.verticalSpace,
                            //category scrolling
                            SizedBox(
                              height: 60.h,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: ctrl.category!.length,
                                itemBuilder: (BuildContext ctx, index) {
                                  return Catogeries(
                                    onTap: (){
                                      ctrl.setCategoryTappedIndex(index);
                                      fdCategory = ctrl.category![index].catName;
                                      print(fdCategory);
                                    },
                                    color: ctrl.tappedIndex == index ? AppColors.mainColor_2 : Colors.white,
                                    text: ctrl.category![index].catName,
                                  );
                                },
                              ),
                            ),
                            20.verticalSpace,
                            // upload image
                            AnimatedCrossFade(
                              firstChild: NetworkImgShowCard(
                                img: fdImg,
                              ),
                              secondChild: Container(
                                child: imageFile != null
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
                                              b2Function: _getFromcammara);
                                        },
                                        child: const ChooseImage()),
                              ),
                              duration: const Duration(seconds: 1),
                              crossFadeState: statePic,
                              firstCurve: Curves.fastLinearToSlowEaseIn,
                              secondCurve: Curves.linear,
                            ),

                            //edit tmg toggle
                            5.verticalSpace,

                            MyToggleSwich(
                              value: ctrl.imageToggle,
                              onToggle: (val) {
                                  ctrl.setImagetoggle(val);
                                  statePic = ctrl.imageToggle == false ? CrossFadeState.showFirst : CrossFadeState.showSecond;
                              },
                            ),

                            20.verticalSpace,

                            // name textfield
                            BigText(
                              text: 'Food Name ',
                              size: 14.sp,
                            ),
                            5.verticalSpace,
                            TextFieldWidget(
                              hintText: 'Enter Your Food Name ....',
                              textEditingController: ctrl.fdNameTD,
                              borderRadius: 15.r, onChange: (_) {},
                            ),

                            20.verticalSpace,
                            // price textfield
                            Row(
                              children: [
                                BigText(
                                  text: 'Food Price ',
                                  size: 14.sp,
                                ),
                                MyToggleSwich(
                                  onToggle: (val) {
                                    ctrl.setPricetoggle(val);
                                    state = ctrl.priceToggle == false ? CrossFadeState.showFirst : CrossFadeState.showSecond;
                                  },
                                  value: ctrl.priceToggle,
                                ),
                              ],
                            ),
                            5.verticalSpace,
                            AnimatedCrossFade(
                              firstChild: TextFieldWidget(
                                keybordType: TextInputType.number,
                                hintText: 'Enter Your Food Price ....',
                                textEditingController: ctrl.fdPriceTD,
                                borderRadius: 15.r, onChange: (_) {},
                              ),
                              secondChild: Row(
                                children: [
                                  Expanded(
                                    child: TextFieldWidget(
                                      keybordType: TextInputType.number,
                                      hintText: 'Full',
                                      textEditingController: ctrl.fdFullPriceTD,
                                      borderRadius: 15.r, onChange: (_) {},
                                    ),
                                  ),
                                  Expanded(
                                    child: TextFieldWidget(
                                      keybordType: TextInputType.number,
                                      hintText: '3/4',
                                      textEditingController: ctrl.fdThreeBiTwoPrsTD,
                                      borderRadius: 15.r, onChange: (_) {},
                                    ),
                                  ),
                                  Expanded(
                                    child: TextFieldWidget(
                                      keybordType: TextInputType.number,
                                      hintText: 'Half',
                                      textEditingController: ctrl.fdHalfPriceTD,
                                      borderRadius: 15.r, onChange: (_) {},
                                    ),
                                  ),
                                  Expanded(
                                    child: TextFieldWidget(
                                      keybordType: TextInputType.number,
                                      hintText: 'Qartar',
                                      textEditingController: ctrl.fdQtrPriceTD,
                                      borderRadius: 15.r, onChange: (_) {},
                                    ),
                                  ),
                                ],
                              ),
                              duration: const Duration(seconds: 1),
                              crossFadeState: state,
                              firstCurve: Curves.fastLinearToSlowEaseIn,
                              secondCurve: Curves.linear,
                            ),
                            20.verticalSpace,
                            //add food button
                            Center(
                                child: RoundBorderButton(
                              text: 'Add Food',
                              textColor: Colors.white,
                              width: 0.9.sw,
                              borderRadius: 20.r,
                              onTap: () async {

                                ctrl.file = imageFile;
                               await ctrl.validateFoodDetails(
                                    fdName: fdName,
                                    fdCategory: fdCategory,
                                    fdImg: fdImg,
                                    fdIsToday: fdIsToday,
                                    cookTime: cookTime,
                                    fdShopId: fdShopId,
                                    id: id);
                                //Get.delete<AllFoodController>();
                                Get.offNamed(RouteHelper.getAllFoodScreen());
                              },
                            ))
                          ],
                        ),
                      )
                    ],
                  ),
                );
        }), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
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
