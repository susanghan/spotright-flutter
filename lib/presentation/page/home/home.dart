import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return const GoogleMap(
      myLocationButtonEnabled: true,
      myLocationEnabled: true,
      mapType: MapType.normal,
      initialCameraPosition: CameraPosition(
        target: LatLng(37.510181246, 127.043505829),
        zoom: 14.4746,
      ),
    );
  }
}
