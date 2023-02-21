import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../common/colors.dart';
import '../../component/appbars/default_app_bar.dart';
import '../../component/buttons/sr_cta_button.dart';
import '../../component/sr_text_field/sr_text_field.dart';

//Todo : 중복확인을 통과 - 캡션(사용가능한 아이디입니다), 완료버튼 활성화

class ChangeUserId extends StatefulWidget {
  const ChangeUserId({Key? key}) : super(key: key);

  @override
  State<ChangeUserId> createState() => _ChangeUserIdState();
}

class _ChangeUserIdState extends State<ChangeUserId> {
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
                    ..._CenterFactor("새로운 아이디를 입력해 주세요", "아이디 제한 캡션입니다"),
                    ..._AssistBox(190)
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

  List<Column> _CenterFactor(String labelText, String captionText) {
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
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: SrTextField(
              height: 45,
              suffixIcon: Padding(
                padding: const EdgeInsets.fromLTRB(0, 4, 6, 4),
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                      backgroundColor: SrColors.primary,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100))),
                  child: const Text(
                    "중복확인",
                    style: TextStyle(
                        color: SrColors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
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
      )
    ];
  }
}
