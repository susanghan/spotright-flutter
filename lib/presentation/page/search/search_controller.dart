import 'package:get/get.dart';
import 'package:spotright/data/user/user_repository.dart';
import 'package:spotright/data/user/user_response.dart';

class SearchController extends GetxController {
  UserRepository userRepository = Get.find();
  RxString searchText = "".obs;
  Rx<List<UserResponse>> users = Rx<List<UserResponse>>([]);

  void onChangeSearchText(String newSearchText) {
    searchText.value = newSearchText;
  }

  Future<void> search() async {
    users.value = await userRepository.searchMembersById(searchText.value);
  }
}