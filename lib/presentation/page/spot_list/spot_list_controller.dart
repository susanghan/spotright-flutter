import 'package:get/get.dart';
import 'package:spotright/data/spot/spot_repository.dart';
import 'package:spotright/data/spot/spot_response.dart';
import 'package:spotright/presentation/page/detail/detail.dart';

class SpotListController extends GetxController {
  SpotRepository spotRepository = Get.find();
  RxBool isEditMode = false.obs;
  RxList<SpotResponse> spots = <SpotResponse>[].obs;
  int userId = 0;

  void changeMode() {
    isEditMode.value = !isEditMode.value;
  }

  Future<void> initState(int userId, double topLatitude, double topLongitude,
      double bottomLatitude, double bottomLongitude) async {
    this.userId = userId;

    spots.value = await spotRepository.getSpotsFromCoordinate(
      userId,
      topLatitude: topLatitude,
      topLongitude: topLongitude,
      bottomLatitude: bottomLatitude,
      bottomLongitude: bottomLongitude,
    );
  }

  Function() moveDetail(SpotResponse spot) => () => Get.to(Detail(userId: userId, memberSpotId: spot.memberSpotId!));

  // todo 구현해야 함
  void finishEdit() {}
}
