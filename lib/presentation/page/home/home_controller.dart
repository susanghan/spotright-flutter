import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:spotright/data/resources/marker.dart';
import 'package:spotright/data/spot/spot_repository.dart';
import 'package:spotright/data/spot/spot_response.dart';
import 'package:spotright/data/user/user_repository.dart';
import 'package:spotright/data/user/user_response.dart';
import 'dart:ui' as ui;

class HomeController {
  UserRepository userRepository = Get.find();
  SpotRepository spotRepository = Get.find();
  Uint8List? markerImageBytes;
  List<Uint8List> markerImageBytesList = [];
  List<Uint8List> pinImageBytesList = [];
  RxDouble pixelRatio = 2.625.obs;
  final int markerSize = 50;
  final int pinSize = 24;
  RxSet<String> selectedCategories = <String>{}.obs;

  Rx<UserResponse> userInfo = UserResponse(memberId: 0).obs;
  final RxList<SpotResponse> _spots = <SpotResponse>[].obs;
  RxSet<Marker> get spots => _spots.map((spot) => Marker(
      markerId: MarkerId(spot.memberSpotId.toString()),
    position: LatLng(spot.latitude!, spot.longitude!),
    icon: BitmapDescriptor.fromBytes(markerImageBytesList[((spot.category! / 100).toInt() + 6) % 7]),
  ),).toSet().obs;
  RxBool shouldSpotsRefresh = false.obs;

  void initState() {
    userInfo.value = userRepository.userResponse!;
    _setCustomMarker();
  }

  void onCameraMoved() {
    shouldSpotsRefresh.value = true;
  }

  Future<void> _setCustomMarker() async {
    markerImageBytes = await getBytesFromAsset("assets/marker_with_border.png", (50 * pixelRatio.value).toInt());
    markerImageBytesList = await Future.wait(SrMarker.markerAssets.map((it) async {
      return await getBytesFromAsset(it, (markerSize * pixelRatio.value).toInt());
    }).toList());
    pinImageBytesList = await Future.wait(SrMarker.pinAssets.map((it) async {
      return await getBytesFromAsset(it, (pinSize * pixelRatio.value).toInt());
    }).toList());
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }

  void fetchSpots(LatLngBounds latLngBounds) async {
    _spots.value = await spotRepository.getSpotsFromCoordinate(
        userInfo.value.memberId,
        topLatitude: latLngBounds.northeast.latitude,
        topLongitude: latLngBounds.southwest.longitude,
        bottomLatitude: latLngBounds.southwest.latitude,
        bottomLongitude: latLngBounds.northeast.longitude);
    shouldSpotsRefresh.value = false;
  }

  void onCategorySelected(Set<String> selected) {
    selectedCategories.value = selected;
  }
}
