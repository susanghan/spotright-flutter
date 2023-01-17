import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotright/presentation/common/colors.dart';
import 'package:spotright/presentation/component/sr_appbar/default_app_bar.dart';
import 'package:spotright/presentation/page/following/following_controller.dart';
import 'package:spotright/presentation/page/following/following_state.dart';

class Following extends StatefulWidget {
  const Following({Key? key, required this.tabIndex}) : super(key: key);

  final int tabIndex;

  @override
  State<Following> createState() => _FollowingState();
}

class _FollowingState extends State<Following> {
  FollowingController followingController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: DefaultTabController(
      initialIndex: widget.tabIndex,
      length: 2,
      child: Scaffold(
          appBar: DefaultAppBar(
            title: 'id',
            hasBackButton: true,
          ),
          body: Column(children: [
            PreferredSize(
              preferredSize: Size.fromHeight(10),
              child: Container(
                height: 48,
                child: TabBar(
                  tabs: [
                    Text(
                      "팔로워",
                      style: TextStyle(color: SrColors.black),
                    ),
                    Text("팔로잉", style: TextStyle(color: SrColors.black)),
                  ],
                ),
              ),
            ),
            Expanded(
              child: TabBarView(children: [
                Container(
                  child: Text("follower"),
                ),
                Text("팔로잉"),
              ]),
            )
          ])),
    ));
  }
}
