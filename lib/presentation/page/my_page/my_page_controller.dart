import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:spotright/data/user/user_repository.dart';
import 'package:spotright/data/user/user_response.dart';

class MyPageController extends GetxController {
  UserRepository userRepository = Get.find();
  RxString versionName = "0.0.0".obs;
  RxString buildNumber = "0".obs;

  Rx<UserResponse> userResponse = Rx<UserResponse>(UserResponse(memberId: 0));

  void initState() async {
    await userRepository.fetchMyInfo();
    userResponse.value = userRepository.userResponse!;

    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    versionName.value = packageInfo.version;
    buildNumber.value = packageInfo.buildNumber;
  }
}