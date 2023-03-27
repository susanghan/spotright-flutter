import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotright/presentation/common/colors.dart';
import 'package:spotright/presentation/common/typography.dart';
import 'package:spotright/presentation/component/appbars/default_app_bar.dart';
import 'package:spotright/presentation/component/buttons/sr_cta_button.dart';
import 'package:spotright/presentation/component/sr_text_field/sr_text_field.dart';

import 'email_controller.dart';

class Email extends StatefulWidget {
  const Email({Key? key}) : super(key: key);

  @override
  State<Email> createState() => _EmailState();
}

class _EmailState extends State<Email> {
  EmailController emailController = Get.put(EmailController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Stack(children: [
      Obx(()=>Offstage(
        offstage: !emailController.isLoading.value,
        child: Stack(
          children: const [
            Opacity(
              opacity: 0.5,
              child: ModalBarrier(
                dismissible: false,
                color: SrColors.gray1,
              ),
            ),
            Center(
              child: CircularProgressIndicator(
                strokeWidth: 2.0,
                color: SrColors.primary,
              ),
            )
          ],
        ),
      ),),
      Scaffold(
          appBar: DefaultAppBar(
            title: "이메일 인증",
            hasBackButton: true,
          ),
          body: Padding(
              padding: EdgeInsets.only(left: 16, right: 16, top: 152),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: EdgeInsets.only(bottom: 8),
                        child: Text("이메일로 전송된 인증번호를 입력해주세요",
                            style: SrTypography.body2medium)),
                    SrTextField(
                      controller: TextEditingController(),
                      enabled: true,
                      onChanged: emailController.onChanged,
                      hint: '영문, 숫자 6자리',
                      suffixIcon: Padding(
                        padding: EdgeInsets.all(4),
                        child: OutlinedButton(
                          onPressed: emailController.verifyEmail,
                          child: Text(
                            "인증하기",
                            style: TextStyle(color: SrColors.white),
                          ),
                          style: OutlinedButton.styleFrom(
                              backgroundColor: SrColors.primary,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100))),
                        ),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text("메일을 못 받았다면 스팸 메일함을 확인해주세요",
                            style: SrTypography.body3medium
                                .copy(color: SrColors.gray1)))
                  ]))),
    ]));
  }
}
