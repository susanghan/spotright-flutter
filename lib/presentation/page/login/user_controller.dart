import 'package:get/get.dart';
import 'package:spotright/data/oauth/oauth_repository.dart';
import 'package:spotright/data/user/user_repository.dart';

class UserController extends GetxController {
  OAuthRepository oAuthRepository = Get.find();
  UserRepository userRepository = Get.find();

  void loginWithCache(Function() movePage) async {
    await userRepository.loginWithLocalToken();
    if (userRepository.isLoggedIn) {
      await userRepository.fetchMyInfo();
      movePage();
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
