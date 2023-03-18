import 'package:get/get.dart';
import 'package:spotright/data/report/report_repository.dart';
import 'package:spotright/data/report/report_request.dart';
import 'package:spotright/data/user/user_repository.dart';
import 'package:spotright/data/user/user_response.dart';

class ProfileController extends GetxController {
  UserRepository userRepository = Get.find();
  ReportRepository reportRepository = Get.find();
  Rx<UserResponse> user = UserResponse(memberId: 0).obs;
  RxBool isMyPage = false.obs;
  final String reportType =  "MEMBER";

  ProfileController();

  void fetchProfileInfo(int userId) async {
    UserResponse userInfo = await userRepository.getMemberInfo(userId);
    user.value = userInfo;
    isMyPage.value = userInfo.memberId == userRepository.userResponse!.memberId;
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

  Future<void> report(String type, String reason) async {
    ReportRequest request = ReportRequest(
      reason: reason,
      memberOrMemberSpotId: user.value.memberId,
      reasonType: type,
      reportType: reportType,
    );
    await reportRepository.report(request);
  }
}