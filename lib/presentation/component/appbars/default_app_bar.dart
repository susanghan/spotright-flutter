import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:spotright/presentation/page/search/search.dart';

import '../../common/colors.dart';

class DefaultAppBar extends StatelessWidget with PreferredSizeWidget {
  const DefaultAppBar(
      {Key? key,
      required this.title,
      this.hasSearch = false,
      this.hasBackButton = false})
      : super(key: key);

  final String title;
  final bool hasSearch;
  final bool hasBackButton;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: hasBackButton
          ? IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: SrColors.black,
              ),
              onPressed: () {
                Get.back();
              },
            )
          : SizedBox.shrink(),
      backgroundColor: SrColors.white,
      title: Text(
        title,
        style: TextStyle(color: SrColors.black),
      ),
      centerTitle: true,
      elevation: 0,
      actions: [
        hasSearch
            ? GestureDetector(
                onTap: () {
                  Get.to(Search());
                },
                child: Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: SvgPicture.asset(
                    'assets/search.svg',
                    color: SrColors.primary,
                    width: 24,
                    height: 24,
                  ),
                ),
              )
            : SizedBox.shrink()
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(40);
}
