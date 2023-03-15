import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:spotright/presentation/common/colors.dart';
import 'package:spotright/presentation/common/typography.dart';
import 'package:spotright/presentation/component/buttons/sr_cta_button.dart';
import 'package:spotright/presentation/component/sr_text_field/sr_text_field.dart';
import 'package:spotright/presentation/page/find_id/find_id.dart';
import 'package:spotright/presentation/page/find_password/find_password.dart';
import 'package:spotright/presentation/page/home/home.dart';
import 'package:spotright/presentation/page/login/user_controller.dart';
import 'package:spotright/presentation/page/signup/sign_up.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  UserController userController = Get.find();

  @override
  void initState() {
    super.initState();
    userController.loginWithCache(() {
      Get.offAll(const Home());
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 108, bottom: 44),
                child: SvgPicture.asset("assets/login_logo.svg"),),
            Column(
              children: [
                SrTextField(
                  hint: "아이디를 입력하세요",
                ),
                SrTextField(
                  hint: "비밀번호를 입력하세요",
                  password: true,
                ),
                SrCTAButton(action: () {}, text: "로그인"),
                Padding(
                  padding: EdgeInsets.only(bottom: 60),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(onPressed: () {
                        Get.to(FindId());
                      }, child: Text("아이디 찾기", style: SrTypography.body3medium.copy(color: SrColors.gray2),)),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Text("|", style: SrTypography.body3medium.copy(color: SrColors.gray2))),
                      TextButton(onPressed: () {
                        Get.to(FindPassword());
                      }, child: Text("비밀번호 찾기", style: SrTypography.body3medium.copy(color: SrColors.gray2)))
                    ],
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if(Platform.isIOS) _signInButton("assets/apple.svg", userController.signInWithApple, Colors.black, Colors.black),
                  _signInButton("assets/google.svg", userController.signInWithGoogle, SrColors.gray2, SrColors.white),
                  _signInButton("assets/kakao.svg", userController.signInWithKakao, SrColors.kakao, SrColors.kakao),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("아직 Spotright에 가입하지 않으셨나요? ", style: SrTypography.body2medium.copy(color: SrColors.gray2),),
                GestureDetector(
                  onTap: () {
                    Get.to(SignUp());
                  },
                    child: Text("회원가입", style: SrTypography.body2medium.copy(color: SrColors.primary),)),
              ],
            )
          ],
        ),
      ),
    ));
  }

  Widget _signInButton(String iconPath, Function() action, Color borderColor, Color background) {
    return GestureDetector(
      onTap: () async {
        bool isSuccessful = await action();
        if(isSuccessful) {
          Get.to(() => const Home());
          return;
        }

        Get.to(const SignUp());
      },
      child: Container(
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.only(right: 20),
        width: 46,
        height: 46,
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(100),
          border: Border.all(
            color: borderColor
          )
        ),
        child: SvgPicture.asset(iconPath, width: 28,),
      ),
    );
  }
}
