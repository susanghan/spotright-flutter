import 'package:get/get.dart';
import 'package:spotright/data/user/user_repository.dart';
import 'package:spotright/data/user/user_response.dart';

class HomeController {
  UserRepository userRepository = Get.find();

  Rx<UserResponse> userInfo = UserResponse(memberId: 0).obs;

  Future<void> initState() async {
    await userRepository.fetchMyInfo();
    userInfo.value = userRepository.userResponse!;
  }
  
  Function() navigatePage(dynamic page) => () => Get.to(page)?.then((_) => initState());
}
