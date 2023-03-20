import 'package:flutter/material.dart';
import 'package:spotright/data/resources/category.dart';
import 'package:spotright/presentation/common/colors.dart';
import 'package:spotright/presentation/component/sr_chip/sr_chip.dart';

class SrChips extends StatelessWidget {
  SrChips(
      {Key? key, this.onCategorySelected, this.selectedCategories = const {}, this.height})
      : super(key: key);

  Function(String, bool)? onCategorySelected;
  Set<String> selectedCategories;
  double? height;

  List<String> chipNames = ["전체", ...SpotCategory.mainCategory];

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: height ?? 40,
        margin: EdgeInsets.only(top: 10),
        child: ListView(
          padding: EdgeInsets.only(left: 16),
          scrollDirection: Axis.horizontal,
          children: List.generate(8, (int index) {
            return Padding(
                padding: EdgeInsets.only(right: 8),
                child: SrChip(
                  borderColor: SrColors.gray4,
                    elevation: 0,
                    name: chipNames[index],
                    color: SrColors.categoryColors[index],
                    selected: selectedCategories.contains(chipNames[index]),
                    onTab: (isSelected) {
                      onCategorySelected?.call(chipNames[index], isSelected);
                    }));
          }),
        ));
  }
}
