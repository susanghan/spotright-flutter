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
  final String _refreshTokenKey = "refreshToken";
  final String _memberIdKey = "memberId";
  final String _getUserInfoPath = "/member";
  final String _signUpPath = "/member";
  final String _oauthLoginPath = "/member/oauth";
  final String _getMemberInfoPath = "/member";
  final String _updateBirthDatePath = "/member/birthdate";
  final String _blockPath = "/member/block";
  final String _getBlocksPath = "/member/blocks";
  final String _followPath = "/member/follow";
  final String _verifyDuplicatedIdPath = "/member/spotright-id/duplicate";
  final String _updateIdPath = "/member/spotright-id/update";
  final String _unblockPath = "/member/unblock";
  final String _unfollowPath = "/member/unfollow";
  final String _searchMembersByIdPath = "/member/spotright-id";
  final String _getFollowersByIdPath = "/member";
  final String _getFollowingsByIdPath = "/member";
  final String _unblockUsersPath = "/member/unblock";
  final String _updateNicknamePath = "/member/nickname";
  final String _deactivatePath = "/member/spotright-id";
  final String _findIdPath = "/member/spotright-id/forgot";
  final String _findPasswordPath = "/member/password/forgot";
  final String _loginPath = "/member/login";
  final String _updatePassword = "/member/password";

  bool get isLoggedIn => networkClient.accessToken.isNotEmpty;

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
  Future<bool> oauthLogin(String oAuthProvider, String accessToken) async {
    var res = await networkClient.login(method: Http.post, path: "$_oauthLoginPath/$oAuthProvider", headers: {"authorization": "Bearer $accessToken"});

    if(res.jsonMap == null) return false;
    userResponse = UserResponse.fromJson(res.jsonMap!);
    localRepository.save(_memberIdKey, userResponse!.memberId.toString());

    return res.statusCode == 200;
  }

  Future<bool> login(String id, String password) async {
    var res = await networkClient.request(method: Http.post, path: _loginPath, body: {
      "spotrightId": id,
      "password": password,
    });
    Map<String, String>? resHeaders = res.headers;
    if(res.responseWrapper.responseCode == "MEMBER_LOGGED_IN") networkClient.saveRefreshToken(resHeaders);
    else {
      return false;
    }

    var user = UserResponse.fromJson(res.jsonMap!);
    userResponse = user;
    localRepository.save(_memberIdKey, user.memberId.toString());

    return true;
  }

  Future<void> logout() async {
    await localRepository.clear(_refreshTokenKey);
    await localRepository.clear(_memberIdKey);
  }

  Future<bool> fetchRefreshTokenFromLocal() async {
    String savedRefreshToken = await localRepository.fetch(_refreshTokenKey);
    networkClient.refreshToken = savedRefreshToken;
    return networkClient.refreshToken?.isNotEmpty ?? false;
  }

  Future<void> fetchMyInfo() async {
    if(networkClient.accessToken.isEmpty) return;

    String memberId = await localRepository.fetch(_memberIdKey);
    var res = await networkClient.request(path: "$_getUserInfoPath/$memberId");
    UserResponse newUserResponse = UserResponse.fromJson(res.jsonMap!);
    userResponse = newUserResponse;
  }

  Future<int> signUp(SignUpRequest body, String accessToken) async {
    var res = await networkClient.request(method: Http.post, path: _signUpPath, body: body.toJson(), headers: {"authorization": accessToken});
    Map<String, String> headers = res.headers;
    networkClient.saveRefreshToken(headers);

    var jsonMap = res.jsonMap;
    if(jsonMap != null) {
      userResponse = UserResponse.fromJson(res.jsonMap!);
      localRepository.save(_memberIdKey, userResponse!.memberId.toString());
    }

    return res.statusCode;
  }

  Future<UserResponse> getMemberInfo(int memberId) async {
    var res = await networkClient.request(path: "$_getMemberInfoPath/$memberId");
    return UserResponse.fromJson(res.jsonMap!);
  }

  Future<void> updateBirthDate(String? birthdate) async {
    await networkClient.request(method: Http.patch, path: _updateBirthDatePath, body: {"birthdate": birthdate});
  }

  Future<void> block(int memberId) async {
    await networkClient.request(method: Http.post, path: "$_blockPath/$memberId");
  }

  Future<List<UserResponse>> getBlocks() async {
    var res = await networkClient.request(path: _getBlocksPath);
    return res.list?.map((json) => UserResponse.fromJson(json)).toList() ?? [];
  }

  Future<void> follow(int memberId) async {
    await networkClient.request(method: Http.post, path: "$_followPath/$memberId");

  }

  Future<String> verifyDuplicatedId(String spotrightId) async {
    var res = await networkClient.request(path: "$_verifyDuplicatedIdPath/$spotrightId");

    if(res.statusCode == 400 || res.statusCode == 500) throw NetworkException("네트워크 요청 중 에러가 발생했습니다. error code 1");
    return res.responseWrapper.responseCode!;
  }

  Future<void> updateId(String spotrightId) async {
    await networkClient.request(method: Http.patch, path: "$_updateIdPath/$spotrightId");
  }

  Future<void> unblock(int memberId) async {
    await networkClient.request(method: Http.delete, path: "$_unblockPath/$memberId");
  }

  Future<void> unfollow(int memberId, int requestMemberId, {bool isUnfollowing = true}) async {
    await networkClient.request(method: Http.delete, path: "$_unfollowPath/$memberId", body: {"isFollowing" : isUnfollowing});
  }

  Future<List<UserResponse>> searchMembersById(String spotrightId, int page, int pageSize) async {
    var res = await networkClient.request(path: "$_searchMembersByIdPath/$spotrightId", queryParameters: {
      "pageFrom" : page.toString(),
      "pageNum": pageSize.toString(),
    });
    var users = res.list?.map((e) => UserResponse.fromJson(e)).toList();
    return users ?? [];
  }

  Future<List<UserResponse>> getFollowersById(int memberId, int page, int pageSize) async {
    var res = await networkClient.request(path: "$_getFollowersByIdPath/$memberId/followers", queryParameters: {
      "pageFrom" : page.toString(),
      "pageNum": pageSize.toString(),
    });
    return res.list?.map((userJson) => UserResponse.fromJson(userJson)).toList() ?? [];
  }

  Future<List<UserResponse>> getFollowingsById(int memberId, int page, int pageSize) async {
    var res = await networkClient.request(path: "$_getFollowingsByIdPath/$memberId/followings", queryParameters: {
      "pageFrom" : page.toString(),
      "pageNum": pageSize.toString(),
    });
    return res.list?.map((userJson) => UserResponse.fromJson(userJson)).toList() ?? [];
  }

  Future<void> unblockUsers(List<int> memberIds) async {
    await networkClient.request(method: Http.delete, path: _unblockUsersPath, body: {"memberIds": memberIds});
  }

  Future<void> updateNickname(String nickname) async {
    await networkClient.request(method: Http.patch, path: _updateNicknamePath, body: {"nickname": nickname});
  }

  Future<bool> deactivate(String spotrightId) async {
    var res = await networkClient.request(method: Http.delete, path: "$_deactivatePath/$spotrightId");
    return res.statusCode == 200;
  }

  Future<void> findId(String email) async {
    await networkClient.request(method: Http.post, path: _findIdPath, body: {
      "email": email,
      "language": "KR",
    });
  }

  Future<void> findPassword(String id, String email) async {
    await networkClient.request(method: Http.post, path: _findPasswordPath, body: {
      "spotrightId": id,
      "email": email,
      "language": "KR",
    });
  }

  Future<bool> updatePassword(String password, String passwordReEntered) async {
    var res = await networkClient.request(method: Http.patch, path: _updatePassword, body: {
      "password": password,
      "passwordReEntered": passwordReEntered,
    });

    return res.statusCode == 200;
  }
}