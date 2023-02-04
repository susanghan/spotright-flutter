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
          appBar: const DefaultAppBar(
            title: "생년월일 변경",
            hasBackButton: true,
          ),
          body: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 36),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //ui구현하기 위해서 집어 넣은 의미 없는 것~
                ..._AssistBox(),
                ..._labelText("생년월일을 입력해 주세요"),
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

  List<Widget> _AssistBox(){
    return[
      const SizedBox(
        width: double.infinity,
        height: 0,
      ),
    ];
  }

  List<Widget> _labelText(String labelText){
    return[
      Padding(
        //중간 상단으로 옮기기 위한 padding. 값은 대략 (100 + 중앙 ui의 height)로 한다.
        padding: const EdgeInsets.only(bottom: 170),
        child: Column(
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
            SrTextField( ),
          ],
        ),
      ),
    ];
  }
}
