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
            padding: const EdgeInsets.only(left: 16, top: 12, right: 16, bottom: 36),
            child: Column(
              children: [
                SrLocationTabBar(),
                //Todo : prefix 아이콘부터
                SrTextField(height: 36, borderRadius: 20, hint: "공씨네 도시락", backgroundColor: SrColors.white, focusInputBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(width: 1, color: SrColors.white)),),
                Align(
                    child: _UserLocation(), alignment: Alignment.centerRight,),
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
}
