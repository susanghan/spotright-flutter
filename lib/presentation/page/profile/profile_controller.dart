import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:spotright/data/report/report_repository.dart';
import 'package:spotright/data/report/report_request.dart';
import 'package:spotright/data/user/user_repository.dart';
import 'package:spotright/data/user/user_response.dart';
import 'package:spotright/presentation/page/spot_list/spot_list.dart';

class ProfileController extends GetxController {
  UserRepository userRepository = Get.find();
  ReportRepository reportRepository = Get.find();
  Rx<UserResponse> user = UserResponse(memberId: 0).obs;
  final String reportType =  "MEMBER";

  ProfileController();

  void fetchProfileInfo(int userId) async {
    UserResponse userInfo = await userRepository.getMemberInfo(userId);
    user.value = userInfo;
  }

  Future<void> follow() async {
    await userRepository.follow(user.value.memberId);
    fetchProfileInfo(user.value.memberId);
  }

  Future<void> unFollow() async {
    await userRepository.unfollow(user.value.memberId, userRepository.userResponse!.memberId);
    fetchProfileInfo(user.value.memberId);
  }

  void block() {
    userRepository.block(user.value.memberId);
  }

  void report(String type, String reason) {
    ReportRequest request = ReportRequest(
      reason: reason,
      memberOrMemberSpotId: user.value.memberId,
      reasonType: type,
      reportType: reportType,
    );
    reportRepository.report(request);
  }

  void moveSpotList(LatLngBounds latLngBounds) async {
    Get.to(SpotList(userId: user.value.memberId,
        topLatitude: latLngBounds.northeast.latitude,
        topLongitude: latLngBounds.southwest.longitude,
        bottomLatitude: latLngBounds.southwest.latitude,
        bottomLongitude: latLngBounds.northeast.longitude));
  }
}