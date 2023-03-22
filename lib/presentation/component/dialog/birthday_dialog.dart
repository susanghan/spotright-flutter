import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotright/presentation/common/colors.dart';
import 'package:spotright/presentation/component/spinner/sr_spinner.dart';
import 'package:spotright/presentation/component/sr_check_box/sr_check_box.dart';

import '../../common/typography.dart';

class BirthdayDialog extends StatefulWidget {
  BirthdayDialog({Key? key, required this.onChanged, this.defaultDate}) : super(key: key);

  final Function(String? date) onChanged;
  final String? defaultDate;

  @override
  State<BirthdayDialog> createState() => _BirthdayDialogState();
}

class _BirthdayDialogState extends State<BirthdayDialog> {
  String year = "2000";
  String month = "06";
  String day = "15";
  bool isNone = false;

  @override
  void initState() {
    if(widget.defaultDate == null) {
      isNone = true;
    } else {
      List<String> splitDate = widget.defaultDate!.split("-");
      year = splitDate[0];
      month = splitDate[1];
      day = splitDate[2];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        width: double.infinity,
        height: 260,
        padding: EdgeInsets.only(top: 24),
        child: Column(children: [
          Padding(padding: EdgeInsets.only(bottom: 24), child: Text("생년월일을 입력하세요", style: SrTypography.body2semi.copy(color: SrColors.black))),
          Container(
            margin: EdgeInsets.only(bottom: 16),
            width: 202,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SrSpinner(list: range(1950, 2023), onChanged: (value) {
                  year = value;
                  _onChanged();
                }, defaultValue: year,),
                SrSpinner(list: range(1, 13), onChanged: (value) {
                  month = value;
                  _onChanged();
                }, defaultValue: month),
                SrSpinner(list: range(1, 32), onChanged: (value) {
                  day = value;
                  _onChanged();
                }, defaultValue: day),
              ],
            ),
          ),
          SizedBox(
            width: 202,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 8),
                  child: SrCheckBox(isRectangle: true, size: 20, value: isNone, onChanged: (checked) {
                    setState(() {
                      isNone = checked;
                    });
                    _onChanged();
                  }),
                ),
                Text('선택안함', style: SrTypography.body3medium.copy(color: SrColors.gray1),),
              ],
            ),
          ),
          Spacer(),
          Container(
              height: 64,
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
                      style: SrTypography.body2semi.copy(color: SrColors.white),
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

  void _onChanged() {
    if(isNone) {
      widget.onChanged(null);
    } else {
      widget.onChanged("$year-$month-$day");
    }
  }
}
