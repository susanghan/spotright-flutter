import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:spotright/presentation/common/typography.dart';
import 'package:spotright/presentation/component/dialog/birthday_dialog.dart';
import 'package:spotright/presentation/page/manage_user_info/birthday_controller.dart';

import '../../common/colors.dart';
import '../../component/appbars/default_app_bar.dart';
import '../../component/buttons/sr_cta_button.dart';


class ChangeUserBirth extends StatefulWidget {
  const ChangeUserBirth({Key? key}) : super(key: key);

  @override
  State<ChangeUserBirth> createState() => _ChangeUserBirthState();
}

class _ChangeUserBirthState extends State<ChangeUserBirth> {
  BirthdayController birthdayController = Get.put(BirthdayController());

  @override
  void initState() {
    super.initState();
    birthdayController.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: DefaultAppBar(
            title: "생년월일 변경",
            hasBackButton: true,
          ),
          body: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 36),
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ..._CenterFactor("생년월일을 입력해 주세요"),
                      _AssistBox(170),
                    ],
                  ),
                ),
                Obx(() => SrCTAButton(
                  text: "완료",
                  isEnabled: birthdayController.ctaActive.value,
                  action: birthdayController.changeBirthdate,
                )),
              ],
            ),
          ),
        ));
  }

  Widget _AssistBox(double boxHeight) {
    return SizedBox(
      width: double.infinity,
      height: boxHeight,
    );
  }

  List<Widget> _CenterFactor(String labelText) {
    return [
      Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(
          labelText,
          style: SrTypography.body2medium,
        ),
      ),
      GestureDetector(
        onTap: () {
          Get.dialog(BirthdayDialog(defaultDate: birthdayController.birthdate.value, onChanged: birthdayController.onBirthdateChanged,));
        },
        child: Container(
          padding: EdgeInsets.only(left: 16),
          alignment: Alignment.centerLeft,
          width: double.infinity,
          height: 45,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
              border: Border.all(color: SrColors.gray1, width: 1),
          ),
          child: Obx(() => Text(birthdayController.birthdate.value, style: SrTypography.body2medium.copy(color: SrColors.black)),)
        ),
      )
    ];
  }
}
