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

  Function(bool) onChecked(UserResponse user) {
    return (bool checked) {
      if(checked) {
        unblockUserIds.add(user.memberId);
      } else {
        unblockUserIds.remove(user.memberId);
      }
    };
  }

  Future<void> unblock() async {
    await userRepository.unblockUsers(unblockUserIds.toList());
    Get.back();
  }
}