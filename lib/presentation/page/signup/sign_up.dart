import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotright/presentation/common/colors.dart';
import 'package:spotright/presentation/component/sr_appbar/default_app_bar.dart';
import 'package:spotright/presentation/component/sr_check_box/sr_check_box.dart';
import 'package:spotright/presentation/component/sr_cta_button/sr_cta_button.dart';
import 'package:spotright/presentation/component/sr_text_field/sr_text_field.dart';
import 'package:spotright/presentation/component/sr_text_field/sr_text_field_model.dart';
import 'package:spotright/presentation/page/signup/sign_up_controller.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  SignUpController signUpController = Get.find();
  int _sex = 0; // 0 male, 1 female

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: DefaultAppBar(
          title: "회원가입",
          hasBackButton: true,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Stack(children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(padding: EdgeInsets.only(bottom: 30)),
              Text('이메일을 입력해주세요.'),
              Padding(padding: EdgeInsets.only(bottom: 4)),
              SrTextField(
                srTextFieldModel: SrTextFieldModel(hint: 'example@gmail.com'),
              ),
              Padding(padding: EdgeInsets.only(bottom: 24)),
              Text('아이디를 입력해주세요.'),
              Padding(padding: EdgeInsets.only(bottom: 4)),
              SrTextField(
                srTextFieldModel: SrTextFieldModel(
                    hint: '아이디', onChanged: signUpController.validate),
              ),
              Padding(padding: EdgeInsets.only(bottom: 6)),
              Obx(() => Text(signUpController.signUpState.validationMessage)),
              Padding(padding: EdgeInsets.only(bottom: 16)),
              Text('닉네임을 입력해주세요.'),
              SrTextField(
                srTextFieldModel: SrTextFieldModel(hint: '닉네임'),
              ),
              Text('생년월일을 입력해주세요.'),
              Text("input_sex".tr),
              SrCheckBox(value: _sex == 0, onChanged: (checked) {
                setState(() {
                  _sex = checked ? 0 : 1;
                });
              },
              ),
            ]),
            Column(
              children: [
                Expanded(
                    child: Padding(
                  padding: EdgeInsets.zero,
                )),
                Obx(() => SrCTAButton(
                      text: '완료',
                      isEnabled: signUpController.signUpState.ctaActive.value,
                      action: () {},
                    )),
                Padding(padding: EdgeInsets.only(bottom: 44)),
              ],
            )
          ]),
        ),
      ),
    );
  }
}
