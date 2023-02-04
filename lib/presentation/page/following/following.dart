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
      height: 44,
      child: TabBar(
        tabs: [
          Text(
            "팔로워",
            style: TextStyle(fontSize : 17, fontWeight : FontWeight.w600, color: SrColors.black),
          ),
          Text("팔로잉", style:  TextStyle(fontSize : 17, fontWeight : FontWeight.w600, color: SrColors.black)),
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
          margin: EdgeInsets.only(right: 12),
          child: CircleAvatar(
            backgroundColor: SrColors.white,
              radius: 100,
              backgroundImage: NetworkImage("https://picsum.photos/180")),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("dkscjftn", style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15, color: Colors.black),),
            SizedBox(height: 8),
            Text("김철수", style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w300, color: SrColors.gray1),),
          ],
        ),
        Spacer(),
        SizedBox(
          width: 108,
          height: 36,
          child: OutlinedButton(
            onPressed: () {},
            child: isFollower ? Text("삭제", style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15)) : Text("팔로잉", style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),),
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
