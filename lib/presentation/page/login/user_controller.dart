import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:spotright/data/oauth/oauth_repository.dart';
import 'package:spotright/data/user/user_repository.dart';
import 'package:spotright/presentation/page/home/home.dart';
import 'package:spotright/presentation/page/login/Login.dart';

class UserController extends GetxController {
  OAuthRepository oAuthRepository = Get.find();
  UserRepository userRepository = Get.find();
  String id = "";
  String password = "";

  void onIdChanged(String text) {
    id = text;
  }

  void onPasswordChanged(String text) {
    password = text;
  }

  void loginWithCache() async {
    await userRepository.loginWithLocalToken();
    if (userRepository.isLoggedIn) {
      await userRepository.fetchMyInfo();
      Get.offAll(const Home());
    } else {
      Get.offAll(const Login());
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

  Future<void> login() async {
    bool res = await userRepository.login(id, password);

    if(res) {
      Get.offAll(const Home());
    } else {
      Fluttertoast.showToast(msg: "failed_to_login".tr);
    }
  }
}
