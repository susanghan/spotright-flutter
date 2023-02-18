import 'package:get/get.dart';
import 'package:spotright/data/user/user_repository.dart';
import 'package:spotright/data/user/user_response.dart';

class ProfileController extends GetxController {
  UserRepository userRepository = Get.find();
  UserResponse user;

  ProfileController({required this.user});

  void follow() {
    userRepository.follow(user.memberId);
  }

  void unFollow() {
    userRepository.unfollow(user.memberId);
  }
}