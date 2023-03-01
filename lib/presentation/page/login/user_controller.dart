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

  Future<bool> signInWithGoogle() {
    return oAuthRepository.signUpWithGoogle();
  }

  Future<bool> signInWithApple() {
    return oAuthRepository.signInWithApple();
  }

  Future<bool> signInWithKakao() {
    return oAuthRepository.signInWithKakao();
  }
}
