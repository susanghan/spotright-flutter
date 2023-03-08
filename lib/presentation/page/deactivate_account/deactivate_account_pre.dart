import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotright/presentation/common/colors.dart';
import 'package:spotright/presentation/component/appbars/default_app_bar.dart';
import 'package:get/get.dart';
import 'package:spotright/presentation/page/deactivate_account/deactivate_account.dart';
import '../../component/buttons/sr_cta_button.dart';

class DeactivateAccountPre extends StatelessWidget {
  const DeactivateAccountPre({Key? key}) : super(key: key);

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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ..._AssistBox(0),
            ..._CenterFactor("정말 탈퇴하실 건가요? \n 이대로 간다니 아쉬워요"),
            SrCTAButton(
              text: "계정 삭제",
              isEnabled: true,
              action: () {
                Get.to(DeactivateAccount());
              },
            ),
          ],
        ),
      ),
    ));
  }

  //ui를 위한 보조적인 박스.
  //_CenterFactor의 위아래에 있으면 mainAxisAlignment: MainAxisAlignment.spaceBetween가 적용되어 _CenterFactor가 자연스럽게 중앙의 상단 쪽에 위치한다.
  List<Widget> _AssistBox(double boxHeight) {
    return [
      SizedBox(
        width: double.infinity,
        height: boxHeight,
      ),
    ];
  }

  List<Widget> _CenterFactor(String labelText) {
    return [
      Column(
        children: [
          Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: Image(image: AssetImage("assets/sad.jpg"), width: 120, height: 120,)),
          Text(
            labelText,
            style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: SrColors.black),
          ),
        ],
      ),
    ];
  }

}
