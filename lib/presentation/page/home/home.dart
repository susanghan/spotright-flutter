import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:spotright/presentation/component/sr_appbar/sr_app_bar.dart';
import 'package:spotright/presentation/component/sr_appbar/sr_app_bar_model.dart';

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
          SrAppBar(
            srAppBarModel: SrAppBarModel(
              id: 'lalakorea',
              userName: '김라라',
              spots: 20,
              followers: 100,
              followings: 100,
            ),
          )
        ]),
      ),
    );
  }
}
