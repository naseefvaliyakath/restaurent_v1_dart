import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateRangePickerDemo extends StatefulWidget {
  const DateRangePickerDemo({Key? key}) : super(key: key);

  @override
  State<DateRangePickerDemo> createState() => _DateRangePickerDemoState();
}

class _DateRangePickerDemoState extends State<DateRangePickerDemo> {
  DateTimeRange dateTimeRange = DateTimeRange(
      start: DateTime(2022, 11, 5),
      end: DateTime(2022, 12, 24)
  );

  @override
  Widget build(BuildContext context) {
    final start = dateTimeRange.start;
    final end = dateTimeRange.end;
    final defference = dateTimeRange.duration;

    return Scaffold(
      body: Center(
        child: Container(
          height: 20,
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  child: Text('${DateFormat('yyyy/MM/dd').format(start)}'),
                  onPressed: () {pickDateTimeRange();},
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  child: Text('${end.year}/${end.month}/${end.day}'),
                  onPressed: () {pickDateTimeRange();},
                ),
              ),
              Expanded(child: Text('difference  ${defference.inDays}'))
            ],
          ),
        ),
      ),
    );
  }

  Future pickDateTimeRange() async {

    DateTimeRange? newDateRange = await  showDateRangePicker(
      context: context,
      initialDateRange: dateTimeRange,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),

    );

    if(newDateRange == null) return;
    setState(() {
      dateTimeRange = newDateRange;
    });

  }
}


