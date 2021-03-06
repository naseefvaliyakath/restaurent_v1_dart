import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:getwidget/components/search_bar/gf_search_bar.dart';
import 'package:lottie/lottie.dart';

/*class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Awesome Dialog Example'),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                AnimatedButton(
                  text: 'Info Dialog fixed width and square buttons',
                  pressEvent: () {
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.INFO_REVERSED,
                      borderSide: const BorderSide(
                        color: Colors.green,
                        width: 2,
                      ),
                      width: 280,
                      buttonsBorderRadius: const BorderRadius.all(
                        Radius.circular(2),
                      ),
                      dismissOnTouchOutside: true,
                      dismissOnBackKeyPress: false,
                      onDissmissCallback: (type) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Dismissed by $type'),
                          ),
                        );
                      },
                      headerAnimationLoop: false,
                      animType: AnimType.BOTTOMSLIDE,
                      title: 'INFO',
                      desc: 'This Dialog can be dismissed touching outside',
                      showCloseIcon: true,
                      btnCancelOnPress: () {},
                      btnOkOnPress: () {},
                    ).show();
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                AnimatedButton(
                  text: 'Question Dialog With Custom BTN Style',
                  pressEvent: () {
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.QUESTION,
                      headerAnimationLoop: false,
                      animType: AnimType.BOTTOMSLIDE,
                      title: 'Question',
                      desc: 'Dialog description here...',
                      buttonsTextStyle: const TextStyle(color: Colors.black),
                      showCloseIcon: true,
                      btnCancelOnPress: () {},
                      btnOkOnPress: () {},
                    ).show();
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                AnimatedButton(
                  text: 'Info Dialog Without buttons',
                  pressEvent: () {
                    AwesomeDialog(
                      context: context,
                      headerAnimationLoop: true,
                      animType: AnimType.BOTTOMSLIDE,
                      title: 'INFO',
                      desc:
                      'Lorem ipsum dolor sit amet consectetur adipiscing elit eget ornare tempus, vestibulum sagittis rhoncus felis hendrerit lectus ultricies duis vel, id morbi cum ultrices tellus metus dis ut donec. Ut sagittis viverra venenatis eget euismod faucibus odio ligula phasellus,',
                    ).show();
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                AnimatedButton(
                  text: 'Warning Dialog',
                  color: Colors.orange,
                  pressEvent: () {
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.WARNING,
                      headerAnimationLoop: false,
                      animType: AnimType.TOPSLIDE,
                      showCloseIcon: true,
                      closeIcon: const Icon(Icons.close_fullscreen_outlined),
                      title: 'Warning',
                      desc:
                      'Dialog description here..................................................',
                      btnCancelOnPress: () {},
                      onDissmissCallback: (type) {
                        debugPrint('Dialog Dissmiss from callback $type');
                      },
                      btnOkOnPress: () {},
                    ).show();
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                AnimatedButton(
                  text: 'Error Dialog',
                  color: Colors.red,
                  pressEvent: () {
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.ERROR,
                      animType: AnimType.RIGHSLIDE,
                      headerAnimationLoop: true,
                      title: 'Error',
                      desc:
                      'Dialog description here..................................................',
                      btnOkOnPress: () {},
                      btnOkIcon: Icons.cancel,
                      btnOkColor: Colors.red,
                    ).show();
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                AnimatedButton(
                  text: 'Succes Dialog',
                  color: Colors.green,
                  pressEvent: () {
                    AwesomeDialog(
                      context: context,
                      animType: AnimType.LEFTSLIDE,
                      headerAnimationLoop: false,
                      dialogType: DialogType.SUCCES,
                      showCloseIcon: true,
                      title: 'Succes',
                      desc:
                      'Dialog description here..................................................',
                      btnOkOnPress: () {
                        debugPrint('OnClcik');
                      },
                      btnOkIcon: Icons.check_circle,
                      onDissmissCallback: (type) {
                        debugPrint('Dialog Dissmiss from callback $type');
                      },
                    ).show();
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                AnimatedButton(
                  text: 'No Header Dialog',
                  color: Colors.cyan,
                  pressEvent: () {
                    AwesomeDialog(
                      context: context,
                      headerAnimationLoop: false,
                      dialogType: DialogType.NO_HEADER,
                      title: 'No Header',
                      desc:
                      'Dialog description here..................................................',
                      btnOkOnPress: () {
                        debugPrint('OnClcik');
                      },
                      btnOkIcon: Icons.check_circle,
                    ).show();
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                AnimatedButton(
                  text: 'Custom Body Dialog',
                  color: Colors.blueGrey,
                  pressEvent: () {
                    AwesomeDialog(
                      context: context,
                      animType: AnimType.SCALE,
                      dialogType: DialogType.INFO,
                      body: const Center(
                        child: Text(
                          'If the body is specified, then title and description will be ignored, this allows to further customize the dialogue.',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                      title: 'This is Ignored',
                      desc: 'This is also Ignored',
                    ).show();
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                AnimatedButton(
                  text: 'Auto Hide Dialog',
                  color: Colors.purple,
                  pressEvent: () {
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.INFO,
                      animType: AnimType.SCALE,
                      title: 'Auto Hide Dialog',
                      desc: 'AutoHide after 2 seconds',
                      autoHide: const Duration(seconds: 2),
                    ).show();
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                AnimatedButton(
                  text: 'Testing Dialog',
                  color: Colors.orange,
                  pressEvent: () {
                    AwesomeDialog(
                      context: context,
                      keyboardAware: true,
                      dismissOnBackKeyPress: false,
                      dialogType: DialogType.WARNING,
                      animType: AnimType.BOTTOMSLIDE,
                      btnCancelText: "Cancel Order",
                      btnOkText: "Yes, I will pay",
                      title: 'Continue to pay?',
                      // padding: const EdgeInsets.all(5.0),
                      desc:
                      'Please confirm that you will pay 3000 INR within 30 mins. Creating orders without paying will create penalty charges, and your account may be disabled.',
                      btnCancelOnPress: () {},
                      btnOkOnPress: () {},
                    ).show();
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                AnimatedButton(
                  text: 'Body with Input',
                  color: Colors.blueGrey,
                  pressEvent: () {
                    late AwesomeDialog dialog;
                    dialog = AwesomeDialog(
                      context: context,
                      animType: AnimType.SCALE,
                      dialogType: DialogType.INFO,
                      keyboardAware: true,
                      body: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: <Widget>[
                            Text(
                              'Form Data',
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Material(
                              elevation: 0,
                              color: Colors.blueGrey.withAlpha(40),
                              child: TextFormField(
                                autofocus: true,
                                minLines: 1,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  labelText: 'Title',
                                  prefixIcon: Icon(Icons.text_fields),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Material(
                              elevation: 0,
                              color: Colors.blueGrey.withAlpha(40),
                              child: TextFormField(
                                autofocus: true,
                                keyboardType: TextInputType.multiline,
                                minLines: 2,
                                maxLines: null,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  labelText: 'Description',
                                  prefixIcon: Icon(Icons.text_fields),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            AnimatedButton(
                              isFixedHeight: false,
                              text: 'Close',
                              pressEvent: () {
                                dialog.dismiss();
                              },
                            )
                          ],
                        ),
                      ),
                    )..show();
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                AnimatedButton(
                  text: 'Passing Data Back from Dialog',
                  pressEvent: () async {
                    final dismissMode = await AwesomeDialog(
                      context: context,
                      dialogType: DialogType.NO_HEADER,
                      buttonsBorderRadius: const BorderRadius.all(
                        Radius.circular(2),
                      ),
                      animType: AnimType.RIGHSLIDE,
                      title: 'Passing Data Back',
                      titleTextStyle: const TextStyle(
                        fontSize: 32,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w600,
                      ),
                      desc: 'Dialog description here...',
                      showCloseIcon: true,
                      btnCancelOnPress: () {},
                      btnOkOnPress: () {},
                      autoDismiss: false,
                      onDissmissCallback: (type) {
                        Navigator.of(context).pop(type);
                      },
                      barrierColor: Colors.purple[900]?.withOpacity(0.54),
                    ).show();

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Dismissed by $dismissMode'),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}*/

