import 'package:google_sign_in/google_sign_in.dart';
import 'package:spotright/data/oauth/apple_sign_in_api.dart';

class OAuthResponse {
  OAuthResponse({this.email, required this.token});

  OAuthResponse.fromGoogle(GoogleSignInAccount info)
      : email = info.email,
        token = info.id;

  // OAuthResponse.fromApple(OAuthCredential info)
  //   : email = info.email,

  String? email;
  String token;
}
