import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:spotright/presentation/component/appbars/default_app_bar.dart';
import 'package:spotright/presentation/component/sr_text_field/sr_text_field.dart';

import '../../common/colors.dart';
import '../../component/buttons/sr_cta_button.dart';

//Todo : 무언가 입력해야 계정삭제 버튼이 활성화
//Todo : 계정삭제 버튼을 눌렀을 때 틀린 아이디를 입력했을 경우 경고창은 notification 밖을 누르면(사라짐?)
class DeactivateAccount extends StatefulWidget {
  const DeactivateAccount({Key? key}) : super(key: key);

  @override
  State<DeactivateAccount> createState() => _DeactivateAccountState();
}

class _DeactivateAccountState extends State<DeactivateAccount> {
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
      child:  Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //ui구현하기 위해서 집어 넣은 의미 없는 것~
          const SizedBox(
            width: double.infinity,
            height: 0,
          ),
          Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: Text(
                  "계정을 삭제하시려면 아이디를 입력해주세요",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: SrColors.black),
                ),
              ),
              SrTextField(),
            ],
          ),
          SrCTAButton(
            text: "계정 삭제",
            isEnabled: false,
            action: () { },
          ),
        ],
      ),
      ),
    ));
  }
}
