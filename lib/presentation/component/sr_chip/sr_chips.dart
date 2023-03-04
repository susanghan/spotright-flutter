import 'package:flutter/material.dart';
import 'package:spotright/data/resources/category.dart';
import 'package:spotright/presentation/common/colors.dart';
import 'package:spotright/presentation/component/sr_chip/sr_chip.dart';

class SrChips extends StatelessWidget {
  SrChips(
      {Key? key, this.onCategorySelected, this.selectedCategories = const {}})
      : super(key: key);

  Function(String, bool)? onCategorySelected;
  Set<String> selectedCategories;

  List<String> chipNames = ["전체", ...Category.mainCategory];

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 40,
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.only(left: 20),
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: List.generate(8, (int index) {
            return Padding(
                padding: EdgeInsets.only(right: 8),
                child: SrChip(
                  borderColor: SrColors.gray2,
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