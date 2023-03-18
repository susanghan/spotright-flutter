import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotright/data/oauth/oauth_repository.dart';
import 'package:spotright/presentation/common/colors.dart';
import 'package:spotright/presentation/common/typography.dart';
import 'package:spotright/presentation/component/appbars/default_app_bar.dart';
import 'package:spotright/presentation/component/buttons/sr_cta_button.dart';
import 'package:spotright/presentation/component/dialog/birthday_dialog.dart';
import 'package:spotright/presentation/component/sr_check_box/sr_check_box.dart';
import 'package:spotright/presentation/component/sr_text_field/sr_text_field.dart';
import 'package:spotright/presentation/page/signup/sign_up_controller.dart';
import 'package:spotright/presentation/page/signup/sign_up_state.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  SignUpController signUpController = Get.put(SignUpController(signUpState: SignUpState()));
  OAuthRepository oAuthRepository = Get.find();

  @override
  void initState() {
    if (oAuthRepository.oAuthResponse == null) {
      return;
    }

    signUpController.initOauthInfo(oAuthRepository.oAuthResponse!);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: DefaultAppBar(
          title: "회원가입",
          hasBackButton: true,
        ),
        body: Stack(alignment: Alignment.topCenter, children: [
          Obx(() =>
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ..._InputEmail(),
                        ..._InputId(),
                        ..._InputPassword(),
                        ..._InputPasswordConfirm(),
                        ..._InputNickname(),
                        ..._InputBirthday(),
                        ..._InputSex(),
                        ..._InputJoinPath(),
                        ..._InputPrivacyPolicy(),
                        Padding(padding: EdgeInsets.only(bottom: 40 + 88)),
                      ]),
                ),
              )),
          Column(children: [
            const Expanded(child: SizedBox.shrink()),
            Obx(() =>
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 36, horizontal: 16),
                  child: SrCTAButton(
                    text: '완료',
                    isEnabled: signUpController.signUpState.ctaActive.value,
                    action: signUpController.signup,
                  ),
                )),
          ]),
        ]),
      ),
    );
  }

  List<Widget> _InputEmail() {
    return [
      Padding(padding: EdgeInsets.only(bottom: 30)),
      _SectionTitle("input_email".tr),
      Padding(
        padding: EdgeInsets.only(bottom: 24),
        child: SrTextField(
          controller: signUpController.emailController,
          enabled: signUpController.signUpState.emailInputEnabled.value,
          onChanged: (text) {
            signUpController.signUpState.email.value = text;
          },
          hint: 'example@gmail.com',
          suffixIcon: Padding(
            padding: EdgeInsets.all(4),
            child: OutlinedButton(
              onPressed: () {
                if(signUpController.signUpState.emailInputEnabled.value) signUpController.authenticateEmail();
              },
              child: Text(
                signUpController.signUpState.emailInputEnabled.value ? "인증하기" : "인증완료",
                style: TextStyle(color: SrColors.white),
              ),
              style: OutlinedButton.styleFrom(
                  backgroundColor: signUpController.signUpState.emailInputEnabled.value ? SrColors.primary : SrColors.gray9e,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100))),
            ),
          ),
        ),
      ),
    ];
  }

  List<Widget> _InputPassword() {
    return [
      _SectionTitle('비밀번호를 입력해주세요'),
      Padding(
        padding: EdgeInsets.only(bottom: 6),
        child: SrTextField(
          password: true,
          hint: '비밀번호',
          onChanged: signUpController.onPasswordChanged,
        ),
      ),
      Padding(
        padding: EdgeInsets.only(left: 12, bottom: 16),
        child:
        Obx(() => Text(signUpController.signUpState.passwordValidationMessage)),
      ),
    ];
  }

  List<Widget> _InputPasswordConfirm() {
    return [
      _SectionTitle('다시 한 번 입력해주세요'),
      Padding(
        padding: EdgeInsets.only(bottom: 6),
        child: SrTextField(
          password: true,
          hint: '비밀번호 확인',
          onChanged: signUpController.onPasswordConfirmChanged,
        ),
      ),
      Padding(
        padding: EdgeInsets.only(left: 12, bottom: 16),
        child:
        Obx(() => Text(signUpController.signUpState.isPasswordsEqual ? "비밀번호가 일치합니다." : "비밀번호가 일치하지 않습니다.")),
      ),
    ];
  }

  List<Widget> _InputId() {
    return [
      _SectionTitle('아이디를 입력해주세요'),
      Padding(
        padding: EdgeInsets.only(bottom: 6),
        child: SrTextField(
          hint: '아이디',
          onChanged: signUpController.onIdChanged,
          suffixIcon: Padding(
            padding: EdgeInsets.all(4),
            child: OutlinedButton(
              onPressed: signUpController.verifyDuplicateId,
              child: Text(
                signUpController.signUpState.checkedIdDuplication.value ? "확인완료" : "중복확인",
                style: TextStyle(color: SrColors.white),
              ),
              style: OutlinedButton.styleFrom(
                  backgroundColor: signUpController.signUpState.checkedIdDuplication.value ? SrColors.gray9e : SrColors.primary,
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
      _SectionTitle('닉네임을 입력해주세요'),
      Padding(
        padding: EdgeInsets.only(bottom: 6),
        child: SrTextField(
            hint: '닉네임', onChanged: signUpController.onNicknameChanged),
      ),
      Padding(
        padding: EdgeInsets.only(left: 12, bottom: 20),
        child: Obx(
                () =>
                Text(signUpController.signUpState.nicknameValidationMessage)),
      ),
    ];
  }

  List<Widget> _InputBirthday() {
    return [
      _SectionTitle('생년월일을 입력해주세요'),
      Container(
        width: double.infinity,
        height: 44,
        margin: EdgeInsets.only(bottom: 16),
        child: OutlinedButton(
          onPressed: () {
            Get.dialog(BirthdayDialog(onChanged: (date) {
              signUpController.changeBirthdate(date);
            },
              defaultDate: signUpController.signUpState.birthdate.value,));
          },
          child: Text(signUpController.signUpState.birthdate.value,
            style: TextStyle(color: SrColors.gray1),),
          style: OutlinedButton.styleFrom(
              side: BorderSide(
                width: 1,
                color: SrColors.gray1,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              )),
        ),
      ),
    ];
  }

  List<Widget> _InputSex() {
    return [
      _SectionTitle("input_sex".tr),
      _SexSelector(),
      Padding(padding: EdgeInsets.only(bottom: 18)),
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

  List<Widget> _InputJoinPath() {
    return [
      _SectionTitle("가입경로를 선택해주세요"),
      ...{"INSTAGRAM": "인스타그램", "EVERYTIME": "에브리타임", "FRIEND": "지인", "ETC": "기타"}
          .entries.map((entry) => _PathItem(entry.key, entry.value, signUpController.signUpState.selectedJoinPath == entry.key)).toList(),
      Padding(padding: EdgeInsets.only(bottom: 12)),
    ];
  }

  Widget _PathItem(String key, String path, bool selected) {
    return Padding(
      padding: EdgeInsets.only(left: 12, bottom: 16),
      child: Row(
        children: [
          Padding(
              padding: EdgeInsets.only(right: 8),
              child: SrCheckBox(value: selected, onChanged: signUpController.onJoinPathChanged(key))),
          Text(path)
        ],
      ),
    );
  }

  List<Widget> _InputPrivacyPolicy() {
    return [
      Row(
        children: [
          SizedBox(
            width: 16,
            height: 16,
            child: SrCheckBox(
                isRectangle: true,
                value: signUpController
                    .signUpState.privacyPolicy.value,
                onChanged: (checked) =>
                    signUpController.changePrivacyPolicy()),
          ),
          Padding(padding: EdgeInsets.only(right: 12)),
          Text(
            "개인정보 수집 및 이용동의(필수)".tr,
            style: TextStyle(
                decoration: TextDecoration.underline),
          ),
        ],
      ),
    ];
  }

  Widget _SectionTitle(String title) {
    return Padding(padding: EdgeInsets.only(bottom: 8), child: Text(title, style: SrTypography.body2medium,));
  }
}
