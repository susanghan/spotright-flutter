import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotright/presentation/common/typography.dart';
import 'package:spotright/presentation/page/manage_user_info/change_passowrd_controller.dart';

import '../../common/colors.dart';
import '../../component/appbars/default_app_bar.dart';
import '../../component/buttons/sr_cta_button.dart';
import '../../component/sr_text_field/sr_text_field.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  ChangePasswordController changePasswordController = Get.put(ChangePasswordController());

  final InputBorder? focusInputBorder = const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(22)), borderSide: BorderSide(width: 1, color: SrColors.gray1));

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: DefaultAppBar(
          title: "비밀번호 변경",
          hasBackButton: true,
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 36),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _InputNewPassword("새로운 비밀번호를 입력해 주세요"),
                    const SizedBox(height: 8,),
                    _ConfirmNewPassword("다시 한 번 입력하세요"),
                  ],
                ),
              ),
              Obx(() => SrCTAButton(
                text: "완료",
                isEnabled: changePasswordController.ctaActive,
                action: changePasswordController.changePassword,
              )),
            ],
          ),
        ),
      ),
    );
  }

  Widget _InputNewPassword(String labelText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(
            labelText,
            style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: SrColors.black),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 0),
          child: SrTextField(
            height: 47,
            hint: "비밀번호",
            password: true,
            onChanged: changePasswordController.onPasswordChanged,
            focusInputBorder: focusInputBorder,
          ),
        ),
        Obx(() => Padding(
            padding: const EdgeInsets.only(left: 14, bottom: 8),
            child: Text(
              changePasswordController.passwordValidationMessage,
              style: changePasswordController.passwordMessageStatus.value == MessageStatus.enabled ? SrTypography.body2light.copy(color: SrColors.success) : SrTypography.body2light.copy(color: SrColors.primary),
            )),)
      ],
    );
  }

  Widget _ConfirmNewPassword(String labelText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(
            labelText,
            style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: SrColors.black),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 0),
          child: SrTextField(
            height: 47,
            hint: "비밀번호 확인",
            password: true,
            onChanged: changePasswordController.onPasswordConfirmChanged,
            focusInputBorder: focusInputBorder,
          ),
        ),
        Obx(() => Padding(
          padding: const EdgeInsets.only(left: 14),
          child: Text(
              (changePasswordController.password.value == changePasswordController.passwordConfirm.value) ? "비밀번호가 일치합니다" : "비밀번호가 일치하지 않습니다",
              style: (changePasswordController.password.value == changePasswordController.passwordConfirm.value) ? SrTypography.body2light.copy(color: SrColors.success) : SrTypography.body2light.copy(color: SrColors.primary)
          ),
        )),
      ],
    );
  }
}
