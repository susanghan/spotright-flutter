import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:spotright/data/email/email_repository.dart';
import 'package:spotright/data/oauth/oauth_repository.dart';
import 'package:spotright/presentation/page/signup/sign_up_controller.dart';

class EmailController extends GetxController {
  EmailRepository emailRepository = Get.find();
  SignUpController signUpController = Get.find();

  RxString authCode = "".obs;
  RxBool isAuthenticated = false.obs;
  RxBool isLoading = false.obs;

  void initState(){
    isLoading.value = false;
  }

  void onChanged(String text) {
    authCode.value = text;
  }

  Future<void> verifyEmail() async {
    isLoading.value = true;

    var res = await emailRepository.verifyEmail(signUpController.signUpState.email.value, authCode.value);
    isAuthenticated.value = res.isNotEmpty;

    if (isAuthenticated.value) {
      signUpController.signUpState.emailInputEnabled.value = false;
      isLoading.value = false;
      Get.back(result: res);
    } else {
      Fluttertoast.showToast(msg: "인증번호가 일치하지 않습니다.");
      isLoading.value = false;
    }
  }
}
