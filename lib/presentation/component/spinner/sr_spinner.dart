import 'package:flutter/material.dart';
import 'package:spotright/presentation/common/colors.dart';

class SrSpinner extends StatelessWidget {
  const SrSpinner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 54,
      child: Stack(
        alignment: Alignment.center,
          children: [
        PageView.builder(
          scrollDirection: Axis.vertical,
          itemCount: 10,
          controller: PageController(viewportFraction: 0.3),
          itemBuilder: (_, i) => _buildItem("200$i"),
        ),
        Column(
          children: [
            Container(
              width: 54,
              height: 1,
              margin: EdgeInsets.only(top: 24),
              color: SrColors.primary,
            ),
            Container(
              width: 54,
              height: 1,
              margin: EdgeInsets.only(top: 32),
              color: SrColors.primary,
            ),
          ],
        )
      ]),
    );
  }

  Widget _buildItem(String text) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: 4),
        child: Text(text));
  }
}
