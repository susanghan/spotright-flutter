import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:logger/logger.dart';
import 'package:spotright/data/oauth/apple_sign_in_api.dart';
import 'package:spotright/data/oauth/google_sign_in_api.dart';
import 'package:spotright/data/oauth/kakao_talk_sign_in_api.dart';
import 'package:spotright/data/oauth/oauth_response.dart';

class OAuthRepository {
  Logger logger = Logger();
  OAuthResponse? oauthResponse;

  void signUpWithGoogle() async {
    logger.d("구글로 로그인");
    GoogleSignInAccount? googleSignInAccount = await GoogleSignInApi.login();
    oauthResponse = OAuthResponse.fromGoogle(googleSignInAccount!);
  }

  void signInWithApple() async {
    logger.d("애플로 로그인");
    OAuthCredential appleCredential = await AppleSignInApi().login();
    oauthResponse = OAuthResponse.fromApple(appleCredential);
  }

  void signInWithKakao() async {
    logger.d("카카오톡으로 로그인");
    OAuthToken kakaoToken = await KakaoTalkSignInApi().login();
    oauthResponse = OAuthResponse.fromKakao(kakaoToken);
  }
}