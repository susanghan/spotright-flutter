import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:spotright/data/user/user_repository.dart';
import 'package:spotright/presentation/common/colors.dart';
import 'package:spotright/presentation/common/typography.dart';
import 'package:spotright/presentation/component/dialog/sr_dialog.dart';

class FindPasswordController extends GetxController {
  UserRepository userRepository = Get.find();
  String id = "";
  String email = "";

  void onIdChanged(String text) {
    id = text;
  }

  void onEmailChanged(String text) {
    email = text;
  }

  Future<void> findPassword() async {
    Get.back();
    Get.dialog(
        SrDialog(
          icon: SvgPicture.asset("assets/check_large.svg"),
          title: "임시 비밀번호 전달 완료",
          description: "임시 비밀번호를 이메일로 전달했습니다!\n이메일을 확인해주세요",
          actions: [
            TextButton(onPressed: () {
              Get.back();
            }, child: Text("완료", style: SrTypography.body2medium.copy(color: SrColors.white),))
          ],
        )
    );

    await userRepository.findPassword(id, email);
  }
}