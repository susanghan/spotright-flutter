import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:spotright/presentation/common/colors.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(children: [
          const GoogleMap(
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(
              target: LatLng(37.510181246, 127.043505829),
              zoom: 14.4746,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            width: double.infinity,
            height: 200,
            decoration: const BoxDecoration(
                color: SrColors.white,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12))),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: SrColors.black,
                        )),
                    SvgPicture.asset(
                      'assets/search.svg',
                      color: SrColors.primary,
                      width: 24,
                      height: 24,
                    )
                  ],
                ),
                Padding(padding: EdgeInsets.only(bottom: 24)),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 20, right: 40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 64,
                            height: 64,
                            decoration: BoxDecoration(
                                color: SrColors.black,
                                borderRadius: BorderRadius.circular(100)),
                          ),
                          Text('김라라')
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [Text('20'), Text('장소')],
                              ),
                              Column(
                                children: [Text('100'), Text('팔로워')],
                              ),
                              Column(
                                children: [Text('50'), Text('팔로잉')],
                              )
                            ],
                          ),
                          Padding(padding: EdgeInsets.only(bottom: 8)),
                          SizedBox(
                            width: double.infinity,
                            child: TextButton(
                              onPressed: () {},
                              child: Text(
                                '마이페이지',
                                style: TextStyle(
                                  color: SrColors.darkGray,
                                ),
                              ),
                              style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  backgroundColor: SrColors.gray,
                                  minimumSize: Size.fromHeight(24),
                                  fixedSize: Size.fromHeight(24),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(100))),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ]),
      ),
    );
  }
}
