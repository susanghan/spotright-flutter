import 'package:google_sign_in/google_sign_in.dart';
import 'package:spotright/data/google_sign_in_api.dart';
import 'package:spotright/data/oauth/oauth_response.dart';

class OAuthRepository {

  OAuthResponse? oauthResponse;

  void signUpWithGoogle() async {
    GoogleSignInAccount? googleSignInAccount = await GoogleSignInApi.login();
    oauthResponse = OAuthResponse.fromGoogle(googleSignInAccount!);
  }
}