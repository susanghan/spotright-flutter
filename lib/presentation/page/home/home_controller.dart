import 'package:get/get.dart';
import 'package:spotright/data/user/user_repository.dart';
import 'package:spotright/data/user/user_response.dart';

class HomeController {
  UserRepository userRepository = Get.find();

  Rx<UserResponse> userInfo = UserResponse(memberId: 0).obs;

  void initState() {
    userInfo.value = userRepository.userResponse!;
  }
}
