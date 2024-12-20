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
import '../../../data/resources/enum_country.dart';
import '../register_spot/register_spot_controller.dart';

class SearchLocation extends StatefulWidget {
  const SearchLocation({Key? key}) : super(key: key);

  @override
  State<SearchLocation> createState() => _SearchLocationState();
}

class _SearchLocationState extends State<SearchLocation> {
  SpotRepository spotRepository = Get.find();
  SearchLocationController searchLocationController = Get.find();
  RegisterSpotController registerSpotController = Get.find();

  bool isCameraMoving = true;
  bool isResultSelected = false;
  bool isMoveByHuman = false;

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
                                    Country.SOUTH_KOREA;
                                registerSpotController.countryState.value = Country.SOUTH_KOREA;
                                registerSpotController.setSearchProvinceList();
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
                                    Country.UNITED_STATES;
                                registerSpotController.countryState.value = Country.UNITED_STATES;
                                registerSpotController.setSearchProvinceList();
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
                                    Country.CANADA;
                                registerSpotController.countryState.value = Country.CANADA;
                                registerSpotController.setSearchProvinceList();
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
                const Padding(padding: EdgeInsets.only(bottom: 16)),
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

        if (isMoveByHuman) {isResultSelected = false; isMoveByHuman = false;}
      },
      onCameraIdle: () {
        isCameraMoving = false;

        if (isResultSelected) {isMoveByHuman = true;}
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
            "assets/marker_primary.svg",
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
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _SearchField() {
    return Obx(()=>SrTextField(
      height: 47,
      borderRadius: 22,
      textInputAction: TextInputAction.search,
      hint: searchLocationController.queryTypeState.value == QueryTypeState.ADDRESS ? "검색할 주소를 입력하세요" : "검색할 장소를 입력하세요",
      boxShadow: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: SrColors.gray3.withOpacity(0.7),
            blurRadius: 5.0,
            spreadRadius: 0.0,
            offset: const Offset(0, 4),
          )
        ],
        borderRadius: BorderRadius.all(Radius.circular(22)),
      ),
      backgroundColor: SrColors.white,
      enableBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(22)),
          borderSide: BorderSide(width: 1, color: SrColors.white)),
      focusInputBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(22)),
          borderSide: BorderSide(width: 1, color: SrColors.white)),
      prefixIcon: Padding(
        padding: const EdgeInsets.only(left: 12, bottom: 3, right: 8),
        child: GestureDetector(
          onTap: () {
            _changeCountry(context);
          },
          child: Obx(() => SvgPicture.asset(
            searchLocationController.countryImage,
            width: 24,
            height: 24,

          )),
        ),
      ),
      prefixIconConstraints: const BoxConstraints(
          maxWidth: 44, maxHeight: 44, minHeight: 24, minWidth: 24),
      onSubmitted: (String text) {
        if (searchLocationController.queryTypeState.value ==
            QueryTypeState.COORDINATE) {
          searchLocationController.queryTypeState.value =
              QueryTypeState.ADDRESS;
        }
        searchLocationController.searchQuery.value = text;
        searchLocationController.searchSpot();
      },
    ));
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

        registerSpotController.spotNameController.text = spot.name ?? "";
        registerSpotController.provinceController.text = searchLocationController.unifyGeo(spot.province) ?? "";
        registerSpotController.cityController.text = spot.city ?? "";
        registerSpotController.addressController.text = spot.address ?? "";

        registerSpotController.spotnameText.value = spot.name ?? "";
        registerSpotController.provinceText.value = searchLocationController.unifyGeo(spot.province) ?? "";
        registerSpotController.cityText.value = spot.city ?? "";
        registerSpotController.addressText.value = spot.address ?? "";

        isResultSelected= true;
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
                  borderRadius: BorderRadius.circular(20), color: SrColors.white,
                  boxShadow: [BoxShadow(
                    color: SrColors.gray3.withOpacity(0.7),
                    blurRadius: 5.0,
                    spreadRadius: 0.0,
                    offset: const Offset(0, 4),
                  )]),
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
          width: 56,
          height: 56,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: SrColors.gray9e,
              boxShadow: [
                BoxShadow(color: Colors.grey.withOpacity(0.7),
                  spreadRadius: 0,
                  blurRadius: 5.0,
                  offset: Offset(0, 3.5), )
              ]
          ),
          child: SvgPicture.asset(
            "assets/my_location.svg",
            color: SrColors.white,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }

  Widget _SubmitButton() {
    return SrCTAButton(
      text: "완료",
      isEnabled: true,
      action: () async {
        print("완료 버튼 상태");
        print(isResultSelected);
        searchLocationController.submitClicked(isCameraMoving, isMoveByHuman);

        Navigator.of(context).pop();
      },
    );
  }
}
