import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:spotright/presentation/common/colors.dart';
import 'package:spotright/presentation/component/sr_appbar/sr_app_bar.dart';
import 'package:spotright/presentation/component/sr_appbar/sr_app_bar_model.dart';

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
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: SrColors.black,
            ),
            onPressed: () {
              Get.back();
            },
          ),
          backgroundColor: SrColors.white,
          title: Text(
            'lalakorea',
            style: TextStyle(color: SrColors.black),
          ),
          centerTitle: true,
          elevation: 0,
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 20),
              child: SvgPicture.asset(
                'assets/search.svg',
                color: SrColors.primary,
                width: 24,
                height: 24,
              ),
            )
          ],
        ),
        floatingActionButton:
            FloatingActionButton.small(onPressed: _currentLocation),
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
          TextButton(
            onPressed: () {},
            child: Text(
              '목록보기',
              style: TextStyle(color: SrColors.black),
            ),
            style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 16),
                backgroundColor: SrColors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100))),
          )
        ]),
      ),
    );
  }
}
