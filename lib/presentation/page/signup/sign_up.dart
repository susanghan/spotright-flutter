import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotright/presentation/common/colors.dart';
import 'package:spotright/presentation/component/sr_appbar/default_app_bar.dart';
import 'package:spotright/presentation/component/sr_check_box/sr_check_box.dart';
import 'package:spotright/presentation/component/sr_cta_button/sr_cta_button.dart';
import 'package:spotright/presentation/component/sr_text_field/sr_text_field.dart';
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
        body: Stack(alignment: Alignment.topCenter, children: [
          Obx(() => Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ..._InputEmail(),
                        ..._InputId(),
                        ..._InputNickname(),
                        Text('생년월일을 입력해주세요.'),
                        Padding(padding: EdgeInsets.only(bottom: 6)),
                        SrTextField(),
                        Padding(padding: EdgeInsets.only(bottom: 16)),
                        Text("input_sex".tr),
                        _SexSelector(),
                        Padding(padding: EdgeInsets.only(bottom: 18)),
                        Row(
                          children: [
                            SrCheckBox(
                                value: signUpController
                                    .signUpState.privacyPolicy.value,
                                onChanged: (checked) =>
                                    signUpController.changePrivacyPolicy()),
                            Padding(padding: EdgeInsets.only(right: 12)),
                            Text(
                              "개인정보 수집 및 이용동의(필수)".tr,
                              style: TextStyle(
                                  decoration: TextDecoration.underline),
                            ),
                          ],
                        ),
                        Padding(padding: EdgeInsets.only(bottom: 40 + 88)),
                      ]),
                ),
              )),
          Column(children: [
            Expanded(child: SizedBox.shrink()),
            Obx(() => SrCTAButton(
                  text: '완료',
                  isEnabled: signUpController.signUpState.ctaActive.value,
                  action: () {},
                )),
          ]),
        ]),
      ),
    );
  }

  List<Widget> _InputEmail() {
    return [
      Padding(
        padding: EdgeInsets.only(
          top: 30,
          bottom: 4,
        ),
        child: Text("input_email".tr),
      ),
      Padding(
        padding: EdgeInsets.only(bottom: 24),
        child: SrTextField(
          hint: 'example@gmail.com',
          suffixIcon: Padding(
            padding: EdgeInsets.all(4),
            child: OutlinedButton(
              onPressed: () {},
              child: Text(
                "인증완료",
                style: TextStyle(color: SrColors.white),
              ),
              style: OutlinedButton.styleFrom(
                  backgroundColor: SrColors.primary,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100))),
            ),
          ),
        ),
      ),
    ];
  }

  List<Widget> _InputId() {
    return [
      Padding(
        padding: EdgeInsets.only(bottom: 4),
        child: Text('아이디를 입력해주세요.'),
      ),
      Padding(
        padding: EdgeInsets.only(bottom: 6),
        child: SrTextField(
          hint: '아이디',
          onChanged: signUpController.onIdChanged,
          suffixIcon: Padding(
            padding: EdgeInsets.all(4),
            child: OutlinedButton(
              onPressed: () {},
              child: Text(
                "중복",
                style: TextStyle(color: SrColors.white),
              ),
              style: OutlinedButton.styleFrom(
                  backgroundColor: SrColors.primary,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100))),
            ),
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(left: 12, bottom: 16),
        child:
            Obx(() => Text(signUpController.signUpState.idValidationMessage)),
      ),
    ];
  }

  List<Widget> _InputNickname() {
    return [
      Padding(
        padding: EdgeInsets.only(bottom: 6),
        child: Text('닉네임을 입력해주세요.'),
      ),
      Padding(
        padding: EdgeInsets.only(bottom: 6),
        child: SrTextField(
            hint: '닉네임', onChanged: signUpController.onNicknameChanged),
      ),
      Padding(
        padding: EdgeInsets.only(left: 12, bottom: 20),
        child: Obx(
            () => Text(signUpController.signUpState.nicknameValidationMessage)),
      ),
    ];
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
