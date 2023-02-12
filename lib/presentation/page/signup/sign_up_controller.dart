import 'dart:ffi';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:spotright/data/oauth/oauth_response.dart';
import 'package:spotright/data/user/user_repository.dart';
import 'package:spotright/presentation/page/signup/sign_up_state.dart';

class SignUpController extends GetxController {
  SignUpController({required this.signUpState});

  final UserRepository userRepository = Get.find();
  final SignUpState signUpState;
  final TextEditingController emailController = TextEditingController();

  void onIdChanged(String id) {
    signUpState.id.value = id;
    signUpState.validateId(id);
  }

  void onNicknameChanged(String nickname) {
    signUpState.validateNickname(nickname);
  }

  void selectSex(int sex) {
    signUpState.sex.value = sex;
  }

  void changePrivacyPolicy() {
    signUpState.privacyPolicy.value = !signUpState.privacyPolicy.value;
  }

  void changeBirthdate(String newBirthdate) {
    signUpState.changeBirthdate(newBirthdate);
  }

  void initOauthInfo(OAuthResponse oAuthResponse) {
    signUpState.email.value = oAuthResponse.email ?? "";
    emailController.text = signUpState.email.value;
  }

  void verifyDuplicateId() async {
    bool isUsable = await userRepository.verifyDuplicatedId(signUpState.id.value);

    signUpState.checkedIdDuplication.value = isUsable;
    if(!isUsable) signUpState.idMessageStatus.value = MessageStatus.checkDuplicate;
  }
}
