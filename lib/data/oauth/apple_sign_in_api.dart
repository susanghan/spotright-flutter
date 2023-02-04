import 'package:firebase_auth/firebase_auth.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AppleSignInApi {

  Future<OAuthCredential> login() async {

    final appleCredential = await SignInWithApple.getAppleIDCredential(scopes: [
      AppleIDAuthorizationScopes.email,
    ]);

    final OAuthCredential oauthCredential = OAuthProvider("https://spotright-372310.firebaseapp.com/__/auth/handler").credential(
      idToken: appleCredential.identityToken,
      accessToken: appleCredential.authorizationCode,
    );

    print("apple ${oauthCredential.accessToken} ${oauthCredential.idToken} ${oauthCredential.rawNonce}");

    return oauthCredential;
  }
}