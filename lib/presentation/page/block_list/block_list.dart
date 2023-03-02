import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotright/data/user/user_response.dart';
import 'package:spotright/presentation/common/colors.dart';
import 'package:spotright/presentation/common/typography.dart';
import 'package:spotright/presentation/component/appbars/default_app_bar.dart';
import 'package:spotright/presentation/component/buttons/sr_cta_button.dart';
import 'package:spotright/presentation/component/sr_check_box/sr_check_box.dart';
import 'package:spotright/presentation/page/block_list/block_list_controller.dart';

class BlockList extends StatefulWidget {
  const BlockList({Key? key}) : super(key: key);

  @override
  State<BlockList> createState() => _BlockListState();
}

class _BlockListState extends State<BlockList> {
  final BlockListController blockListController =
      Get.put(BlockListController());

  @override
  void initState() {
    super.initState();
    blockListController.fetchBlockedUsers();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: DefaultAppBar(
          title: "차단 사용자 목록",
          hasBackButton: true,
        ),
        body: Obx(() => Column(children: [
              Flexible(
                child: ListView(
                  children: blockListController.blockedUsers
                      .map((user) => _Item(user))
                      .toList(),
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(left: 16, right: 16, bottom: 36),
                  child: SrCTAButton(
                      text: "차단해제", isEnabled: false, action: () {}))
            ])),
      ),
    );
  }

  Widget _Item(UserResponse user) {
    return Container(
      height: 70,
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(children: [
        Padding(
            padding: EdgeInsets.only(right: 12),
            child: SrCheckBox(
              value: false,
              onChanged: (checked) {},
              isRectangle: true,
              size: 16,
            )),
        Padding(
          padding: EdgeInsets.only(right: 22),
          child: CircleAvatar(
            radius: 20,
            backgroundColor: SrColors.gray3,
            backgroundImage: NetworkImage(user.memberPhoto?.photoUrl! ?? ""),
          ),
        ),
        Text(
          user.nickname ?? "",
          style: SrTypography.body2medium,
        )
      ]),
    );
  }
}
