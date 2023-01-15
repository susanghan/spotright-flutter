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
            Obx(() =>
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Padding(padding: EdgeInsets.only(bottom: 30)),
                  Text("input_email".tr),
                  Padding(padding: EdgeInsets.only(bottom: 4)),
                  SrTextField(
                    srTextFieldModel:
                        SrTextFieldModel(hint: 'example@gmail.com'),
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 24)),
                  Text('아이디를 입력해주세요.'),
                  Padding(padding: EdgeInsets.only(bottom: 4)),
                  SrTextField(
                    srTextFieldModel: SrTextFieldModel(
                        hint: '아이디', onChanged: signUpController.validate),
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 6)),
                  Obx(() =>
                      Text(signUpController.signUpState.validationMessage)),
                  Padding(padding: EdgeInsets.only(bottom: 16)),
                  Text('닉네임을 입력해주세요.'),
                  Padding(padding: EdgeInsets.only(bottom: 6)),
                  SrTextField(
                    srTextFieldModel: SrTextFieldModel(hint: '닉네임'),
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 6)),
                  Text("닉네임은 *~*자로 입력"),
                  Padding(padding: EdgeInsets.only(bottom: 20)),
                  Text('생년월일을 입력해주세요.'),
                  Padding(padding: EdgeInsets.only(bottom: 6)),
                  SrTextField(
                    srTextFieldModel: SrTextFieldModel(),
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 16)),
                  Text("input_sex".tr),
                  _SexSelector(),
                  Padding(padding: EdgeInsets.only(bottom: 18)),
                  Row(
                    children: [
                      SrCheckBox(value: signUpController.signUpState.privacyPolicy.value, onChanged: (checked) => signUpController.changePrivacyPolicy()),
                      Padding(padding: EdgeInsets.only(right: 12)),
                      Text("개인정보 수집 및 이용동의(필수)".tr,
                        style: TextStyle(
                            decoration: TextDecoration.underline
                        ),
                      ),
                    ],
                  )
                ])),
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

  Widget _SexSelector() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      child: Row(
        children: [
          Flexible(
            child: Row(
              children: [
                Text("남자"),
                Padding(padding: EdgeInsets.only(right: 12)),
                SrCheckBox(
                  value: signUpController.signUpState.sex.value == 0,
                  onChanged: (checked) => signUpController.selectSex(0),
                ),
              ],
            ),
          ),
          Flexible(
            child: Row(
              children: [
                Text("여자"),
                Padding(padding: EdgeInsets.only(right: 12)),
                SrCheckBox(
                  value: signUpController.signUpState.sex.value == 1,
                  onChanged: (checked) => signUpController.selectSex(1),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
