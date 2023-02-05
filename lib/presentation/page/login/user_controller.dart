import 'package:get/get.dart';
import 'package:spotright/data/oauth/oauth_repository.dart';
import 'package:spotright/data/user/user_repository.dart';

class UserController extends GetxController {
  OAuthRepository oAuthRepository = Get.find();
  UserRepository userRepository = Get.find();
  RxBool isLoggedIn = false.obs;

  void loginWithCache() async {
    await userRepository.loginWithLocalToken();
    if (userRepository.accessToken != null) {
      isLoggedIn.value = true;
    }
  }

  void signUpWithGoogle() {
    oAuthRepository.signUpWithGoogle();
  }

  void signInWithApple() {
    oAuthRepository.signInWithApple();
  }

  void signInWithKakao() {
    oAuthRepository.signInWithKakao();
  }
}
