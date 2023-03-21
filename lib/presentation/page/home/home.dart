import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:logger/logger.dart';
import 'package:spotright/presentation/common/colors.dart';
import 'package:spotright/presentation/common/controller/map_controller.dart';
import 'package:spotright/presentation/common/controller/navigation_controller.dart';
import 'package:spotright/presentation/common/typography.dart';
import 'package:spotright/presentation/component/appbars/appbar_title.dart';
import 'package:spotright/presentation/component/appbars/default_app_bar.dart';
import 'package:spotright/presentation/component/appbars/sr_app_bar.dart';
import 'package:spotright/presentation/page/home/home_controller.dart';
import 'package:spotright/presentation/page/register_spot/register_spot.dart';
import 'package:spotright/presentation/page/search/search.dart';

import '../register_spot/register_spot_controller.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with WidgetsBindingObserver {
  Completer<GoogleMapController> _mapController = Completer();
  HomeController homeController = Get.find();
  NavigationController navigationController = Get.find();
  MapController mapController = MapController();
  Logger logger = Get.find();

  @override
  void initState() {
    _initState();
    super.initState();
  }

  Future<void> _initState() async {
    await homeController.initState();
    mapController.initState(() => {setState(() {})}, homeController.userInfo.value);
    _fetchRegionSpots();
  }

  void _fetchRegionSpots() async {
    var region = await _getRegion();
    mapController.fetchSpots(region);
  }

  void _refreshSpots() async {
    var region = await _getRegion();
    await mapController.fetchSpots(region);
    mapController.checkSpotEmpty();
  }

  Future<LatLngBounds> _getRegion() async {
    final GoogleMapController controller = await _mapController.future;
    return await controller.getVisibleRegion();
  }

  //Todo : Get.locale 함수로 언어 설정 받아와서 추후에 수도로 찍어주기
  Future<void> _moveCurrentPosition() async {
    // LatLng(37.510181246, 127.043505829) // 강남 좌표
    var currentPosition = await _getCurrentPosition();
    _moveCameraPosition(currentPosition);
  }

  Future<void> _moveCameraPosition(LatLng target) async {
    final GoogleMapController controller = await _mapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      bearing: 0,
      target: target,
      zoom: 17.0,
    )));
  }

  Future<LatLng> _getCurrentPosition() async {
    var location = Location();
    LocationData? currentLocation = await location.getLocation();
    return LatLng(currentLocation.latitude!, currentLocation.longitude!);
  }

  @override
  Widget build(BuildContext context) {
    mapController.pixelRatio.value = MediaQuery.of(context).devicePixelRatio;

    return SafeArea(
      child: Scaffold(
        appBar: DefaultAppBar(
            titleWidget: Obx(() => AppbarTitle(title: homeController.userInfo.value.spotrightId ?? "")),
          actions: [
            GestureDetector(
              onTap: navigationController.navigatePage(Search(), initState),
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
            markers: mapController.spots,
            mapType: MapType.normal,
            onCameraIdle: mapController.onCameraMoved,
            initialCameraPosition: CameraPosition(
              target: LatLng(37.510181246, 127.043505829),
              zoom: 14.4746,
            ),
            onMapCreated: (GoogleMapController controller) {
              _mapController.complete(controller);
              _moveCurrentPosition();
            },
          )),
          Obx(() => SrAppBar(
            initState: homeController.initState,
            userName: homeController.userInfo.value.nickname ?? "",
            fetchRegionSpots: _refreshSpots,
            shouldRefresh: mapController.shouldSpotsRefresh.value,
            user: homeController.userInfo.value,
            onCategorySelected: mapController.onCategorySelected,
            moveSpotList: () => mapController.navigateSpotList(LatLngBounds(
              northeast: LatLng(90, 179.999999),
              southwest: LatLng(0, -180),
            ), refresh: homeController.initState),
          )),
          GestureDetector(
            onTap: () async {
              var region = await _getRegion();
              mapController.navigateSpotList(region);
            },
            child: Container(
              width: 114,
              height: 35,
              margin: EdgeInsets.only(bottom: 40),
              child: Material(
                elevation: 4,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100)),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Padding(
                      padding: EdgeInsets.only(right: 9),
                      child: Icon(Icons.menu, color: SrColors.gray1,)),
                  Text(
                    '목록보기',
                    style: SrTypography.body2medium.copy(color: SrColors.gray1),
                  ),
                ]),
              ),
            ),
          ),
          Container(
            alignment: Alignment.bottomRight,
            height: 172,
            margin: EdgeInsets.only(right: 16, bottom: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () => homeController.navigateRegisterSpot(RegisterSpot(pageMode: PageMode.add), _moveCameraPosition, _initState),
                  child: Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: SrColors.primary,
                        boxShadow: [
                          BoxShadow(color: Colors.grey.withOpacity(0.7),
                            spreadRadius: 0,
                            blurRadius: 5.0,
                            offset: Offset(0, 3.5), )
                        ]),
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
                    _moveCurrentPosition();
                  },
                  child: Container(
                    width: 56,
                    height: 56,
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
                      fit : BoxFit.scaleDown
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
