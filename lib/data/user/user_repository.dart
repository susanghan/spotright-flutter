import 'dart:convert';

import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:spotright/common/network_client.dart';
import 'package:spotright/common/network_exception.dart';
import 'package:spotright/data/model/response_wrapper.dart';
import 'package:spotright/data/local/local_repository.dart';
import 'package:spotright/data/user/sign_up_request.dart';
import 'package:spotright/data/user/user_response.dart';

class UserRepository {
  final String refreshTokenKey = "refreshToken";
  final String memberIdKey = "memberId";
  final String getUserInfoPath = "/member";
  final String signUpPath = "/member";
  final String loginPath = "/member/register-or-login";
  final String getMemberInfoPath = "/member";
  final String updateBirthDatePath = "/member/birthdate";
  final String blockPath = "/member/block";
  final String getBlocksPath = "/member/blocks";
  final String followPath = "/member/follow";
  final String verifyDuplicatedIdPath = "/member/spotright-id/duplicate";
  final String updateIdPath = "/member/spotright-id/update";
  final String unblockPath = "/member/unblock";
  final String unfollowPath = "/member/unfollow";
  final String searchMembersByIdPath = "/member/spotright-id";

  bool get isLoggedIn => networkClient.accessToken != null;

  NetworkClient networkClient = Get.find();
  LocalRepository localRepository = Get.find();

  Logger logger = Get.find();
  UserResponse? userResponse;

  Future<void> loginWithLocalToken() async {
    bool hasToken = await fetchRefreshTokenFromLocal();
    if(hasToken) {
      await networkClient.refreshLogin();
      await fetchMyInfo();
    }
  }

  /**
   * @return 로그인 성공 여부 반환.
   */
  Future<bool> login(String oAuthProvider, String accessToken) async {
    var res = await networkClient.login(method: Http.post, path: "$loginPath/$oAuthProvider", headers: {"authorization": "Bearer $accessToken"});

    if(res.jsonMap == null) return false;
    userResponse = UserResponse.fromJson(res.jsonMap!);
    localRepository.save(memberIdKey, userResponse!.memberId.toString());

    return true;
  }

  Future<void> logout() async {
    await localRepository.clear(refreshTokenKey);
    await localRepository.clear(memberIdKey);
  }

  Future<bool> fetchRefreshTokenFromLocal() async {
    String savedRefreshToken = await localRepository.fetch(refreshTokenKey);
    networkClient.refreshToken = savedRefreshToken;
    return networkClient.refreshToken?.isNotEmpty ?? false;
  }

  Future<void> fetchMyInfo() async {
    if(networkClient.accessToken == null) return;

    String memberId = await localRepository.fetch(memberIdKey);
    var res = await networkClient.request(path: "$getUserInfoPath/$memberId");
    UserResponse newUserResponse = UserResponse.fromJson(res.jsonMap!);
    userResponse = newUserResponse;
  }

  Future<void> signUp(SignUpRequest body, String accessToken) async {
    var res = await networkClient.request(method: Http.post, path: signUpPath, body: jsonEncode(body.toJson()), headers: {"authorization": accessToken});
    userResponse = UserResponse.fromJson(res.jsonMap!);
    localRepository.save(memberIdKey, userResponse!.memberId.toString());
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

  Future<bool> verifyDuplicatedId(String spotrightId) async {
    var res = await networkClient.request(path: "$verifyDuplicatedIdPath/$spotrightId");

    if(res.statusCode == 400 || res.statusCode == 500) throw NetworkException("네트워크 요청 중 에러가 발생했습니다. error code 1");
    return res.statusCode == 200;
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

  Future<void> searchMembersById(String spotrightId) async {
    await networkClient.request(path: "$searchMembersByIdPath/$spotrightId");
  }
}