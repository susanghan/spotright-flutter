import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotright/presentation/common/colors.dart';
import 'package:spotright/presentation/common/typography.dart';

class Inspection extends StatefulWidget {
  const Inspection({Key? key}) : super(key: key);

  @override
  State<Inspection> createState() => _InspectionState();
}

class _InspectionState extends State<Inspection> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 220, bottom: 32),
                child: SvgPicture.asset("assets/bulb_inspection.svg", width: 150, height: 150,)
            ),
            Padding(
                padding: EdgeInsets.only(bottom: 16),
                child: Text("앱 점검중입니다", style: SrTypography.title2bold.copy(color: SrColors.primary),)),
            Text("Spotright 점검시간입니다", style: SrTypography.body2medium.copy(color: SrColors.gray1),),
            Text("점검이 끝날 때까지 조금만 기다려주세요", style: SrTypography.body2medium.copy(color: SrColors.gray1),),
          ],
        ),
      ),
    ));
  }
}
