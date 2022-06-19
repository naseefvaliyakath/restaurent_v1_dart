import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TableShapeDropDown extends StatefulWidget {
  const TableShapeDropDown({Key? key}) : super(key: key);

  @override
  _TableShapeDropDownState createState() => _TableShapeDropDownState();
}

class _TableShapeDropDownState extends State<TableShapeDropDown> {
  String? _selected;

  List<Map> _myJson = [
    {"id": '1', "image": "assets/image/squre.png", "name": "Squre"},
    {"id": '2', "image": "assets/image/circle.png", "name": "Rectangle"},
    {"id": '3', "image": "assets/image/circle.png", "name": "Round"},
    {"id": '4', "image": "assets/image/squre.png", "name": "Ovel shape"},
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 8.h),
          height: 0.05.sh,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isDense: true,
                  hint: Text(
                    "Table Shape",
                    style: TextStyle(
                      fontSize: 15.sp,
                      color: Colors.grey,
                    ),
                  ),
                  value: _selected,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selected = newValue!;
                    });

                    print(_selected);
                  },
                  items: _myJson.map((Map map) {
                    return DropdownMenuItem<String>(
                      value: map["id"].toString(),
                      // value: _mySelection,
                      child: Container(
                        width: 0.3 * 1.sw,
                        child: Row(
                          children: <Widget>[
                            ClipRRect(
                              child: Image.asset(
                                map["image"],
                                width: 25.sp,
                                height: 25.sp,
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            3.horizontalSpace,
                            Flexible(
                              child: Container(
                                child: Text(
                                  map["name"],
                                  style: TextStyle(fontSize: 12.sp),
                                  softWrap: false,
                                  overflow: TextOverflow.fade,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
