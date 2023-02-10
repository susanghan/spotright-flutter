import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

class OAuthResponse {
  OAuthResponse({this.email, required this.token});

  OAuthResponse.fromGoogle(
      GoogleSignInAccount info, GoogleSignInAuthentication auth)
      : email = info.email,
        token = auth.accessToken!;

  OAuthResponse.fromApple(OAuthCredential info) : token = info.accessToken!;

  OAuthResponse.fromKakao(OAuthToken info) : token = info.accessToken;

  String? email;
  String token;
}
