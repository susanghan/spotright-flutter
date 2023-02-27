import 'package:get/get.dart';
import 'package:spotright/data/spot/spot_repository.dart';
import 'package:spotright/data/spot/spot_response.dart';
import 'package:spotright/presentation/page/detail/detail.dart';

class SpotListController extends GetxController {
  SpotRepository spotRepository = Get.find();
  RxBool isEditMode = false.obs;
  RxSet<String> selectedCategories = <String>{"전체"}.obs;
  final RxList<SpotResponse> _spots = <SpotResponse>[].obs;
  RxList<SpotResponse> get spots => _spots
      .where((spot) => selectedCategories.contains("전체") || selectedCategories.contains(spot.mainCategory))
      .toList().obs;
  int userId = 0;

  void changeMode() {
    isEditMode.value = !isEditMode.value;
  }

  Future<void> initState(int userId, double topLatitude, double topLongitude,
      double bottomLatitude, double bottomLongitude) async {
    this.userId = userId;

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

  // todo 구현해야 함
  void finishEdit() {}
}
