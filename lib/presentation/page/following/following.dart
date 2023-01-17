import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotright/presentation/common/colors.dart';
import 'package:spotright/presentation/component/appbars/default_app_bar.dart';
import 'package:spotright/presentation/page/following/following_controller.dart';

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
              child: _TabBar(),
            ),
            Expanded(
              child: TabBarView(children: [
                ListView.builder(
                    padding: EdgeInsets.only(top: 20),
                    itemCount: 10,
                    itemBuilder: (BuildContext context, int index) {
                      return _Profile(true);
                    }),
                ListView.builder(
                  padding: EdgeInsets.only(top: 20),
                    itemCount: 10,
                    itemBuilder: (BuildContext context, int index) {
                      return _Profile(false);
                    })
              ]),
            )
          ])),
    ));
  }

  Widget _TabBar() {
    return Container(
      height: 48,
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: TabBar(
        tabs: [
          Text(
            "팔로워",
            style: TextStyle(color: SrColors.black),
          ),
          Text("팔로잉", style: TextStyle(color: SrColors.black)),
        ],
      ),
    );
  }

  Widget _Profile(bool isFollower) {
    return Container(
      margin: EdgeInsets.fromLTRB(16, 0, 16, 30),
      child: Row(children: [
        Container(
          width: 60,
          height: 60,
          margin: EdgeInsets.only(right: 16),
          child: CircleAvatar(
              radius: 100,
              backgroundImage: NetworkImage("https://picsum.photos/180")),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("dkscjftn"),
            Text("김철수"),
          ],
        ),
        Spacer(),
        SizedBox(
          width: 108,
          height: 36,
          child: OutlinedButton(
            onPressed: () {},
            child: isFollower ? Text("삭제") : Text("팔로잉"),
            style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100)),
                side: BorderSide(color: SrColors.primary)),
          ),
        )
      ]),
    );
  }
}
