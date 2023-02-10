import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:logger/logger.dart';
import 'package:spotright/data/oauth/apple_sign_in_api.dart';
import 'package:spotright/data/oauth/google_sign_in_api.dart';
import 'package:spotright/data/oauth/kakao_talk_sign_in_api.dart';
import 'package:spotright/data/oauth/oauth_response.dart';
import 'package:spotright/data/user/user_repository.dart';

class OAuthRepository {
  Logger logger = Logger();
  OAuthResponse? oAuthResponse;
  UserRepository userRepository = Get.find();

  void signUpWithGoogle() async {
    logger.d("구글로 로그인");
    GoogleSignInAccount? googleSignInAccount = await GoogleSignInApi.login();
    GoogleSignInAuthentication? auth = await googleSignInAccount?.authentication;
    oAuthResponse = OAuthResponse.fromGoogle(googleSignInAccount!, auth!);

    userRepository.login("google", oAuthResponse!.token);
  }

  void signInWithApple() async {
    logger.d("애플로 로그인");
    OAuthCredential appleCredential = await AppleSignInApi().login();
    oAuthResponse = OAuthResponse.fromApple(appleCredential);
  }

  void signInWithKakao() async {
    logger.d("카카오톡으로 로그인");
    OAuthToken kakaoToken = await KakaoTalkSignInApi().login();
    oAuthResponse = OAuthResponse.fromKakao(kakaoToken);
  }
}