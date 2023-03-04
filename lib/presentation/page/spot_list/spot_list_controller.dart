import 'package:get/get.dart';
import 'package:spotright/data/spot/spot_repository.dart';
import 'package:spotright/data/spot/spot_response.dart';
import 'package:spotright/data/user/user_repository.dart';
import 'package:spotright/presentation/page/detail/detail.dart';

class SpotListController extends GetxController {
  SpotRepository spotRepository = Get.find();
  UserRepository userRepository = Get.find();
  RxBool isEditMode = false.obs;
  RxSet<String> selectedCategories = <String>{"전체"}.obs;
  final RxList<SpotResponse> _spots = <SpotResponse>[].obs;
  RxList<SpotResponse> get spots => _spots
      .where((spot) => selectedCategories.contains("전체") || selectedCategories.contains(spot.mainCategory))
      .toList().obs;
  int userId = 0;
  RxSet<int> toRemoveSpotIds = <int>{}.obs;
  double topLatitude = 90;
  double topLongitude = -180;
  double bottomLatitude = 0;
  double bottomLongitude = 179.999999;
  RxBool isMyPage = false.obs;

  void changeMode() {
    isEditMode.value = !isEditMode.value;
  }

  Future<void> initState(int userId, double topLatitude, double topLongitude,
      double bottomLatitude, double bottomLongitude) async {
    this.userId = userId;
    this.topLatitude = topLatitude;
    this.topLongitude = topLongitude;
    this.bottomLatitude = bottomLatitude;
    this.bottomLongitude = bottomLongitude;

    isMyPage.value = userRepository.userResponse!.memberId == userId;

    await _fetchSpots();
  }

  Future<void> _fetchSpots() async {
    _spots.value = await spotRepository.getSpotsFromCoordinate(
      userId,
      topLatitude: topLatitude,
      topLongitude: topLongitude,
      bottomLatitude: bottomLatitude,
      bottomLongitude: bottomLongitude,
    );
  }

  Function() moveDetail(SpotResponse spot) => () => Get.to(Detail(userId: userId, memberSpotId: spot.memberSpotId!));

  onCategorySelected(String category, bool isSelected) {
    if(isSelected) {
      selectedCategories.add(category);
    } else {
      selectedCategories.remove(category);
    }
  }

  void onCheckBoxSelected(int spotId, bool isChecked) {
    if(isChecked) {
      toRemoveSpotIds.add(spotId);
    } else {
      toRemoveSpotIds.remove(spotId);
    }
  }

  Future<void> finishEdit() async {
    await spotRepository.deleteSpots(toRemoveSpotIds.toList());
    await _fetchSpots();
    toRemoveSpotIds.clear();
    changeMode();
  }
}
