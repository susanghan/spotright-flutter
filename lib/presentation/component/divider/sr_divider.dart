import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spotright/presentation/common/colors.dart';

class SrDivider extends StatelessWidget {
  SrDivider({Key? key, this.height = 1.5, this.color = SrColors.gray4}) : super(key: key);

  double height;
  Color color = SrColors.gray4;

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: height,
      thickness: height,
      color: color,
    );
  }
}
