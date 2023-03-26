import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:spotright/data/spot/spot_response.dart';
import 'package:spotright/presentation/common/colors.dart';
import 'package:spotright/presentation/component/appbars/default_app_bar.dart';

class ShowingLocation extends StatefulWidget {
  ShowingLocation({Key? key,  required this.spot}) : super(key: key);

  SpotResponse spot;

  @override
  State<ShowingLocation> createState() => _ShowingLocationState();
}

class _ShowingLocationState extends State<ShowingLocation> {
  Completer<GoogleMapController> _mapController = Completer();
  Set<Marker> _marker = <Marker>{};

  @override
  void initState() {
    _moveCameraPosition(
        LatLng(
          widget.spot.latitude!,
          widget.spot.longitude!,
        )
    );

    _initMarker();
    super.initState();
  }

  void _initMarker() async {
    // MediaQueryData queryData = MediaQuery.of(context);
    double pixelRatio = 2.625; //queryData.devicePixelRatio;
    Uint8List markerByteImage = await getBytesFromAsset("assets/marker_primary.png", (50 * pixelRatio).toInt());

    setState(() {
      _marker = {
        Marker(
            markerId: MarkerId(widget.spot.memberSpotId.toString()),
            position: LatLng(
              widget.spot.latitude!,
              widget.spot.longitude!,
            ),
          icon: BitmapDescriptor.fromBytes(markerByteImage)
        )
      };
    });
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  Future<void> _moveCurrentPosition() async {
    var currentPosition = await _getCurrentPosition();
    _moveCameraPosition(currentPosition);
  }

  Future<LatLng> _getCurrentPosition() async {
    var location = Location();
    LocationData? currentLocation = await location.getLocation();
    return LatLng(currentLocation.latitude!, currentLocation.longitude!);
  }

  Future<void> _moveCameraPosition(LatLng target) async {
    final GoogleMapController controller = await _mapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      bearing: 0,
      target: target,
      zoom: 17.0,
    )));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: DefaultAppBar(title: widget.spot.spotName ?? '', hasBackButton: true,),
      body: Stack(
        alignment: Alignment.bottomRight,
        children: [
          GoogleMap(
            zoomControlsEnabled: false,
            myLocationButtonEnabled: false,
            myLocationEnabled: true,
            mapType: MapType.normal,
            markers: _marker,
            initialCameraPosition: CameraPosition(
              target: LatLng(37.510181246, 127.043505829),
              zoom: 14.4746,
            ),
            onMapCreated: (GoogleMapController controller) {
              _mapController.complete(controller);
            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 76, horizontal: 16),
            child: GestureDetector(
              onTap: () {
                _moveCurrentPosition();
              },
              child:  Container(
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
          )
        ],
      ),
    ));
  }
}
