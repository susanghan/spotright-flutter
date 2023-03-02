import 'package:get/get.dart';
import 'package:spotright/data/user/user_repository.dart';
import 'package:spotright/data/user/user_response.dart';

class BlockListController extends GetxController {
  UserRepository userRepository = Get.find();
  RxList<UserResponse> blockedUsers = <UserResponse>[].obs;
  RxSet<int> unblockUserIds = <int>{}.obs;

  Future<void> fetchBlockedUsers() async {
    var users = await userRepository.getBlocks();
    blockedUsers.value = users;
  }

  void onChecked(bool checked, UserResponse user) {
    if(checked) {
      unblockUserIds.add(user.memberId);
    } else {
      unblockUserIds.remove(user.memberId);
    }
  }
}