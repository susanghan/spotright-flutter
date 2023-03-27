import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:spotright/data/email/email_repository.dart';
import 'package:spotright/data/oauth/oauth_response.dart';
import 'package:spotright/data/user/sign_up_request.dart';
import 'package:spotright/data/user/user_repository.dart';
import 'package:spotright/presentation/page/email/email.dart';
import 'package:spotright/presentation/page/home/home.dart';
import 'package:spotright/presentation/page/signup/sign_up_state.dart';

class SignUpController extends GetxController {
  SignUpController({required this.signUpState});

  final UserRepository userRepository = Get.find();
  final EmailRepository emailRepository = Get.find();
  final SignUpState signUpState;
  final TextEditingController emailController = TextEditingController();
  OAuthResponse? oAuthResponse;

  RxBool isLoading = false.obs;

  void onIdChanged(String id) {
    signUpState.id.value = id;
    signUpState.validateId(id);
    signUpState.checkedIdDuplication.value = false;
    signUpState.onChangeCtaState();
  }

  void onPasswordChanged(String password) {
    signUpState.password.value = password;
    signUpState.validatePassword();
    signUpState.onChangeCtaState();
  }

  void onPasswordConfirmChanged(String passwordConfirm) {
    signUpState.passwordConfirm.value = passwordConfirm;
    signUpState.onChangeCtaState();
  }

  void onNicknameChanged(String nickname) {
    signUpState.nickname.value = nickname;
    signUpState.validateNickname(nickname);
    signUpState.onChangeCtaState();
  }

  void selectSex(String sex) {
    signUpState.sex.value = sex;
  }

  void changePrivacyPolicy() {
    signUpState.privacyPolicy.value = !signUpState.privacyPolicy.value;
    signUpState.onChangeCtaState();
  }

  void changeBirthdate(String? newBirthdate) {
    signUpState.changeBirthdate(newBirthdate);
  }

  void initOauthInfo(OAuthResponse oAuthResponse) {
    this.oAuthResponse = oAuthResponse;
    signUpState.email.value = oAuthResponse.email ?? "";
    emailController.text = signUpState.email.value;
    signUpState.onChangeCtaState();
    if (signUpState.email.isNotEmpty)
      signUpState.emailInputEnabled.value = false;
  }

  void verifyDuplicateId() async {
    if(signUpState.idMessageStatus.value != MessageStatus.empty) {
      Fluttertoast.showToast(msg: "유효한 아이디를 입력해주세요");
    }

    bool isUsable = await userRepository
        .verifyDuplicatedId(signUpState.id.value)
        .catchError((err) {
      Fluttertoast.showToast(msg: err.toString());
      return false;
    });

    signUpState.checkedIdDuplication.value = isUsable;

    if (isUsable) {
      signUpState.validateIdDuplication(true);
      signUpState.idMessageStatus.value = MessageStatus.enabled;
      Fluttertoast.showToast(msg: "확인되었습니다");
    } else {
      signUpState.validateIdDuplication(false);
      signUpState.idMessageStatus.value = MessageStatus.checkDuplicate;
      Fluttertoast.showToast(msg: "중복된 아이디입니다");
    }
    signUpState.onChangeCtaState();
  }

  Function(bool checked) onJoinPathChanged(String key) {
    return (bool checked) {
      if (checked) {
        signUpState.selectedJoinPath.value = key;
      }
    };
  }

  Future<void> signup() async {
    SignUpRequest req = SignUpRequest(
      authProvider: oAuthResponse!.authProvider,
      birthdate: signUpState.birthdate.value,
      email: signUpState.email.value,
      password: signUpState.password.value,
      passwordReEntered: signUpState.passwordConfirm.value,
      gender: signUpState.sex.value,
      nickname: signUpState.nickname.value,
      spotrightId: signUpState.id.value,
      registrationPath: signUpState.selectedJoinPath.value,
    );
    int statusCode =
        await userRepository.signUp(req, "Bearer ${oAuthResponse!.token}");

    if (statusCode == 200 || statusCode == 201) {
      Get.offAll(const Home());
    } else if(statusCode == 409) {
      Fluttertoast.showToast(msg: "이미 가입된 이메일입니다");
    }
  }

  void authenticateEmail() async {
    bool res = await emailRepository.sendMail(signUpState.email.value);

    if(res) {
      Fluttertoast.showToast(msg: '인증코드를 메일로 전송했습니다');
      isLoading.value = false;

      Get.to(Email())?.then((accessToken) {
        if(oAuthResponse!.authProvider == 'SPOTRIGHT') oAuthResponse!.token = accessToken;
      });
    } else {
      Fluttertoast.showToast(msg: '인증코드 전송에 실패했습니다');
      isLoading.value = false;

    }
  }
}
