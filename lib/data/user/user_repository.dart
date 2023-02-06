import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:spotright/common/network_client.dart';
import 'package:spotright/common/token_util.dart';
import 'package:spotright/data/model/response_wrapper.dart';
import 'package:spotright/data/repository/local_repository.dart';
import 'package:spotright/data/user/user_response.dart';

class UserRepository {
  final String refreshTokenKey = "refreshToken";
  final String memberIdKey = "memberId";
  final String refreshTokenPath = "/member/token/renew";
  final String getUserInfoPath = "/member";
  bool get isLoggedIn => networkClient.accessToken != null;

  NetworkClient networkClient = Get.find();
  LocalRepository localRepository = Get.find();

  Logger logger = Get.find();
  UserResponse? userResponse;

  Future<void> loginWithLocalToken() async {
    await fetchRefreshTokenFromLocal();
    await refreshLogin();
    await fetchMyInfo();
  }

  Future<void> logout() async {
    await localRepository.clear(refreshTokenKey);
    await localRepository.clear(memberIdKey);
  }

  Future<void> fetchRefreshTokenFromLocal() async {
    String savedRefreshToken = await localRepository.fetch(refreshTokenKey);
    networkClient.refreshToken = savedRefreshToken;
  }

  Future<void> fetchMyInfo() async {
    if(networkClient.accessToken == null) return;

    await verifyAndRefreshToken();
    Map<String, String> requestHeader = {"authorization": networkClient.accessToken!};
    String memberId = await localRepository.fetch(memberIdKey);
    var res = await networkClient.request(path: "$getUserInfoPath/$memberId", headers: requestHeader);
    UserResponse newUserResponse = UserResponse.fromJson(res.jsonMap!);
    userResponse = newUserResponse;
  }

  Future<void> verifyAndRefreshToken() async {
    TokenUtil tokenUtil = TokenUtil();

    if(!tokenUtil.isValidToken(token: networkClient.accessToken, afterMinutes: 10)) await refreshLogin();
  }

  Future<void> refreshLogin() async {
    if(networkClient.refreshToken == null && networkClient.refreshToken!.isEmpty) return;

    Map<String, String> requestHeader = {"authorization": networkClient.refreshToken!};
    var res = await networkClient.request(path: refreshTokenPath, headers: requestHeader);
    Map<String, String>? headers = res.headers;
    String? auth = headers["authorization"];

    // todo : 실패 케이스 처리
    if(auth == null) return;

    TokenUtil tokenUtil = TokenUtil();
    List<String> tokens = tokenUtil.getTokens(auth);
    networkClient.accessToken = tokens[0];
    networkClient.refreshToken = tokens[1];

    localRepository.save(refreshTokenKey, networkClient.refreshToken!);
  }
}