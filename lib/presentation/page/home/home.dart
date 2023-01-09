import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:spotright/presentation/common/colors.dart';
import 'package:spotright/presentation/component/sr_appbar/default_app_bar.dart';
import 'package:spotright/presentation/component/sr_appbar/sr_app_bar.dart';
import 'package:spotright/presentation/component/sr_appbar/sr_app_bar_model.dart';
import 'package:spotright/presentation/page/add_spot/add_spot.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Completer<GoogleMapController> _mapController = Completer();

  // todo: 지도 내 현재 위치에 마커 찍어주기
  void _currentLocation() async {
    final GoogleMapController controller = await _mapController.future;
    LocationData? currentLocation;
    var location = Location();

    try {
      currentLocation = await location.getLocation();
    } on Exception {
      currentLocation = null;
      return;
    }

    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      bearing: 0,
      target: LatLng(currentLocation.latitude!, currentLocation.longitude!),
      zoom: 17.0,
    )));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: DefaultAppBar(title: 'lalakorea', hasSearch: true,),
        body: Stack(alignment: Alignment.bottomCenter, children: [
          GoogleMap(
            zoomControlsEnabled: false,
            myLocationEnabled: true,
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(
              target: LatLng(37.510181246, 127.043505829),
              zoom: 14.4746,
            ),
            onMapCreated: (GoogleMapController controller) {
              _mapController.complete(controller);
            },
          ),
          SrAppBar(
            srAppBarModel: SrAppBarModel(
              userName: '김라라',
              spots: 20,
              followers: 100,
              followings: 100,
            ),
          ),
          Container(
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
                Container(
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
                )
              ],
            ),
          )
        ]),
      ),
    );
  }
}
