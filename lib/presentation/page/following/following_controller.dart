import 'package:get/get.dart';
import 'package:spotright/data/user/user_repository.dart';
import 'package:spotright/data/user/user_response.dart';

class FollowingController extends GetxController {
  UserRepository userRepository = Get.find();
  int userId = 0;
  RxInt tabIndex = 0.obs;
  RxList<UserResponse> followers = <UserResponse>[].obs;

  FollowingController();

  void initState(int index, userId) {
    userId = userId;
    tabIndex.value = index;
  }

  void changeTab(int index) {
    tabIndex.value = index;
  }

  void fetchFollowers() async {
    followers.value = await userRepository.getFollowersById(userId);
  }
}