import 'dart:ffi';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../data/user/user_repository.dart';
import '../../../data/user/user_response.dart';
import 'dart:ui' as ui;

class SearchLocationController extends GetxController{
  //user 정보
  UserRepository userRepository = Get.find();
  Rx<UserResponse>? userInfo;
  void initState() {
    userInfo = Rx<UserResponse>(userRepository.userResponse!);
    setCustomMarker();
  }

  //국가 설정
  var countryState = CountryState.SOUTH_KOREA.obs;

  String get countryImage {
    if(countryState.value == CountryState.SOUTH_KOREA) return 'assets/flag_korea.svg';
    if(countryState.value == CountryState.UNITED_STATES) return 'assets/flag_usa.svg';
    if(countryState.value == CountryState.CANADA) return 'assets/flag_canada.svg';
    return 'assets/flag_korea.svg';
  }

  //마커 설정
  //Todo: png 방법이 이상 없으면 날려 버릴 것임.
  Uint8List? markerImageBytes;
  RxBool isLoadedMarkerImage = false.obs;
  double pixelRatio = 2.625;

  void setCustomMarker() async {
    markerImageBytes = await getBytesFromAsset("assets/marker_with_border.png", (50 * pixelRatio).toInt());
    isLoadedMarkerImage.value = true;
  }

  BitmapDescriptor getMarkerImage() {
    setCustomMarker();

    if(isLoadedMarkerImage.isFalse) return BitmapDescriptor.defaultMarker;
    return BitmapDescriptor.fromBytes(markerImageBytes!);
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }

  Rx<LatLng> markerPosition = LatLng(37.510181246, 127.043505829).obs;

}

enum CountryState{
  CANADA,
  SOUTH_KOREA,
  UNITED_STATES
}

enum QueryTypeState{
  ADDRESS,
  COORDINATE,
  KEYWORD
}