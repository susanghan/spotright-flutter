import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:spotright/data/user/user_repository.dart';
import 'package:spotright/presentation/common/colors.dart';
import 'package:spotright/presentation/common/typography.dart';
import 'package:spotright/presentation/component/dialog/sr_dialog.dart';

class FindIdController extends GetxController {
  UserRepository userRepository = Get.find();
  RxString email = "".obs;

  void onEmailChanged(String text) {
    email.value = text;
  }

  Future<void> findId() async {
    Get.back();
    Get.dialog(
        SrDialog(
          icon: SvgPicture.asset("assets/check_large.svg"),
          title: "아이디 전달 완료",
          description: "아이디를 이메일로 전달했습니다!\n이메일을 확인해주세요",
          actions: [
            TextButton(onPressed: () {
              Get.back();
            }, child: Text("완료", style: SrTypography.body2medium.copy(color: SrColors.white),))
          ],
        )
    );

    await userRepository.findId(email.value);
  }
}