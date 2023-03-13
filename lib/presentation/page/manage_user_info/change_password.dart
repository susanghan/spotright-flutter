import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotright/presentation/common/typography.dart';
import 'package:spotright/presentation/page/manage_user_info/id_controller.dart';

import '../../common/colors.dart';
import '../../component/appbars/default_app_bar.dart';
import '../../component/buttons/sr_cta_button.dart';
import '../../component/sr_text_field/sr_text_field.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: DefaultAppBar(
          title: "비밀번호 변경",
          hasBackButton: true,
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 36),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _InputNewPassword("새로운 비밀번호를 입력해 주세요", ""),
                    const SizedBox(height: 8,),
                    _ConfirmNewPassword("다시 한 번 입력하세요", ""),
                  ],
                ),
              ),
              SrCTAButton(
                text: "완료",
                isEnabled: false,
                action: () {  },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _InputNewPassword(String labelText, String captionText) {
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
            height: 47,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 14),
          child: Text(
            captionText,
            style: const TextStyle(
                fontSize: 0,
                fontWeight: FontWeight.w300,
                color: SrColors.gray1),
          ),
        ),
      ],
    );
  }

  Widget _ConfirmNewPassword(String labelText, String captionText) {
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
            height: 47,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 14),
          child: Text(
            captionText,
            style: const TextStyle(
                fontSize: 0,
                fontWeight: FontWeight.w300,
                color: SrColors.gray1),
          ),
        ),
      ],
    );
  }
}
