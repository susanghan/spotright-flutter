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
    signUpState.checkedIdDuplication.value = false;
    signUpState.onChangeCtaState();
  }

  void onNicknameChanged(String nickname) {
    signUpState.validateNickname(nickname);
    signUpState.onChangeCtaState();
  }

  void selectSex(int sex) {
    signUpState.sex.value = sex;
  }

  void changePrivacyPolicy() {
    signUpState.privacyPolicy.value = !signUpState.privacyPolicy.value;
    signUpState.onChangeCtaState();
  }

  void changeBirthdate(String newBirthdate) {
    signUpState.changeBirthdate(newBirthdate);
  }

  void initOauthInfo(OAuthResponse oAuthResponse) {
    signUpState.email.value = oAuthResponse.email ?? "";
    emailController.text = signUpState.email.value;
    signUpState.onChangeCtaState();
    signUpState.emailInputEnabled.value = false;
  }

  void verifyDuplicateId() async {
    bool isUsable = await userRepository
        .verifyDuplicatedId(signUpState.id.value)
        .catchError((err) {
          // todo : 예외 처리
    });

    signUpState.checkedIdDuplication.value = isUsable;

    if (isUsable) {
      signUpState.validateIdDuplication(true);
    } else {
      signUpState.validateIdDuplication(false);
      signUpState.idMessageStatus.value = MessageStatus.checkDuplicate;
    }
    signUpState.onChangeCtaState();
  }
}
