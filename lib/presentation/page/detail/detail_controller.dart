import 'package:get/get.dart';
import 'package:spotright/data/spot/spot_repository.dart';
import 'package:spotright/data/spot/spot_response.dart';

class DetailController extends GetxController{
  SpotRepository spotRepository = Get.find();
  Rx<SpotResponse> spot = SpotResponse().obs;

  Future<void> initSpot(int userId, int memberSpotId) async {
    spot.value = await spotRepository.findOneSpot(userId, memberSpotId);
  }


}