/*
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';




class HomePage extends StatefulWidget {
  final String title;

  const HomePage({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  XFile? _pickedFile;
  CroppedFile? _croppedFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: !kIsWeb ? AppBar(title: Text(widget.title)) : null,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (kIsWeb)
            Padding(
              padding: const EdgeInsets.all(kIsWeb ? 24.0 : 16.0),
              child: Text(
                widget.title,
                style: Theme.of(context)
                    .textTheme
                    .displayMedium!
                    .copyWith(color: Theme.of(context).highlightColor),
              ),
            ),
          Expanded(child: _body()),
        ],
      ),
    );
  }

  Widget _body() {
    if (_croppedFile != null || _pickedFile != null) {
      return _imageCard();
    } else {
      return _uploaderCard();
    }
  }

  Widget _imageCard() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: kIsWeb ? 24.0 : 16.0),
            child: Card(
              elevation: 4.0,
              child: Padding(
                padding: const EdgeInsets.all(kIsWeb ? 24.0 : 16.0),
                child: _image(),
              ),
            ),
          ),
          const SizedBox(height: 24.0),
          _menu(),
        ],
      ),
    );
  }

  Widget _image() {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    if (_croppedFile != null) {
      final path = _croppedFile!.path;
      return ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 0.8 * screenWidth,
          maxHeight: 0.3 * screenHeight,
        ),
        child: kIsWeb ? Image.network(path) : Image.file(File(path)),
      );
    } else if (_pickedFile != null) {
      final path = _pickedFile!.path;
      return ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 0.8 * screenWidth,
          maxHeight: 0.3 * screenHeight,
        ),
        child: kIsWeb ? Image.network(path) : Image.file(File(path)),
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget _menu() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        FloatingActionButton(
          onPressed: () {
            _clear();
          },
          backgroundColor: Colors.redAccent,
          tooltip: 'Delete',
          child: const Icon(Icons.delete),
        ),
        if (_croppedFile == null)
          Padding(
            padding: const EdgeInsets.only(left: 32.0),
            child: FloatingActionButton(
              onPressed: () {
                _cropImage();
              },
              backgroundColor: const Color(0xFFBC764A),
              tooltip: 'Crop',
              child: const Icon(Icons.crop),
            ),
          )
      ],
    );
  }

  Widget _uploaderCard() {
    return Center(
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: SizedBox(
          width: kIsWeb ? 380.0 : 320.0,
          height: 300.0,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: DottedBorder(
                    radius: const Radius.circular(12.0),
                    borderType: BorderType.RRect,
                    dashPattern: const [8, 4],
                    color: Theme.of(context).highlightColor.withOpacity(0.4),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.image,
                            color: Theme.of(context).highlightColor,
                            size: 80.0,
                          ),
                          const SizedBox(height: 24.0),
                          Text(
                            'Upload an image to start',
                            style: kIsWeb
                                ? Theme.of(context)
                                .textTheme
                                .headline5!
                                .copyWith(
                                color: Theme.of(context).highlightColor)
                                : Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(
                                color:
                                Theme.of(context).highlightColor),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24.0),
                child: ElevatedButton(
                  onPressed: () {
                    _uploadImage();
                  },
                  child: const Text('Upload'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _cropImage() async {
    if (_pickedFile != null) {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: _pickedFile!.path,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 100,

      );
      if (croppedFile != null) {
        setState(() {
          _croppedFile = croppedFile;
        });
      }
    }
  }

  Future<void> _uploadImage() async {
    final pickedFile =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _pickedFile = pickedFile;
      });
    }
  }

  void _clear() {
    setState(() {
      _pickedFile = null;
      _croppedFile = null;
    });
  }
}*/

