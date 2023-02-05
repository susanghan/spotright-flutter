import 'package:get/get.dart';
import 'package:spotright/data/user/user_repository.dart';
import 'package:spotright/data/user/user_response.dart';

class MyPageController extends GetxController {
  UserRepository userRepository = Get.find();

  Rx<UserResponse> userResponse = Rx<UserResponse>(UserResponse());

  void initState() {
    userResponse.value = userRepository.userResponse!;
  }
}