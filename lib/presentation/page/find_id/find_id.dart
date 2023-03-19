import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotright/presentation/common/typography.dart';
import 'package:spotright/presentation/component/appbars/default_app_bar.dart';
import 'package:spotright/presentation/component/buttons/sr_cta_button.dart';
import 'package:spotright/presentation/component/sr_text_field/sr_text_field.dart';
import 'package:spotright/presentation/page/find_id/find_id_controller.dart';

import '../../common/colors.dart';

class FindId extends StatefulWidget {
  const FindId({Key? key}) : super(key: key);

  @override
  State<FindId> createState() => _FindIdState();
}

class _FindIdState extends State<FindId> {
  FindIdController findIdController = Get.put(FindIdController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: DefaultAppBar(
        title: "아이디 찾기",
        hasBackButton: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Padding(
          padding: EdgeInsets.only(top: 152),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 8),
                  child: Text("이메일을 입력해주세요", style: SrTypography.body2medium,)),
              SrTextField(hint: "example@spotright.com", onChanged: findIdController.onEmailChanged,),
              Spacer(),
              Padding(
                padding: EdgeInsets.only(bottom: 36),
                child: SrCTAButton(action: findIdController.findId, text: "완료"),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
