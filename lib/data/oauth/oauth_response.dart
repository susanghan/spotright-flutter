import 'package:google_sign_in/google_sign_in.dart';

class OAuthResponse {
  OAuthResponse({this.email, required this.token});

  OAuthResponse.fromGoogle(GoogleSignInAccount info)
      : email = info.email,
        token = info.id;

  String? email;
  String token;
}
