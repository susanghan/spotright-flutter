import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotright/presentation/component/appbars/default_app_bar.dart';
import 'package:spotright/presentation/component/sr_text_field/sr_text_field.dart';
import 'package:spotright/presentation/page/deactivate_account/deactivate_controller.dart';

import '../../common/colors.dart';
import '../../component/buttons/sr_cta_button.dart';

class DeactivateAccount extends StatefulWidget {
  const DeactivateAccount({Key? key}) : super(key: key);

  @override
  State<DeactivateAccount> createState() => _DeactivateAccountState();
}

class _DeactivateAccountState extends State<DeactivateAccount> {
  DeactivateController deactivateController = Get.put(DeactivateController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: DefaultAppBar(
        title: "계정 삭제",
        hasBackButton: true,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(16, 0, 16, 36),
        child: Column(
          children: [
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _CenterFactor("계정을 삭제하시려면 아이디를 입력해주세요"),
                _AssistBox(170),
              ],
            )),
            Obx(() => SrCTAButton(
              text: "계정 삭제",
              isEnabled: deactivateController.ctaActive.value,
              action: deactivateController.deactivate,
            )),
          ],
        ),
      ),
    ));
  }

  Widget _AssistBox(double boxHeight) {
    return
      SizedBox(
        width: double.infinity,
        height: boxHeight,
      );
  }

  Widget _CenterFactor(String labelText) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 8),
          child: Text(
            labelText,
            style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: SrColors.black),
          ),
        ),
        SrTextField(
          onChanged: deactivateController.onChanged,
        ),
      ],
    );
  }
}
