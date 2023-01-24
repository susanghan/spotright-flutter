import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotright/presentation/common/colors.dart';
import 'package:spotright/presentation/component/spinner/sr_spinner.dart';

class BirthdayDialog extends StatelessWidget {
  const BirthdayDialog({Key? key}) : super(key: key);

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
                SrSpinner(list: ["1998", "1999", "2000"]),
                SrSpinner(list: ["01", "02", "03"]),
                SrSpinner(list: ["01", "02", "03"]),
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
}
