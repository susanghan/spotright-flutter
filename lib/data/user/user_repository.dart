import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:spotright/common/network_client.dart';
import 'package:spotright/data/model/response_wrapper.dart';
import 'package:spotright/data/local/local_repository.dart';
import 'package:spotright/data/user/user_response.dart';

class UserRepository {
  final String refreshTokenKey = "refreshToken";
  final String memberIdKey = "memberId";
  final String getUserInfoPath = "/member";
  final String signUpPath = "/member";
  final String getMemberInfoPath = "/member";
  final String updateBirthDatePath = "/member/birthdate";
  final String blockPath = "/member/block";
  final String getBlocksPath = "/member/blocks";
  final String followPath = "/member/follow";
  final String verifyDuplicatedIdPath = "/member/spotright-id/duplicate";
  final String updateIdPath = "/member/spotright-id/update";
  final String unblockPath = "/member/unblock";
  final String unfollowPath = "/member/unfollow";

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

    String memberId = await localRepository.fetch(memberIdKey);
    var res = await networkClient.request(path: "$getUserInfoPath/$memberId");
    UserResponse newUserResponse = UserResponse.fromJson(res.jsonMap!);
    userResponse = newUserResponse;
  }

  Future<void> signUp() async {
    await networkClient.request(method: Http.post, path: signUpPath);
  }

  Future<void> getMemberInfo(int memberId) async {
    await networkClient.request(path: "$getMemberInfoPath/$memberId");
  }

  Future<void> updateBirthDate() async {
    await networkClient.request(method: Http.patch, path: updateBirthDatePath);
  }

  Future<void> block(int memberId) async {
    await networkClient.request(method: Http.post, path: "$blockPath/$memberId");
  }

  Future<void> getBlocks() async {
    await networkClient.request(path: getBlocksPath);
  }

  Future<void> follow(int memberId) async {
    await networkClient.request(method: Http.post, path: "$followPath/$memberId");
  }

  Future<void> verifyDuplicatedId(String spotrightId) async {
    await networkClient.request(path: "$verifyDuplicatedIdPath/$spotrightId");
  }

  Future<void> updateId(String spotrightId) async {
    await networkClient.request(method: Http.patch, path: "$updateIdPath/$spotrightId");
  }

  Future<void> unblock(int memberId) async {
    await networkClient.request(method: Http.delete, path: "$unblockPath/$memberId");
  }

  Future<void> unfollow(int memberId) async {
    await networkClient.request(method: Http.delete, path: "$unfollowPath/$memberId");
  }
}