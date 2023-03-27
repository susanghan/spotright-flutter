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
    var screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(top : (screenHeight-614) / 2, bottom: 44),
                  child: SvgPicture.asset("assets/login_logo.svg"),),
              Column(
                children: [
                  SrTextField(
                    hint: "login_id_hint".tr,
                    onChanged: userController.onIdChanged,),
                  SrTextField(
                    hint: "login_password_hint".tr,
                    password: true,
                    onChanged: userController.onPasswordChanged,
                  ),
                  SrCTAButton(action: userController.login, text: "login".tr),
                  Padding(
                    padding: EdgeInsets.only(bottom: 60),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment.centerRight,
                          width: 150,
                          child: TextButton(onPressed: () {
                            Get.to(FindId());
                          }, child: Text("find_id".tr, style: SrTypography.body3medium.copy(color: SrColors.gray2),)),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                            child: Text("|", style: SrTypography.body3medium.copy(color: SrColors.gray2))),
                        Container(
                          alignment: Alignment.centerLeft,
                          width: 150,
                          child: TextButton(onPressed: () {
                            Get.to(FindPassword());
                          }, child: Text("find_password".tr, style: SrTypography.body3medium.copy(color: SrColors.gray2))),
                        )
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
                    if(Platform.isIOS) _signInButton("assets/apple_white.svg", userController.signInWithApple, Colors.black, Colors.black),
                    _signInButton("assets/google.svg", userController.signInWithGoogle, SrColors.gray2, SrColors.white),
                    _signInButton("assets/kakao.svg", userController.signInWithKakao, SrColors.kakao, SrColors.kakao),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("inform_sign_up".tr, style: SrTypography.body2medium.copy(color: SrColors.gray2),),
                  GestureDetector(
                      onTap: () {
                        Get.to(SignUp());
                      },
                      child: Text("sign_up".tr, style: SrTypography.body2medium.copy(color: SrColors.primary),)),
                ],
              )
            ],
          ),
        ),
      ),
        ));
  }

  Widget _signInButton(String iconPath, Function() action, Color borderColor, Color background) {
    return GestureDetector(
      onTap: () async {
        bool isSuccessful = await action();
        if(isSuccessful) {
          Get.offAll(const Home());
          return;
        }

        Get.to(const SignUp());
      },
      child: Container(
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.symmetric(horizontal: 10),
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
