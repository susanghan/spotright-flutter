import 'package:get/get.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:logger/logger.dart';
import 'package:spotright/common/network_client.dart';
import 'package:spotright/data/model/response_wrapper.dart';
import 'package:spotright/data/repository/local_repository.dart';
import 'package:spotright/data/user/user_response.dart';

class UserRepository {
  final String refreshTokenKey = "refreshToken";
  final String refreshTokenPath = "/member/token/renew";
  final String getUserInfoPath = "/member";

  NetworkClient networkClient = Get.find();
  LocalRepository localRepository = Get.find();

  Logger logger = Get.find();
  UserResponse? userResponse;
  String? accessToken;
  String? refreshToken;

  Future<void> loginWithLocalToken() async {
    await fetchRefreshTokenFromLocal();
    await refreshLogin();
    await fetchMyInfo();
  }

  Future<void> fetchRefreshTokenFromLocal() async {
    String savedRefreshToken = await localRepository.fetch(refreshTokenKey);
    refreshToken = savedRefreshToken;
  }

  Future<void> fetchMyInfo() async {
    if(userResponse == null) return;

    await verifyAndRefreshToken();
    Map<String, String> requestHeader = {"authorization": accessToken!};
    var res = await networkClient.request(path: "$getUserInfoPath/${userResponse!.memberId}", headers: requestHeader);
    UserResponse newUserResponse = UserResponse.fromJson(res.jsonMap!);
    userResponse = newUserResponse;
  }

  Future<void> verifyAndRefreshToken() async {
    if(!isValidToken(afterMinutes: 10)) await refreshLogin();
  }

  bool isValidToken({int afterMinutes = 0}) {
    if(accessToken == null) return false;

    DateTime? expiryDate = Jwt.getExpiryDate(accessToken!.split(" ")[1]);
    DateTime now = DateTime.now();
    DateTime targetTime = now.add(Duration(minutes: afterMinutes));

    if(expiryDate == null) return false;

    return targetTime.isAfter(expiryDate);
  }

  Future<void> refreshLogin() async {
    if(refreshToken == null && refreshToken!.isEmpty) return;

    Map<String, String> requestHeader = {"authorization": refreshToken!};
    var res = await networkClient.request(path: refreshTokenPath, headers: requestHeader);
    Map<String, String>? headers = res.headers;
    String? auth = headers["authorization"];

    // todo : 실패 케이스 처리
    if(auth == null) return;

    List<String> splitTokens = auth.substring(1, auth.length - 1).split(",");
    String newAccessToken = splitTokens[0].split(":")[1].replaceAll(" ", "");
    String newRefreshToken = splitTokens[1].split(":")[1].replaceAll(" ", "");
    accessToken = "Bearer $newAccessToken";
    refreshToken = "Bearer $newRefreshToken";

    localRepository.save(refreshTokenKey, refreshToken ?? "");
  }
}