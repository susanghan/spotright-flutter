import 'package:get/get.dart';
import 'package:spotright/data/user/user_repository.dart';
import 'package:spotright/data/user/user_response.dart';

class HomeController {
  UserRepository userRepository = Get.find();

  Rx<UserResponse>? userInfo;

  void initState() {
    userInfo = Rx<UserResponse>(userRepository.userResponse!);
  }
}