import 'package:get/get.dart';
import 'package:spotright/data/user/user_repository.dart';
import 'package:spotright/data/user/user_response.dart';

class FollowingController extends GetxController {
  UserRepository userRepository = Get.find();
  Rx<UserResponse> user = UserResponse(memberId: 0).obs;
  RxString title = "".obs;
  RxInt tabIndex = 0.obs;
  RxList<UserResponse> followers = <UserResponse>[].obs;
  RxList<UserResponse> followings = <UserResponse>[].obs;

  FollowingController();

  void initState(int index, UserResponse user) {
    this.user.value = user;
    tabIndex.value = index;
    fetchFollowers();
    fetchFollowings();
  }

  void changeTab(int index) {
    tabIndex.value = index;
  }

  void fetchFollowers() async {
    followers.value = await userRepository.getFollowersById(user.value.memberId, 0, 100);
  }

  void fetchFollowings() async {
    followings.value = await userRepository.getFollowingsById(user.value.memberId, 0, 100);
  }

  Function() unfollow(int userId) {
    return () => userRepository.unfollow(userId, userRepository.userResponse!.memberId);
  }

  Function() removeFollower(int removingFollowerId) {
    return () => userRepository.unfollow(removingFollowerId, userRepository.userResponse!.memberId, isUnfollowing: false);
  }
}