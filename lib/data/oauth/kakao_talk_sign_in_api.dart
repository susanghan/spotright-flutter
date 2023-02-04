import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

class KakaoTalkSignInApi {
  Future<OAuthToken> login() async {
    bool isInstalled = await isKakaoTalkInstalled();

    OAuthToken token = isInstalled
        ? await UserApi.instance.loginWithKakaoTalk()
        : await UserApi.instance.loginWithKakaoAccount();

    print('카카오톡으로 로그인 성공 ${token.accessToken}');

    return token;
  }
}