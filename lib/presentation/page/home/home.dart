import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:spotright/presentation/common/colors.dart';
import 'package:spotright/presentation/component/appbars/default_app_bar.dart';
import 'package:spotright/presentation/component/appbars/sr_app_bar.dart';
import 'package:spotright/presentation/page/add_spot/add_spot.dart';
import 'package:spotright/presentation/page/home/home_controller.dart';
import 'package:spotright/presentation/page/search/search.dart';
import 'package:spotright/presentation/page/spot_list/spot_list.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with WidgetsBindingObserver {
  Completer<GoogleMapController> _mapController = Completer();
  HomeController homeController = Get.find();

  @override
  void initState() {
    super.initState();
    homeController.initState();
    _fetchRegionSpots();
  }

  void _fetchRegionSpots() async {
    final GoogleMapController controller = await _mapController.future;
    var region = await controller.getVisibleRegion();
    homeController.fetchSpots(region);
  }

  Future<LatLng> _currentLocation() async {
    final GoogleMapController controller = await _mapController.future;
    LocationData? currentLocation;
    var location = Location();

    try {
      currentLocation = await location.getLocation();
      controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        bearing: 0,
        target: LatLng(currentLocation.latitude!, currentLocation.longitude!),
        // target: LatLng(37.510181246, 127.043505829),
        zoom: 17.0,
      )));
      return LatLng(currentLocation.latitude!, currentLocation.longitude!);
    } on Exception {
      currentLocation = null;
      //Todo : Get.locale 함수로 언어 설정 받아와서 추후에 수도로 찍어주기
      return LatLng(37.510181246, 127.043505829);
    }
  }

  @override
  Widget build(BuildContext context) {
    homeController.pixelRatio.value = MediaQuery.of(context).devicePixelRatio;

    return SafeArea(
      child: Scaffold(
        appBar: DefaultAppBar(
          title: homeController.userInfo.value.spotrightId ?? "",
          actions: [
            GestureDetector(
              onTap: () {
                Get.to(Search());
              },
              child: Padding(
                padding: EdgeInsets.only(right: 20),
                child: SvgPicture.asset(
                  'assets/search.svg',
                  color: SrColors.primary,
                  width: 24,
                  height: 24,
                ),
              ),
            )
          ]
        ),
        body: Stack(alignment: Alignment.bottomCenter, children: [
          Obx(() => GoogleMap(
            zoomControlsEnabled: false,
            myLocationButtonEnabled: false,
            myLocationEnabled: true,
            markers: homeController.spots,
            mapType: MapType.normal,
            onCameraIdle: homeController.onCameraMoved,
            initialCameraPosition: CameraPosition(
              target: LatLng(37.510181246, 127.043505829),
              zoom: 14.4746,
            ),
            onMapCreated: (GoogleMapController controller) {
              _mapController.complete(controller);
              _currentLocation();
            },
          )),
          Obx(() => SrAppBar(
            userName: homeController.userInfo.value.nickname ?? "",
            fetchRegionSpots: _fetchRegionSpots,
            shouldRefresh: homeController.shouldSpotsRefresh.value,
            user: homeController.userInfo.value,
          )),
          GestureDetector(
            onTap: () {
              Get.to(const SpotList());
            },
            child: Container(
              width: 112,
              height: 36,
              margin: EdgeInsets.only(bottom: 24),
              child: Material(
                elevation: 4,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100)),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Padding(
                      padding: EdgeInsets.only(right: 4),
                      child: Icon(Icons.menu)),
                  Text(
                    '목록보기',
                    style: TextStyle(color: SrColors.black),
                  ),
                ]),
              ),
            ),
          ),
          Container(
            alignment: Alignment.bottomRight,
            height: 172,
            margin: EdgeInsets.only(right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.to(AddSpot());
                  },
                  child: Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: SrColors.primary),
                    child: SvgPicture.asset(
                      "assets/plus.svg",
                      color: SrColors.white,
                      fit: BoxFit.scaleDown,
                    ),
                    margin: EdgeInsets.only(bottom: 12),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _currentLocation();
                  },
                  child: Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: SrColors.gray9e),
                    child: SvgPicture.asset(
                      "assets/my_location.svg",
                      color: SrColors.white,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                )
              ],
            ),
          )
        ]),
      ),
    );
  }
}
