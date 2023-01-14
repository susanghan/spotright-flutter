import 'package:flutter/material.dart';
import 'package:spotright/presentation/common/colors.dart';
import 'package:spotright/presentation/component/sr_appbar/default_app_bar.dart';

class Following extends StatefulWidget {
  const Following({Key? key}) : super(key: key);

  @override
  State<Following> createState() => _FollowingState();
}

class _FollowingState extends State<Following> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: DefaultTabController(
      initialIndex: 0,
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
                  decoration: BoxDecoration(
                    color: SrColors.primary
                  ),
                ),
                Text("팔로잉"),
              ]),
            )
          ])),
    ));
  }
}
