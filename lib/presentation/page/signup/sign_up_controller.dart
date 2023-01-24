import 'package:get/get.dart';
import 'package:spotright/presentation/page/signup/sign_up_state.dart';

class SignUpController extends GetxController {
  SignUpController({required this.signUpState});

  final SignUpState signUpState;

  void onIdChanged(String id) {
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
}
