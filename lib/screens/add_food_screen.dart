import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:restowrent_v_two/widget/arrow_back.dart';
import 'package:restowrent_v_two/widget/big_text.dart';
import 'package:restowrent_v_two/widget/add_food_screen/chose_image.dart';
import 'package:restowrent_v_two/widget/round_border_button.dart';
import '../app_constans/app_colors.dart';
import '../widget/add_food_screen/catogories.dart';
import 'dart:io';

import '../widget/add_food_screen/show_picked_img_card.dart';
import '../widget/text_field_widget.dart';
import '../widget/two_button-bottom_sheet.dart';

class AddFoodScreen extends StatefulWidget {
  const AddFoodScreen({Key? key}) : super(key: key);

  @override
  State<AddFoodScreen> createState() => _AddFoodScreenState();
}

class _AddFoodScreenState extends State<AddFoodScreen> {
  bool _switchValue = false;
  File? imageFile;
  int tappedIndex = 0;
  CrossFadeState state = CrossFadeState.showFirst;
  List categoryCard = [
    {'text': "All food", 'images': "assets/image/food_img1.jpg"},
    {'text': "Biriyani", 'images': "assets/image/food_img2.jpg"},
    {'text': "Brakefast", 'images': "assets/image/food_img3.jpg"},
    {'text': "Cool drink", 'images': "assets/image/food_img1.jpg"}
  ];

  @override
  Widget build(BuildContext context) {
    Widget horizontalList1 = Container(
      margin: const EdgeInsets.symmetric(vertical: 20.0),
      height: 200.0,
    );
    return Scaffold(
      body: SafeArea(
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Container(
              height: 1.sh,
              width: double.maxFinite,
              padding: EdgeInsets.symmetric( horizontal: 10.w),
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
                            Icon(Icons.arrow_back),
                            15.horizontalSpace,
                            Flexible(
                              child: FittedBox(
                                child: RichText(
                                  softWrap: false,
                                  text: TextSpan(children: [
                                    TextSpan(
                                        text: "Make Your Own Food",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 28.sp,
                                            overflow: TextOverflow.fade,
                                            color: AppColors.textColor)),
                                  ]),
                                  maxLines: 1,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      //heading

                      //notification icon
                      Container(
                        height: 40.h,
                        width: 40.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.r),
                            border: Border.all(color: Colors.grey)),
                        child: Center(
                          child: Badge(
                            badgeColor: Colors.red,
                            child: const Icon(FontAwesomeIcons.bell),
                          ),
                        ),
                      ),
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
                      itemCount: categoryCard.length,
                      itemBuilder: (BuildContext ctx, index) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              tappedIndex = index;
                            });
                          },
                          //category tile
                          child: Catogeries(
                              color: tappedIndex == index
                                  ? AppColors.mainColor_2
                                  : Colors.white,
                              text: categoryCard[index]['text'],
                              images: categoryCard[index]['images']),
                        );
                      },
                    ),
                  ),
                  20.verticalSpace,
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
                                b2Function: _getFromcammara);
                          },
                          child: const ChooseImage()),
                  20.verticalSpace,
                  // name textfield
                  BigText(
                    text: 'Food Name ',
                    size: 14.sp,
                  ),
                  5.verticalSpace,
                  TextFieldWidget(
                    hintText: 'Enter Your Food Name ....',
                    textEditingController: TextEditingController(),
                    borderRadius: 15.r,
                  ),

                  20.verticalSpace,
                  // price textfield
                  Row(
                    children: [
                      BigText(
                        text: 'Food Price ',
                        size: 14.sp,
                      ),
                      FlutterSwitch(
                        inactiveText: 'Full',
                        activeText: 'Loos',
                        inactiveColor: AppColors.mainColor_2,
                        height: 28.0,
                        width: 70,
                        valueFontSize: 12.0,
                        toggleSize: 20.0,
                        value: _switchValue,
                        borderRadius: 50.0,
                        padding: 5,
                        showOnOff: true,
                        onToggle: (val) {
                          setState(() {
                            _switchValue = val;
                            state = state == CrossFadeState.showFirst
                                ? CrossFadeState.showSecond
                                : CrossFadeState.showFirst;
                          });
                        },
                      ),
                    ],
                  ),
                  5.verticalSpace,
                  AnimatedCrossFade(
                    firstChild: TextFieldWidget(
                      hintText: 'Enter Your Food Price ....',
                      textEditingController: TextEditingController(),
                      borderRadius: 15.r,
                    ),
                    secondChild: Row(
                      children: [
                        Expanded(
                          child: TextFieldWidget(
                            hintText: 'Full',
                            textEditingController: TextEditingController(),
                            borderRadius: 15.r,
                          ),
                        ),
                        Expanded(
                          child: TextFieldWidget(
                            hintText: '3/4',
                            textEditingController: TextEditingController(),
                            borderRadius: 15.r,
                          ),
                        ),
                        Expanded(
                          child: TextFieldWidget(
                            hintText: 'Half',
                            textEditingController: TextEditingController(),
                            borderRadius: 15.r,
                          ),
                        ),
                        Expanded(
                          child: TextFieldWidget(
                            hintText: 'Qartar',
                            textEditingController: TextEditingController(),
                            borderRadius: 15.r,
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
                    onTap: () {},
                  ))
                ],
              ),
            )
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _getFromGallary() async {
    XFile? pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery, maxWidth: 1080, maxHeight: 1080);
     _cropImage(pickedFile!.path);
    Navigator.pop(context);
  }

  void _getFromcammara() async {
    XFile? pickedFile = await ImagePicker()
        .pickImage(source: ImageSource.camera, maxWidth: 1080, maxHeight: 1080);
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
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        ),
      ],
    );
    
    if(croppedFile != null){
      setState(() {
        imageFile = File(croppedFile.path);
      });
    }
    
  }
}
