import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:spotright/data/email/email_repository.dart';
import 'package:spotright/presentation/page/signup/sign_up_controller.dart';

class EmailController extends GetxController {
  EmailRepository emailRepository = Get.find();
  SignUpController signUpController = Get.find();

  RxString authCode = "".obs;
  RxBool isAuthenticated = false.obs;

  void onChanged(String text) {
    authCode.value = text;
  }

  Future<void> verifyEmail() async {
    isAuthenticated.value = await emailRepository.verifyEmail(
        signUpController.signUpState.email.value, authCode.value);
    if (isAuthenticated.value) {
      signUpController.signUpState.emailInputEnabled.value = false;
      Get.back();
    } else {
      Fluttertoast.showToast(msg: "인증번호가 일치하지 않습니다.");
    }
  }
}
