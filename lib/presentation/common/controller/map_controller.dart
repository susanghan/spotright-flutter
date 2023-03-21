import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:spotright/data/resources/marker.dart';
import 'package:spotright/data/spot/spot_repository.dart';
import 'package:spotright/data/spot/spot_response.dart';
import 'package:spotright/data/user/user_response.dart';
import 'package:spotright/presentation/common/colors.dart';
import 'package:spotright/presentation/common/typography.dart';
import 'package:spotright/presentation/component/bottom_sheet/sr_bottom_sheet.dart';
import 'package:spotright/presentation/component/dialog/sr_dialog.dart';
import 'package:spotright/presentation/page/detail/detail.dart';
import 'package:spotright/presentation/page/spot_list/spot_list.dart';
import 'dart:ui' as ui;

class MapController extends GetxController {
  SpotRepository spotRepository = Get.find();

  Uint8List? markerImageBytes;
  List<Uint8List> markerImageBytesList = [];
  List<Uint8List> pinImageBytesList = [];
  RxDouble pixelRatio = 2.625.obs;
  final int markerSize = 70;
  final int pinSize = 32;
  Set<String> selectedCategories = <String>{"전체"};
  Function()? reRender;
  RxString selectedSpot = "".obs;

  Rx<UserResponse> userInfo = UserResponse(memberId: 0).obs;
  final RxList<SpotResponse> _spots = <SpotResponse>[].obs;

  RxSet<Marker> get spots => _convertSpots(_spots).obs;
  RxBool shouldSpotsRefresh = false.obs;

  Set<Marker> _convertSpots(List<SpotResponse> spotList) {
    var showSpots = spotList
        .where((spot) => selectedCategories.contains("전체") || selectedCategories.contains(spot.mainCategory)).toList();

    Set<Marker> showMarkers = {};
    Set<SpotResponse> usedSpots = {};

    for(int i = 0; i < showSpots.length; i++) {
      if(usedSpots.where((spot) => spot.memberSpotId == showSpots[i].memberSpotId).isNotEmpty) {
        continue;
      }

      var spot = showSpots[i];
      showMarkers.add(Marker(
          markerId: MarkerId(spot.memberSpotId.toString()),
          position: LatLng(spot.latitude!, spot.longitude!),
          icon: BitmapDescriptor.fromBytes(selectedSpot.value == spot.memberSpotId.toString() ?
          markerImageBytesList[spot.mainCategoryIndex] : pinImageBytesList[spot.mainCategoryIndex]),
          onTap: () => _showSpotBottomSheet(findSameLocationSpots(spotList, spot))
      ));

      findSameLocationSpots(showSpots, spot).forEach((element) {
        usedSpots.add(element);
      });
    }

    return showMarkers;
  }

  List<SpotResponse> findSameLocationSpots(List<SpotResponse> spotList, SpotResponse spot) {
    return spotList.where((cur) => (cur.latitude! - spot.latitude!).abs() < 0.00001).toList();
  }

  void initState(Function() reRender, UserResponse user) {
    this.reRender = reRender;
    userInfo.value = user;
    _setCustomMarker();
  }

  void onCameraMoved() {
    shouldSpotsRefresh.value = true;
  }

  Future<void> _setCustomMarker() async {
    markerImageBytes = await getBytesFromAsset(
        "assets/marker_with_border.png", (50 * pixelRatio.value).toInt());
    markerImageBytesList =
    await Future.wait(SrMarker.markerAssets.map((it) async {
      return await getBytesFromAsset(
          it, (markerSize * pixelRatio.value).toInt());
    }).toList());
    pinImageBytesList = await Future.wait(SrMarker.pinAssets.map((it) async {
      return await getBytesFromAsset(it, (pinSize * pixelRatio.value).toInt());
    }).toList());
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  Future<void> fetchSpots(LatLngBounds latLngBounds) async {
    _spots.value = await spotRepository.getSpotsFromCoordinate(
        userInfo.value.memberId,
        topLatitude: latLngBounds.northeast.latitude,
        topLongitude: latLngBounds.southwest.longitude,
        bottomLatitude: latLngBounds.southwest.latitude,
        bottomLongitude: latLngBounds.northeast.longitude);

    shouldSpotsRefresh.value = false;
  }

  void checkSpotEmpty() {
    if(_spots.isEmpty) {
      Get.dialog(SrDialog(
        icon: SvgPicture.asset("assets/warning.svg"),
        title: "검색 결과가 없습니다",
        description: "다른 지역으로 이동하여 검색해주세요 :)",
        actions: [
          TextButton(onPressed: () => Get.back(), child: Text("완료", style: SrTypography.body2medium.copy(color: SrColors.white),))
        ],
      ));
    }
  }

  void onCategorySelected(Set<String> selected) {
    selectedCategories = selected;
    reRender?.call();
  }

  void _showSpotBottomSheet(List<SpotResponse> spots) {
    selectedSpot.value = spots[0].memberSpotId.toString();
    Get.bottomSheet(SrBottomSheet(
      spots: spots,
      moveDetail: _moveDetail,
    ));
  }

  void _moveDetail(SpotResponse spot) => Get.to(Detail(userId: userInfo.value.memberId, memberSpotId: spot.memberSpotId!));
  void navigateSpotList(LatLngBounds latLngBounds, {Function()? refresh}) async {
    Get.to(SpotList(userId: userInfo.value.memberId,
        topLatitude: latLngBounds.northeast.latitude,
        topLongitude: latLngBounds.southwest.longitude,
        bottomLatitude: latLngBounds.southwest.latitude,
        bottomLongitude: latLngBounds.northeast.longitude))?.then((_) => refresh?.call());
  }
}