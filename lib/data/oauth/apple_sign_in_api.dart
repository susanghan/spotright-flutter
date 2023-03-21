import 'package:firebase_auth/firebase_auth.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:spotright/env/server_env.dart';

class AppleSignInApi {

  Future<OAuthCredential> login() async {

    String baseUrl = ServerEnv.baseUrl;
    var uri = Uri.https(baseUrl, "/api/member/oauth/apple");

    final appleCredential = await SignInWithApple.getAppleIDCredential(scopes: [
      AppleIDAuthorizationScopes.email,
    ],
    webAuthenticationOptions: WebAuthenticationOptions(clientId: "com.susanghan.spotright.login", redirectUri: uri));

    final OAuthCredential oauthCredential = OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken,
      accessToken: appleCredential.authorizationCode,
    );

    return oauthCredential;
  }
}