/*class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ImageController());
    return Scaffold(
        appBar: AppBar(
          title: const Text('Image upload'),
        ),
        body: GetBuilder<ImageController>(
          builder: (controller) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(35),
                child: Column(children: [
                  Center(
                    child: GestureDetector(
                      child: const Text('Select An Image'),
                      //onTap:()=> Get.find<ImageController>().pickImage(),
                      onTap: () => controller.pickImage(),
                    ),
                  ),
                  const SizedBox(height: 35),
                  Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: 200,
                    color: Colors.grey[300],
                    child: controller.pickedFile != null
                        ? Image.file(
                      File(controller.pickedFile!
                          .path), width: 100, height: 100, fit: BoxFit.cover,
                    )
                        : const Text('Please select an image'),
                  ),
                  AppMIniButton(onTap: (){controller.upload();}, bgColor: Colors.red, text: 'ggg',),

                ]),
              ),
            );
          },
        ));
  }
}*/

/*class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Container(child:
          Lottie.asset('assets/lottie/loading.json',
            width: 60.sp,
            height: 60.sp,
            fit: BoxFit.fill,),),
        ),
      ),
    );
  }
}*/

/*class ImageShowing extends StatefulWidget {
  const ImageShowing({Key? key}) : super(key: key);

  @override
  State<ImageShowing> createState() => _ImageShowingState();
}

class _ImageShowingState extends State<ImageShowing> {
  @override
  Widget build(BuildContext context) {
    List list = [
      "Flutter",
      "React",
      "Ionic",
      "Xamarin",
    ];
    return Scaffold(
      body: Container(
        width: 200,
        child: Center(
          child: SizedBox(
            height: 75,
            child: GFSearchBar(
              searchBoxInputDecoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Even Densed TextFiled',
                isDense: true,                      // Added this
                contentPadding: EdgeInsets.all(4),  // Added this
              ),
              searchList: list,
              searchQueryBuilder: (query, list) {
                return list.where((element) => element.toString().toLowerCase().contains(query)).toList();
              },
              overlaySearchListItemBuilder: (item) {
                return Container(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    item.toString(),
                    style: const TextStyle(fontSize: 18),
                  ),
                );
              },
              onItemSelected: (item) {
                setState(() {
                  print('$item');
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}*/

