import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:spotright/presentation/common/colors.dart';
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
      Get.to(const Home());
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
            Container(
              margin: EdgeInsets.only(top: 168, bottom: 76),
              height: 180,
              color: SrColors.gray3,
            ),
            _signInButton("assets/google.svg", "구글 계정으로 로그인", userController.signInWithGoogle),
            _signInButton("assets/apple.svg", "애플 계정으로 로그인", userController.signInWithApple),
            _signInButton("assets/kakao.svg", "카카오 계정으로 로그인", userController.signInWithKakao, isKakao: true),
          ],
        ),
      ),
    ));
  }

  Widget _signInButton(String iconPath, String buttonName, Function() action,
      {bool isKakao = false}) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      width: double.infinity,
      height: 45,
      child: OutlinedButton(
        onPressed: () async {
          bool isSuccessful = await action();
          if(isSuccessful) {
            Get.to(() => const Home());
            return;
          }

          Get.to(const SignUp());
        },
        style: OutlinedButton.styleFrom(
            backgroundColor: isKakao ? SrColors.kakao : SrColors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100))),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          SizedBox(width: 24, child: SvgPicture.asset(iconPath)),
          Text(buttonName, style: TextStyle(color: SrColors.black)),
          SizedBox(
            width: 24,
          ),
        ]),
      ),
    );
  }
}
