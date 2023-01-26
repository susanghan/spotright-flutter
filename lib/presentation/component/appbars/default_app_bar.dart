import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/colors.dart';

class DefaultAppBar extends StatelessWidget with PreferredSizeWidget {
  const DefaultAppBar(
      {Key? key,
      required this.title,
      this.hasBackButton = false,
      this.actions = const []})
      : super(key: key);

  final String title;
  final bool hasBackButton;
  final List<Widget> actions;

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
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(40);
}
