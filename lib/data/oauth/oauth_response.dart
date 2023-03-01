import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

class OAuthResponse {
  OAuthResponse({this.email, required this.token, required this.authProvider});

  OAuthResponse.fromGoogle(
      GoogleSignInAccount info, GoogleSignInAuthentication auth)
      : email = info.email,
        token = auth.accessToken!,
        authProvider = "GOOGLE";

  OAuthResponse.fromApple(OAuthCredential info)
      : token = info.accessToken!,
        authProvider = "APPLE";

  OAuthResponse.fromKakao(OAuthToken info)
      : token = info.accessToken,
        email = Jwt.parseJwt(info.idToken!)["email"],
        authProvider = "KAKAO";

  String? email;
  String token;
  String authProvider;
}
