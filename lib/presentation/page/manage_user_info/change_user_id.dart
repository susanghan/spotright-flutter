import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotright/presentation/common/typography.dart';
import 'package:spotright/presentation/page/manage_user_info/id_controller.dart';

import '../../common/colors.dart';
import '../../component/appbars/default_app_bar.dart';
import '../../component/buttons/sr_cta_button.dart';
import '../../component/sr_text_field/sr_text_field.dart';

class ChangeUserId extends StatefulWidget {
  const ChangeUserId({Key? key}) : super(key: key);

  @override
  State<ChangeUserId> createState() => _ChangeUserIdState();
}

class _ChangeUserIdState extends State<ChangeUserId> {
  IdController idController = Get.put(IdController());


  @override
  void initState() {
    super.initState();
    idController.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: DefaultAppBar(
          title: "아이디 변경",
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
                    Obx(() => _CenterFactor("새로운 아이디를 입력해 주세요",
                        idController.idValidationMessage.value)),
                    ..._AssistBox(190)
                  ],
                ),
              ),
              Obx(() => SrCTAButton(
                    text: "완료",
                    isEnabled: idController.ctaActive.value,
                    action: idController.onFinished,
                  )),
            ],
          ),
        ),
      ),
    );
  }

  //ui를 위한 보조적인 박스.
  List<Widget> _AssistBox(double boxHeight) {
    return [
      SizedBox(
        width: double.infinity,
        height: boxHeight,
      ),
    ];
  }

  Widget _CenterFactor(String labelText, String captionText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(
            labelText,
            style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: SrColors.black),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: SrTextField(
            height: 45,
            onChanged: idController.onChangeText,
            controller: idController.textController,
            suffixIcon: Padding(
              padding: const EdgeInsets.fromLTRB(0, 4, 6, 4),
              child: OutlinedButton(
                onPressed: idController.verifyId,
                style: OutlinedButton.styleFrom(
                    backgroundColor: idController.ctaActive.value ? SrColors.gray1 : SrColors.primary,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100))),
                child: Text(
                  "중복확인",
                  style: SrTypography.body3medium.copy(color: SrColors.white),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 14),
          child: Text(
            captionText,
            style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w300,
                color: SrColors.gray1),
          ),
        ),
      ],
    );
  }
}
