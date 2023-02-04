import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spotright/presentation/common/colors.dart';

class SrChipReadOnly extends StatelessWidget {
  SrChipReadOnly({
    Key? key,
    required this.categoryKind,
    required this.categoryName,
  }) : super(key: key);

  CategoryKind categoryKind = CategoryKind.mainCategory;
  String? categoryName;
  Color categoryColor = SrColors.restaurant;
  TextStyle mainCategoryTextStyle = const TextStyle(
      fontSize: 12, fontWeight: FontWeight.w500, color: SrColors.white);
  TextStyle subCategoryTextStyle = const TextStyle(
      fontSize: 12, fontWeight: FontWeight.w500, color: SrColors.restaurant);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [OutlinedButton(
        onPressed: () {},
        style: OutlinedButton.styleFrom(
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            backgroundColor: categoryKind == CategoryKind.mainCategory ? categoryColor : SrColors.white,
            side: BorderSide(width: 1.5, color: SrColors.restaurant),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            padding: EdgeInsets.zero,
            maximumSize: categoryName != null ? Size(50, 23) : Size(0, 0),
            minimumSize: categoryName != null ? Size(50, 23) : Size(0, 0),),
        child: Text(
          categoryName ?? "",
          style: categoryKind == CategoryKind.mainCategory ? mainCategoryTextStyle : subCategoryTextStyle,
        ),
      ),]
    );
  }
}

enum CategoryKind { mainCategory, subCategory }
