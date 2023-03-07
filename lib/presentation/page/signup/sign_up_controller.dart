import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:spotright/data/email/email_repository.dart';
import 'package:spotright/data/oauth/oauth_response.dart';
import 'package:spotright/data/user/sign_up_request.dart';
import 'package:spotright/data/user/user_repository.dart';
import 'package:spotright/presentation/page/email/email.dart';
import 'package:spotright/presentation/page/signup/sign_up_state.dart';

class SignUpController extends GetxController {
  SignUpController({required this.signUpState});

  final UserRepository userRepository = Get.find();
  final EmailRepository emailRepository = Get.find();
  final SignUpState signUpState;
  final TextEditingController emailController = TextEditingController();
  OAuthResponse? oAuthResponse;

  void onIdChanged(String id) {
    signUpState.id.value = id;
    signUpState.validateId(id);
    signUpState.checkedIdDuplication.value = false;
    signUpState.onChangeCtaState();
  }

  void onNicknameChanged(String nickname) {
    signUpState.nickname.value = nickname;
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
    this.oAuthResponse = oAuthResponse;
    signUpState.email.value = oAuthResponse.email ?? "";
    emailController.text = signUpState.email.value;
    signUpState.onChangeCtaState();
    signUpState.emailInputEnabled.value = false;
  }

  void verifyDuplicateId() async {
    bool isUsable = await userRepository
        .verifyDuplicatedId(signUpState.id.value)
        .catchError((err) {
      Fluttertoast.showToast(msg: err.toString());
      return false;
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

  Future<void> signup() async {
    SignUpRequest req = SignUpRequest(
      authProvider: oAuthResponse!.authProvider,
      birthdate: signUpState.birthdate.value,
      email: signUpState.email.value,
      gender: signUpState.sex.value == 0 ? "MALE" : "FEMALE",
      nickname: signUpState.nickname.value,
      spotrightId: signUpState.id.value,
    );
    await userRepository.signUp(req, "Bearer ${oAuthResponse!.token}");
  }

  void authenticateEmail() {
    emailRepository.sendMail(signUpState.email.value);
    Get.to(Email());
  }
}
