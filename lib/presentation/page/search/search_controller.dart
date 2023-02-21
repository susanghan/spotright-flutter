import 'package:get/get.dart';
import 'package:spotright/data/local/recent_search_repository.dart';
import 'package:spotright/data/user/user_repository.dart';
import 'package:spotright/data/user/user_response.dart';

class SearchController extends GetxController {
  UserRepository userRepository = Get.find();
  RecentSearchRepository recentSearchRepository = RecentSearchRepository();
  RxString searchText = "".obs;
  Rx<List<UserResponse>> users = Rx<List<UserResponse>>([]);
  Rx<List<UserResponse>> recentUsers = Rx<List<UserResponse>>([]);

  @override
  void onInit() {
    initRecentUser();
    super.onInit();
  }

  void initRecentUser() async {
    recentUsers.value = await recentSearchRepository.getRecentSearch();
  }

  void onChangeSearchText(String newSearchText) {
    searchText.value = newSearchText;
  }

  void saveRecentSearch(UserResponse user) {
    recentSearchRepository.saveSearch(user);
  }

  void removeRecentSearch(UserResponse user) async {
    List<UserResponse> res = await recentSearchRepository.removeRecent(user);

    recentUsers.value = res;
  }

  Future<void> search() async {
    users.value = await userRepository.searchMembersById(searchText.value, 0, 100);
  }
}