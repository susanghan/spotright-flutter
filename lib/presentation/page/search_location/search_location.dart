import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:spotright/data/spot/location_response.dart';
import 'package:spotright/data/spot/spot_repository.dart';
import 'package:spotright/presentation/component/appbars/default_app_bar.dart';
import 'package:spotright/presentation/component/buttons/sr_cta_button.dart';
import 'package:spotright/presentation/component/divider/sr_divider.dart';
import 'package:spotright/presentation/component/sr_text_field/sr_text_field.dart';
import 'package:spotright/presentation/page/search_location/search_location_controller.dart';

import '../../common/colors.dart';
import '../add_spot/add_spot_controller.dart';

class SearchLocation extends StatefulWidget {
  const SearchLocation({Key? key}) : super(key: key);

  @override
  State<SearchLocation> createState() => _SearchLocationState();
}

class _SearchLocationState extends State<SearchLocation> {
  SpotRepository spotRepository = Get.find();
  SearchLocationController searchLocationController = Get.find();
  AddSpotController addSpotController = Get.find();

  bool isCameraMoving = true;

  @override
  void initState() {
    searchLocationController.initState();
    super.initState();
  }


  Future<void> _changeCountry(BuildContext context) async {
    double screenWidth = MediaQuery.of(context).size.width;

    return showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 30),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: SvgPicture.asset(
                      'assets/delete.svg',
                      color: SrColors.white,
                      width: 28,
                      height: 28,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                searchLocationController.countryState.value =
                                    CountryState.SOUTH_KOREA;
                                Navigator.of(context).pop();
                              },
                              child: SvgPicture.asset(
                                'assets/flag_korea.svg',
                                width: screenWidth * 0.21,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text("한국",
                                style: TextStyle(
                                    decoration: TextDecoration.none,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: SrColors.white))
                          ]),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                searchLocationController.countryState.value =
                                    CountryState.UNITED_STATES;
                                Navigator.of(context).pop();
                              },
                              child: SvgPicture.asset(
                                'assets/flag_usa.svg',
                                width: screenWidth * 0.21,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text("미국",
                                style: TextStyle(
                                    decoration: TextDecoration.none,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: SrColors.white))
                          ]),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                searchLocationController.countryState.value =
                                    CountryState.CANADA;
                                Navigator.of(context).pop();
                              },
                              child: SvgPicture.asset(
                                'assets/flag_canada.svg',
                                width: screenWidth * 0.21,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text("캐나다",
                                style: TextStyle(
                                    decoration: TextDecoration.none,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: SrColors.white))
                          ]),
                    ],
                  ),
                  const SizedBox(
                    height: 28,
                  )
                ]),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: DefaultAppBar(
          title: searchLocationController.userInfo?.value.spotrightId ?? "",
          hasBackButton: true,
        ),
        body: Stack(children: [
          _GoogleMap(),
          _Marker(),
          Padding(
            padding:
                const EdgeInsets.only(left: 16, top: 12, right: 16, bottom: 36),
            child: Column(
              children: [
                _LocationTabBar(),
                const Padding(padding: EdgeInsets.only(bottom: 12)),
                _SearchField(),
                const Padding(padding: EdgeInsets.only(bottom: 4)),
                _ResultList(),
                const Spacer(),
                _UserLocation(),
                _SubmitButton()
              ],
            ),
          ),
        ]),
      ),
    );
  }


  Widget _GoogleMap() {
    return Obx(() => GoogleMap(
      zoomControlsEnabled: false,
      myLocationButtonEnabled: false,
      myLocationEnabled: true,
      mapType: MapType.normal,
      initialCameraPosition: const CameraPosition(
        target: LatLng(37.510181246, 127.043505829),
        zoom: 14.4746,
      ),
      onMapCreated: (GoogleMapController controller) {
        searchLocationController.mapController.complete(controller);
        searchLocationController.currentLocation();
      },
      onCameraMove: (CameraPosition position) {
        isCameraMoving = true;
        searchLocationController.markerPosition.value = position.target;
      },
      onCameraIdle: () {
        isCameraMoving = false;
      },
      markers: {
        Marker(
          markerId: const MarkerId("marker"),
          visible: false,
          position: searchLocationController.markerPosition.value,
          icon: searchLocationController.getMarkerImage(),
        ),
      },
    ));
  }

  Widget _Marker() {
    return Align(
      alignment: Alignment.center,
      child: Padding(
          padding: const EdgeInsets.only(bottom: 50),
          child: SvgPicture.asset(
            "assets/marker_location.svg",
            width: 50,
            height: 50,
          )),
    );
  }

  Widget _LocationTabBar() {
    return Container(
      width: 96,
      height: 32,
      decoration: BoxDecoration(
        color: SrColors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.all(4),
              child: Row(
                children: [
                  Obx(() => InkWell(
                        onTap: () {
                          searchLocationController.queryTypeState.value =
                              QueryTypeState.ADDRESS;
                        },
                        child: AnimatedContainer(
                          width: 44,
                          height: 24,
                          duration: const Duration(milliseconds: 200),
                          decoration: BoxDecoration(
                            color:
                                searchLocationController.queryTypeState.value !=
                                        QueryTypeState.KEYWORD
                                    ? SrColors.primary
                                    : SrColors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                              child: Text(
                            "주소",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: searchLocationController
                                            .queryTypeState.value !=
                                        QueryTypeState.KEYWORD
                                    ? SrColors.white
                                    : SrColors.primary),
                          )),
                        ),
                      )),
                  Obx(() => InkWell(
                        onTap: () {
                          searchLocationController.queryTypeState.value =
                              QueryTypeState.KEYWORD;
                        },
                        child: AnimatedContainer(
                          width: 44,
                          height: 24,
                          decoration: BoxDecoration(
                            color:
                                searchLocationController.queryTypeState.value ==
                                        QueryTypeState.KEYWORD
                                    ? SrColors.primary
                                    : SrColors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          duration: const Duration(milliseconds: 200),
                          child: Center(
                              child: Text(
                            "장소",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: searchLocationController
                                            .queryTypeState.value ==
                                        QueryTypeState.KEYWORD
                                    ? SrColors.white
                                    : SrColors.primary),
                          )),
                        ),
                      )),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _SearchField() {
    return Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(20),
      child: SrTextField(
        height: 36,
        borderRadius: 20,
        hint: "",
        backgroundColor: SrColors.white,
        enableBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(width: 1, color: SrColors.white)),
        focusInputBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(width: 1, color: SrColors.white)),
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 16, right: 12),
          child: GestureDetector(
            onTap: () {
              _changeCountry(context);
            },
            child: Obx(() => SvgPicture.asset(
              searchLocationController.countryImage,
              width: 20,
              height: 20,
            )),
          ),
        ),
        prefixIconConstraints: const BoxConstraints(
            maxWidth: 48, maxHeight: 20, minHeight: 20, minWidth: 48),
        onSubmitted: (String text) {
          if (searchLocationController.queryTypeState.value ==
              QueryTypeState.COORDINATE) {
            searchLocationController.queryTypeState.value =
                QueryTypeState.ADDRESS;
          }
          searchLocationController.searchQuery?.value = text;
          searchLocationController.searchSpot();
        },
      ),
    );
  }

  Widget _Result(LocationResponse spot, int index) {
    String _fullAddress =
        searchLocationController.spots.value[index].fullAddress ?? "";
    String _spotName = searchLocationController.spots.value[index].name ?? "";
    return InkWell(
      onTap: () async {
        searchLocationController.markerPosition.value = LatLng(
            spot.latitude ??
                searchLocationController.markerPosition.value.latitude,
            spot.longitude ??
                searchLocationController.markerPosition.value.longitude);

        searchLocationController.moveMap;

        addSpotController.spotName.value = spot.name ?? "";
        addSpotController.province.value = spot.province ?? "";
        addSpotController.city.value = spot.city ?? "";
        addSpotController.address.value = spot.address ?? "";
      },
      child: Container(
        padding: EdgeInsets.only(left: 16),
        height: 58,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _spotName.isNotEmpty ? _spotName : _fullAddress,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: SrColors.black),
            ),
            Padding(padding: EdgeInsets.only(bottom: 4)),
            Text(
              _fullAddress,
              style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 12,
                  color: SrColors.gray1),
            ),
          ],
        ),
      ),
    );
  }

  Widget _ResultList() {
    return Align(
      alignment: Alignment.centerLeft,
      child: RawScrollbar(
        thickness: 6,
        thumbVisibility: true,
        thumbColor: SrColors.gray2,
        radius: const Radius.circular(10),
        trackVisibility: false,
        //trackColor: SrColors.error,
        //trackRadius: Radius.circular(10),
        //trackBorderColor: SrColors.success,
        interactive: true,
        fadeDuration: const Duration(seconds: 1),
        timeToFade: const Duration(seconds: 1),
        mainAxisMargin: 10,
        crossAxisMargin: 16,
        child: Obx(() => Container(
              height: searchLocationController.spots.length > 5
                  ? 352
                  : searchLocationController.spots.isNotEmpty
                      ? searchLocationController.spots.length * 59 + 4
                      : 0,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: SrColors.white),
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: ListView.separated(
                  itemCount: searchLocationController.spots.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _Result(searchLocationController.spots[index], index);
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      SrDivider(
                        height: 1,
                      )),
            )),
      ),
    );
  }

  Widget _UserLocation() {
    return GestureDetector(
      onTap: () {
        searchLocationController.currentLocation();
      },
      child: Align(
        alignment: Alignment.centerRight,
        child: Container(
          width: 44,
          height: 44,
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100), color: SrColors.gray9e),
          child: SvgPicture.asset(
            "assets/my_location.svg",
            color: SrColors.white,
            fit: BoxFit.scaleDown,
          ),
        ),
      ),
    );
  }

  Widget _SubmitButton() {
    return SrCTAButton(
      text: "완료",
      isEnabled: true,
      action: () {
        //Todo: 좌표로 설정 다시 하기ㅎ
        /*
        if (!isCameraMoving) {
          searchLocationController.queryTypeState.value = QueryTypeState.COORDINATE;
          searchLocationController.searchSpot();
          print(
              "좌표로 검색${searchLocationController.spots.length}");
          addSpotController.spotName.value =
              searchLocationController.searchQuery?.value ?? "";

        }
        */

        Navigator.of(context).pop();
      },
    );
  }
}
