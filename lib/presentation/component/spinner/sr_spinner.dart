import 'package:flutter/material.dart';
import 'package:spotright/presentation/common/colors.dart';
import 'package:spotright/presentation/common/typography.dart';

class SrSpinner extends StatelessWidget {
  SrSpinner({Key? key, required this.defaultValue, required this.list, required this.onChanged}) : super(key: key);

  final List<String> list;
  final Function(String current) onChanged;
  String defaultValue;
  int? seletedValue;

  @override
  Widget build(BuildContext context) {
    PageController controller = PageController(initialPage: list.indexOf(defaultValue), viewportFraction: 0.4);

    return Container(
      height: 80,
      width: 53,
      child: Stack(
        alignment: Alignment.center,
          children: [
        PageView.builder(
          scrollDirection: Axis.vertical,
          itemCount: list.length,
          controller: controller,
          itemBuilder: (_, i) => _buildItem(list[i]),
          onPageChanged: (page) {
            seletedValue = page;
            onChanged(list[page]);
          },
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
        child: Text(text, style: SrTypography.body2semi.copy(color: SrColors.gray2),));
  }
}
