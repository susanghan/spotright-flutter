import 'package:get/get.dart';
import 'package:spotright/data/report/report_repository.dart';
import 'package:spotright/data/report/report_request.dart';
import 'package:spotright/data/user/user_repository.dart';
import 'package:spotright/data/user/user_response.dart';

class ProfileController extends GetxController {
  UserRepository userRepository = Get.find();
  ReportRepository reportRepository = Get.find();
  UserResponse user;
  final String reportType =  "MEMBER";

  ProfileController({required this.user});

  void follow() {
    userRepository.follow(user.memberId);
  }

  void unFollow() {
    userRepository.unfollow(user.memberId, userRepository.userResponse!.memberId);
  }

  void block() {
    userRepository.block(user.memberId);
  }

  void report(String type, String reason) {
    ReportRequest request = ReportRequest(
      reason: reason,
      memberOrMemberSpotId: user.memberId,
      reasonType: type,
      reportType: reportType,
    );
    reportRepository.report(request);
  }
}