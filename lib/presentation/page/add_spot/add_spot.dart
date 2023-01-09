import 'package:flutter/material.dart';
import 'package:spotright/presentation/component/sr_appbar/default_app_bar.dart';

class AddSpot extends StatefulWidget {
  const AddSpot({Key? key}) : super(key: key);

  @override
  State<AddSpot> createState() => _AddSpotState();
}

class _AddSpotState extends State<AddSpot> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: DefaultAppBar(
            title: "장소추가",
            hasBackButton: true,
          ),
        ));
  }
}
