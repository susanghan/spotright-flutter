import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:spotright/presentation/page/login/user_controller.dart';

import '../../common/colors.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  UserController userController = Get.find();

  @override
  void initState() {
    userController.loginWithCache();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor:1.0),
        child: Scaffold(
          backgroundColor: SrColors.primary,
          body: Container(
            alignment: Alignment.center,
            child: SvgPicture.asset(
              "assets/spotright.svg",
              color: SrColors.white,
            ),
          ),
        ),
      ),
    );
  }
}
