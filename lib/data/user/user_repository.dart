import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:spotright/common/network_client.dart';
import 'package:spotright/data/model/response_wrapper.dart';
import 'package:spotright/data/repository/local_repository.dart';
import 'package:spotright/data/user/user_response.dart';

class UserRepository {
  final String refreshTokenKey = "refreshToken";
  final String memberIdKey = "memberId";
  final String getUserInfoPath = "/member";
  bool get isLoggedIn => networkClient.accessToken != null;

  NetworkClient networkClient = Get.find();
  LocalRepository localRepository = Get.find();

  Logger logger = Get.find();
  UserResponse? userResponse;

  Future<void> loginWithLocalToken() async {
    await fetchRefreshTokenFromLocal();
    await networkClient.refreshLogin();
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

    await networkClient.verifyAndRefreshToken();
    Map<String, String> requestHeader = {"authorization": networkClient.accessToken!};
    String memberId = await localRepository.fetch(memberIdKey);
    var res = await networkClient.request(path: "$getUserInfoPath/$memberId", headers: requestHeader);
    UserResponse newUserResponse = UserResponse.fromJson(res.jsonMap!);
    userResponse = newUserResponse;
  }
}