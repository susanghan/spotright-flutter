import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotright/presentation/common/colors.dart';

class SrDialog extends StatelessWidget {
  const SrDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20)
      ),
      child: Container(
        width: double.infinity,
        height: 290,
        padding: EdgeInsets.only(top: 32),
        child: Column(children: [
          Container(
              width: 64,
              height: 64,
              margin: EdgeInsets.only(bottom: 12),
              child: SvgPicture.asset("assets/search.svg")),
          Padding(
              padding: EdgeInsets.only(bottom: 12),
              child: Text("부적절한 사용자")),
          Text("사용자를 더이상 보고 싶지 않나요?"),
          Spacer(),
          Container(
            height: 60,
            decoration: BoxDecoration(
              color: SrColors.primary,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20))
            ),
          )
        ]),
      ),
    );
  }
}
