import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:spotright/data/spot/location_request.dart';
import 'package:spotright/data/spot/location_response.dart';
import 'package:spotright/data/spot/spot_repository.dart';
import '../../../data/resources/geo.dart';
import '../../../data/user/user_repository.dart';
import '../../../data/user/user_response.dart';
import 'dart:ui' as ui;

import '../../../data/resources/enum_country.dart';
import '../register_spot/register_spot.dart';

class SearchLocationController extends GetxController {
  final SpotRepository spotRepository = Get.find();
  Completer<GoogleMapController> mapController = Completer();

  void initState() {
    mapController = Completer();
    userInfo = Rx<UserResponse>(userRepository.userResponse!);
    setCustomMarker();
    countryState.value = Country.SOUTH_KOREA;
    isLoadedMarkerImage = false.obs;
    markerPosition.value = LatLng(37.510181246, 127.043505829);
    queryTypeState.value = QueryTypeState.KEYWORD;
    searchQuery.value = "";
    spots.value = <LocationResponse>[];

    spots.value = [];
  }

  //***user 정보
  UserRepository userRepository = Get.find();
  Rx<UserResponse>? userInfo;

  //***국가 설정
  var countryState = Country.SOUTH_KOREA.obs;

  //***마커 설정
  //Todo: png 방법이 이상 없으면 날려 버릴 것임. 웬만해서는 남겨두고 실험할 것
  Uint8List? markerImageBytes;
  double pixelRatio = 2.625;
  RxBool isLoadedMarkerImage = false.obs;

  //Todo : 나라별 기본 값 만들기
  Rx<LatLng> markerPosition = LatLng(37.510181246, 127.043505829).obs;

  //**검색창
  var queryTypeState = QueryTypeState.ADDRESS.obs;
  RxString searchQuery = "".obs;

  //***검색 결과
  RxList<LocationResponse> spots = <LocationResponse>[].obs;

  Future<LatLng> currentLocation() async {
    final GoogleMapController controller = await mapController.future;
    LocationData? currentLocation;
    var location = Location();

    try {
      currentLocation = await location.getLocation();
      controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        bearing: 0,
        target: LatLng(currentLocation.latitude!, currentLocation.longitude!),
        zoom: 17.0,
      )));
      return LatLng(currentLocation.latitude!, currentLocation.longitude!);
    } on Exception {
      currentLocation = null;
      //Todo : Get.locale 함수로 언어 설정 받아와서 추후에 수도로 찍어주기
      return const LatLng(37.510181246, 127.043505829);
    }
  }

  String get countryImage {
    if (countryState.value == Country.SOUTH_KOREA) {
      return 'assets/flag_korea.svg';
    }
    if (countryState.value == Country.UNITED_STATES) {
      return 'assets/flag_usa.svg';
    }
    if (countryState.value == Country.CANADA) {
      return 'assets/flag_canada.svg';
    }
    return 'assets/flag_korea.svg';
  }

  void setCustomMarker() async {
    markerImageBytes = await getBytesFromAsset(
        "assets/marker_with_border.png", (50 * pixelRatio).toInt());
    isLoadedMarkerImage.value = true;
  }

  BitmapDescriptor getMarkerImage() {
    setCustomMarker();

    if (isLoadedMarkerImage.isFalse) return BitmapDescriptor.defaultMarker;
    return BitmapDescriptor.fromBytes(markerImageBytes!);
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

  Future<void> searchSpot() async {
    LocationRequest req = LocationRequest(
        country: describeEnum(countryState.value).toString(),
        latitude: queryTypeState.value == QueryTypeState.COORDINATE
            ? markerPosition.value.latitude
            : null,
        longitude: queryTypeState.value == QueryTypeState.COORDINATE
            ? markerPosition.value.longitude
            : null,
        queryType: describeEnum(queryTypeState.value).toString(),
        searchQuery: searchQuery.value);

    spots.value = await spotRepository.searchSpot(req);

  }

  String? unifyGeo(String? province) {
    String _province;
    if(countryState.value == Country.SOUTH_KOREA && province != null){
      _province = Geo.SOUTH_KOREA.keys.where((element) => element.contains(province)).join();
      if(_province.isNotEmpty){

        return _province;
      }
      else {
        return province;
      }
    }
    return province;
  }

  Future<void> submitClicked(bool isCameraMoving, bool isMoveByHuman) async {
    if(!isCameraMoving && !isMoveByHuman){
      queryTypeState.value = QueryTypeState.COORDINATE;
      await searchSpot();


      searchQuery.value.isNotEmpty ? registerSpotController.spotNameController.text = searchQuery.value : "";
      registerSpotController.provinceController.text = unifyGeo(spots[0].province) ?? "";
      registerSpotController.cityController.text = spots[0].city ?? "";
      registerSpotController.addressController.text = spots[0].address ?? "";

      searchQuery.value.isNotEmpty ? registerSpotController.spotnameText.value = searchQuery.value : "";
      registerSpotController.provinceText.value = unifyGeo(spots[0].province) ?? "";
      registerSpotController.cityText.value = spots[0].city ?? "";
      registerSpotController.addressText.value = spots[0].address ?? "";

    }

  }

  void get moveMap async {
    final GoogleMapController controller = await mapController.future;
    CameraPosition position = CameraPosition(
        target: LatLng(
            markerPosition.value.latitude, markerPosition.value.longitude),
        zoom: 17.0);
    controller.animateCamera(CameraUpdate.newCameraPosition(position));
    spots.value = [];
  }

}


enum QueryTypeState {
  ADDRESS,
  KEYWORD,
  COORDINATE,
}
