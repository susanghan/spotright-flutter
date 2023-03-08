import 'package:get/get.dart';
import 'package:spotright/data/report/report_repository.dart';
import 'package:spotright/data/report/report_request.dart';
import 'package:spotright/data/spot/spot_repository.dart';
import 'package:spotright/data/spot/spot_response.dart';
import 'package:spotright/data/user/user_repository.dart';

class DetailController extends GetxController{
  SpotRepository spotRepository = Get.find();
  UserRepository userRepository = Get.find();
  ReportRepository reportRepository = Get.find();
  Rx<SpotResponse> spot = SpotResponse().obs;
  RxBool isMyPage = false.obs;

  Future<void> initState(int userId, int memberSpotId) async {
    await initSpot(userId, memberSpotId);
    isMyPage.value = userId == userRepository.userResponse!.memberId;
  }

  Future<void> initSpot(int userId, int memberSpotId) async {
    spot.value = await spotRepository.findOneSpot(userId, memberSpotId);
  }

  Future<void> report(String reasonType, String reason) async {
    reportRepository.report(ReportRequest(
      memberOrMemberSpotId: spot.value.memberSpotId,
        reason: reason,
        reasonType: reasonType,
        reportType: "MEMBER_SPOT",
    ));
  }
}