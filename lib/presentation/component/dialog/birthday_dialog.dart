import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotright/presentation/common/colors.dart';
import 'package:spotright/presentation/component/spinner/sr_spinner.dart';

class BirthdayDialog extends StatefulWidget {
  BirthdayDialog({Key? key, required this.onChanged, required this.defaultDate}) : super(key: key);

  final Function(String date) onChanged;
  final String defaultDate;

  @override
  State<BirthdayDialog> createState() => _BirthdayDialogState();
}

class _BirthdayDialogState extends State<BirthdayDialog> {
  String year = "2000";
  String month = "1";
  String day = "1";

  @override
  void initState() {
    List<String> splitDate = widget.defaultDate.split("-");
    year = splitDate[0];
    month = splitDate[1];
    day = splitDate[2];
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        width: double.infinity,
        height: 290,
        padding: EdgeInsets.only(top: 32),
        child: Column(children: [
          Padding(padding: EdgeInsets.only(bottom: 12), child: Text("생년월일을 입력하세요")),
          SizedBox(
            width: 202,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SrSpinner(list: range(1950, 2023), onChanged: (value) {
                  year = value;
                  widget.onChanged("$year-$month-$day");
                }, defaultValue: year,),
                SrSpinner(list: range(1, 13), onChanged: (value) {
                  month = value;
                  widget.onChanged("$year-$month-$day");
                }, defaultValue: month),
                SrSpinner(list: range(1, 32), onChanged: (value) {
                  day = value;
                  widget.onChanged("$year-$month-$day");
                }, defaultValue: day),
              ],
            ),
          ),
          Spacer(),
          Container(
              height: 60,
              decoration: BoxDecoration(
                  color: SrColors.primary,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
              child: SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text(
                      "확인",
                      style: TextStyle(color: SrColors.white),
                    ),
                  )))
        ]),
      ),
    );
  }

  List<String> range(begin, end) {
    List<String> res = [];

    for(int number = begin; number < end; number++) {
      String numberString = number.toString().padLeft(2, "0");
      res.add(numberString);
    }

    return res;
  }
}