import 'package:getwidget/getwidget.dart';
import 'package:ticket_widget/ticket_widget.dart';



class Ticket extends StatefulWidget {



   Ticket({Key? key}) : super(key: key);

  @override
  State<Ticket> createState() => _TicketState();
}

class _TicketState extends State<Ticket> {




  @override
  Widget build(BuildContext context) {
    bool showBlur = false;
    Widget alertWidget;
    return Scaffold(
      backgroundColor: Colors.black54,
      body: TicketWidget(
        width: 250,
        height: 300,
        isCornerRounded: true,
        padding: EdgeInsets.all(20),
        child: Container(
          child: Text('naseef'),
        ),
      ),
    );

  }
}

/*
Get.defaultDialog(
title: '',
content: TicketWidget(
width: 1.sw * 0.7,
height: 1.sh * 0.6,
isCornerRounded: true,
padding: EdgeInsets.all(20),
child: Column(
mainAxisSize: MainAxisSize.min,
children: [
BigText(text: 'KOT', color: Colors.black),
Row(
mainAxisAlignment: MainAxisAlignment.spaceBetween,
children: [
SmallText(
text: 'OID : 20222036',
color: Colors.black54,
size: 10.sp,
),
SmallText(
text: 'DATE : 01-05-2022',
color: Colors.black54,
size: 10.sp,
),
],
),
3.verticalSpace,
HorezondalDivider(color: Colors.black, height: 1.sp),
SizedBox(
width: double.maxFinite,
child: Column(
mainAxisSize: MainAxisSize.min,
crossAxisAlignment: CrossAxisAlignment.start,
children: [
MidText(
text: 'TYPE : TAKE AWAY',
size: 13.sp,
color: Colors.black,
),
MidText(
text: 'TABLE : 0',
size: 13.sp,
color: Colors.black,
),
],
),
),
3.verticalSpace,
HorezondalDivider(color: Colors.black, height: 1.sp),
ListView.builder(
shrinkWrap: true,
itemBuilder: (context, index) {
return KotItemTile(
index: index,
slNumber: index + 1,
itemName: ctrl.billingItems[index]['name'],
qnt: ctrl.billingItems[index]['qnt'],
kitchenNote: ctrl.billingItems[index]['ktNote'],
);
},
itemCount: ctrl.billingItems.length,
),
],
),
),
backgroundColor: Colors.transparent,
cancel: AppMIniButton(
bgColor: Colors.green,
text: 'Print',
onTap: () {},
),
confirm: AppMIniButton(
bgColor: AppColors.mainColor,
text: 'Close',
onTap: () {Get.back();},
),
radius: 30);
*/
