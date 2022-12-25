import 'package:get/get.dart';
import 'package:spotright/presentation/page/signup/sign_up_state.dart';

class SignUpController extends GetxController {
  SignUpController({required this.signUpState});

  final SignUpState signUpState;

  void activateSignUpButton() {
    signUpState.ctaActive.value = !signUpState.ctaActive.value;
  }
}
