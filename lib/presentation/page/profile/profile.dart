import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:spotright/data/user/user_response.dart';
import 'package:spotright/presentation/common/colors.dart';
import 'package:spotright/presentation/component/appbars/appbar_title.dart';
import 'package:spotright/presentation/component/appbars/default_app_bar.dart';
import 'package:spotright/presentation/component/appbars/sr_app_bar.dart';
import 'package:spotright/presentation/page/profile/profile_controller.dart';
import 'package:spotright/presentation/page/search/search.dart';
import 'package:spotright/presentation/page/spot_list/spot_list.dart';

class Profile extends StatefulWidget {
  Profile({Key? key, required this.user}) : super(key: key);

  UserResponse user;

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Completer<GoogleMapController> _mapController = Completer();
  late ProfileController profileController = Get.put(ProfileController());

  @override
  void initState() {
    super.initState();
    profileController.fetchProfileInfo(widget.user.memberId);
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
    return SafeArea(
      child: Scaffold(
        appBar: DefaultAppBar(
            titleWidget: Obx(() => AppbarTitle(title: profileController.user.value.spotrightId ?? "")),
            hasBackButton: true,
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
          GoogleMap(
            zoomControlsEnabled: false,
            myLocationButtonEnabled: false,
            myLocationEnabled: true,
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(
              target: LatLng(37.510181246, 127.043505829),
              zoom: 14.4746,
            ),
            onMapCreated: (GoogleMapController controller) {
              _mapController.complete(controller);
              _currentLocation();
            },
          ),
          Obx(() => SrAppBar(
            userName: profileController.user.value.nickname ?? "",
            isMyPage: false,
            follow: profileController.follow,
            unfollow: profileController.unFollow,
            isFollow: false,
            block: profileController.block,
            report: profileController.report,
            user: profileController.user.value,
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
            margin: EdgeInsets.only(right: 16, bottom: 72),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Spacer(),
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
