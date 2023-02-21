import 'package:get/get.dart';
import 'package:spotright/data/report/report_repository.dart';
import 'package:spotright/data/report/report_request.dart';
import 'package:spotright/data/user/user_repository.dart';
import 'package:spotright/data/user/user_response.dart';

class ProfileController extends GetxController {
  UserRepository userRepository = Get.find();
  ReportRepository reportRepository = Get.find();
  Rx<UserResponse> user = UserResponse(memberId: 0).obs;
  final String reportType =  "MEMBER";

  ProfileController(int userId) {
    fetchProfileInfo(userId);
  }

  void fetchProfileInfo(int userId) async {
    UserResponse userInfo = await userRepository.getMemberInfo(userId);
    user.value = userInfo;
  }

  void follow() {
    userRepository.follow(user.value.memberId);
  }

  void unFollow() {
    userRepository.unfollow(user.value.memberId, userRepository.userResponse!.memberId);
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
}