import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:spotright/data/user/user_repository.dart';
import 'package:spotright/data/user/user_response.dart';

class HomeController {
  UserRepository userRepository = Get.find();

  Rx<UserResponse> userInfo = UserResponse(memberId: 0).obs;

  Future<void> initState() async {
    await userRepository.fetchMyInfo();
    userInfo.value = userRepository.userResponse!;
  }

  void navigateRegisterSpot(dynamic page, Function(LatLng) moveCameraPosition, Function() initHome) {
    Get.to(page)?.then((position) async {
      if(position == null) return;

      await moveCameraPosition(position);
      await initHome();
    });
  }
}
