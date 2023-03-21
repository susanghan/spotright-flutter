import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../common/colors.dart';

class DefaultAppBar extends StatelessWidget with PreferredSizeWidget {
  DefaultAppBar(
      {Key? key,
      this.title = "",
      this.hasBackButton = false,
      this.actions = const [],
        this.titleWidget,
      })
      : super(key: key);

  final String title;
  final bool hasBackButton;
  final List<Widget> actions;
  Widget? titleWidget;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: hasBackButton
          ? IconButton(
              icon: SvgPicture.asset("assets/arrow_back.svg"),
              iconSize: 20,
              onPressed: () {
                Get.back();
              },
            )
          : SizedBox.shrink(),
      backgroundColor: SrColors.white,
      title: titleWidget ?? Text(
        title,
        style: const TextStyle(color: SrColors.black, fontSize: 20, fontWeight: FontWeight.w500),
      ),
      centerTitle: true,
      elevation: 0,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56);
}
