import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:spotright/data/spot/spot_repository.dart';
import 'package:spotright/data/spot/spot_response.dart';
import 'package:spotright/data/user/user_repository.dart';
import 'package:spotright/data/user/user_response.dart';

class HomeController {
  UserRepository userRepository = Get.find();
  SpotRepository spotRepository = Get.find();

  Rx<UserResponse> userInfo = UserResponse(memberId: 0).obs;
  RxList<SpotResponse> spots = <SpotResponse>[].obs;
  RxBool shouldSpotsRefresh = false.obs;

  void initState() {
    userInfo = Rx<UserResponse>(userRepository.userResponse!);
  }

  void onCameraMoved() {
    shouldSpotsRefresh.value = true;
  }

  void fetchSpots(LatLngBounds latLngBounds) async {
    spots.value = await spotRepository.getSpotsFromCoordinate(
        userInfo.value.memberId,
        topLatitude: latLngBounds.northeast.latitude,
        topLongitude: latLngBounds.southwest.longitude,
        bottomLatitude: latLngBounds.southwest.latitude,
        bottomLongitude: latLngBounds.northeast.longitude);
    shouldSpotsRefresh.value = false;
  }
}
