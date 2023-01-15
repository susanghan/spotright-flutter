import 'package:get/get.dart';
import 'package:spotright/presentation/page/signup/sign_up_state.dart';

class SignUpController extends GetxController {
  SignUpController({required this.signUpState});

  final SignUpState signUpState;

  void validate(String id) {
    signUpState.validateId(id);
  }

  void selectSex(int sex) {
    signUpState.sex.value = sex;
  }
}
