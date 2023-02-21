import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../common/colors.dart';
import '../../component/appbars/default_app_bar.dart';
import '../../component/buttons/sr_cta_button.dart';
import '../../component/sr_text_field/sr_text_field.dart';

//Todo : 변경사항이 있어야 활성화

class ChangeUserBirth extends StatefulWidget {
  const ChangeUserBirth({Key? key}) : super(key: key);

  @override
  State<ChangeUserBirth> createState() => _ChangeUserBirthState();
}

class _ChangeUserBirthState extends State<ChangeUserBirth> {
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
                  ..._AssistBox(170),
                ],
              ),
            ),
            SrCTAButton(
              text: "완료",
              isEnabled: false,
              action: () {},
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
          SrTextField(),
        ],
      ),
    ];
  }
}
