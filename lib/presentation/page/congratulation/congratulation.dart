import 'package:flutter/material.dart';
import 'package:spotright/presentation/common/colors.dart';
import 'package:spotright/presentation/component/buttons/sr_cta_button.dart';

class Congratulation extends StatefulWidget {
  const Congratulation({Key? key}) : super(key: key);

  @override
  State<Congratulation> createState() => _CongratulationState();
}

class _CongratulationState extends State<Congratulation> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: Column(
        children: [
          Container(height: 500,),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            width: double.infinity,
            height: 60,
            child: TextButton(onPressed: () {},
            child: Text("시작하기", style: TextStyle(color: SrColors.white)),
            style: TextButton.styleFrom(
              backgroundColor: SrColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              )
            ),),
          )
        ],
      ),
    ));
  }
}
