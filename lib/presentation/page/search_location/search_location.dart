import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:spotright/presentation/component/appbars/default_app_bar.dart';
import 'package:spotright/presentation/component/buttons/sr_cta_button.dart';
import 'package:spotright/presentation/component/divider/sr_divider.dart';
import 'package:spotright/presentation/component/sr_text_field/sr_text_field.dart';
import 'package:spotright/presentation/page/search_location/search_location_controller.dart';

import '../../common/colors.dart';
import '../../component/sr_location_tab_bar/sr_location_tab_bar.dart';

class SearchLocation extends StatefulWidget {
  const SearchLocation({Key? key}) : super(key: key);

  @override
  State<SearchLocation> createState() => _SearchLocationState();
}

class _SearchLocationState extends State<SearchLocation> {
  Completer<GoogleMapController> _mapController = Completer();
  SearchLocationController searchLocationController = Get.find();

  Future<LatLng> _currentLocation() async {
    final GoogleMapController controller = await _mapController.future;
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: DefaultAppBar(
          title: "${searchLocationController.userInfo?.value.memberId}",
          hasBackButton: true,
        ),
        body: Stack(children: [
          _GoogleMap(),
          Padding(
            padding:
                const EdgeInsets.only(left: 16, top: 12, right: 16, bottom: 36),
            child: Column(
              children: [
                SrLocationTabBar(),
                const Padding(padding: EdgeInsets.only(bottom: 12)),
                //Todo : prefix 아이콘 상태에 따라서 가능하게 컨트롤러 만들어서 컨트롤, 지금은 정적 화면만
                _SearchField(),
                const Padding(padding: EdgeInsets.only(bottom: 4)),
                Align(
                  child: _ResultList(),
                  alignment: Alignment.centerLeft,
                ),
                Spacer(),
                Align(
                  child: _UserLocation(),
                  alignment: Alignment.centerRight,
                ),
                SrCTAButton(
                  text: "완료",
                  isEnabled: true,
                  action: () {},
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }

  Widget _GoogleMap() {
    return GoogleMap(
      zoomControlsEnabled: false,
      myLocationButtonEnabled: false,
      myLocationEnabled: true,
      mapType: MapType.normal,
      initialCameraPosition: const CameraPosition(
        target: LatLng(37.510181246, 127.043505829),
        zoom: 14.4746,
      ),
      onMapCreated: (GoogleMapController controller) {
        _mapController.complete(controller);
        _currentLocation();
      },
    );
  }

  Widget _UserLocation() {
    return GestureDetector(
      onTap: () {
        _currentLocation();
      },
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
    );
  }

  Widget _SearchField() {
    return SrTextField(
      height: 36,
      borderRadius: 20,
      hint: "공씨네 도시락",
      backgroundColor: SrColors.white,
      inputBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          borderSide: BorderSide(width: 1, color: SrColors.white)),
      focusInputBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          borderSide: BorderSide(width: 1, color: SrColors.white)),
      prefixIcon: Padding(
        padding: const EdgeInsets.only(left: 16, right: 12),
        child: SvgPicture.asset(
          'assets/flag_korea.svg',
          width: 20,
          height: 20,
        ),
      ),
      prefixIconConstraints: const BoxConstraints(maxWidth: 48, maxHeight: 20, minHeight: 20, minWidth: 48 ),
    );
  }

  Widget _Result() {
    return Container(
      padding: EdgeInsets.only(left: 16),
      height: 58,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("공씨네 도시락", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: SrColors.black),),
          Padding(padding: EdgeInsets.only(bottom: 4)),
          Text("인천시 연수구 아카데미로 119 인천대학교", style: TextStyle(fontWeight: FontWeight.w300, fontSize: 12, color: SrColors.gray1),),
        ],
      ),
    );
  }

  Widget _ResultList() {
    return RawScrollbar(
      thickness: 6,
      thumbVisibility: true,
      thumbColor: SrColors.gray2,
      radius: Radius.circular(10),
      trackVisibility: false,
      //trackColor: SrColors.error,
      //trackRadius: Radius.circular(10),
      //trackBorderColor: SrColors.success,
      interactive: true,
      fadeDuration: Duration(seconds: 1),
      timeToFade : Duration(seconds: 1),
      mainAxisMargin: 10,
      crossAxisMargin: 16,
      child: Container(
        height: 352,
        width: double.infinity,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: SrColors.white),
        padding: EdgeInsets.symmetric(vertical: 2),
        child: ListView.separated(
            itemCount: 10,
            itemBuilder: (BuildContext context, int index) {
          return _Result();
        }, separatorBuilder: (BuildContext context, int index) => SrDivider(height: 1,)),
      ),
    );
  }
}
