import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotright/data/user/user_response.dart';
import 'package:spotright/presentation/common/colors.dart';
import 'package:spotright/presentation/common/controller/navigation_controller.dart';
import 'package:spotright/presentation/common/typography.dart';
import 'package:spotright/presentation/component/appbars/default_app_bar.dart';
import 'package:spotright/presentation/page/following/following_controller.dart';
import 'package:spotright/presentation/page/profile/profile.dart';

class Following extends StatefulWidget {
  const Following({Key? key, required this.tabIndex, required this.user}) : super(key: key);

  final int tabIndex;
  final UserResponse user;

  @override
  State<Following> createState() => _FollowingState();
}

class _FollowingState extends State<Following> {
  FollowingController followingController = Get.put(FollowingController());
  NavigationController navigationController = Get.find();

  @override
  void initState() {
    followingController.initState(widget.tabIndex, widget.user);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: DefaultTabController(
      initialIndex: widget.tabIndex,
      length: 2,
      child: Scaffold(
          appBar: DefaultAppBar(
            title: followingController.user.value.spotrightId ?? "id",
            hasBackButton: true,
          ),
          body: Column(children: [
            PreferredSize(
              preferredSize: Size.fromHeight(10),
              child: _TabBar(),
            ),
            Expanded(
              child: Obx(() => TabBarView(children: [
                ListView.builder(
                    padding: EdgeInsets.only(top: 20),
                    itemCount: followingController.followers.length,
                    itemBuilder: (BuildContext context, int index) {
                      return _Profile(followingController.followers[index], true);
                    }),
                ListView.builder(
                    padding: EdgeInsets.only(top: 20),
                    itemCount: followingController.followings.length,
                    itemBuilder: (BuildContext context, int index) {
                      return _Profile(followingController.followings[index], false);
                    })
              ])),
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
          Text("팔로잉 ", style:  TextStyle(fontSize : 17, fontWeight : FontWeight.w600, color: SrColors.black)),
        ],
      ),
    );
  }

  Widget _Profile(UserResponse user, bool isFollower) {
    ImageProvider profilePhoto =
      user.memberPhoto?.photoUrl != null ?
      NetworkImage(user.memberPhoto?.photoUrl! ?? "")
          : AssetImage("assets/user_profile_default_small.png") as ImageProvider;

    return GestureDetector(
      onTap: navigationController.navigatePage(Profile(user: user,), initState),
      child: Container(
        color: SrColors.white,
        margin: EdgeInsets.fromLTRB(16, 0, 16, 30),
        child: Row(children: [
          Container(
            width: 60,
            height: 60,
            margin: EdgeInsets.only(right: 12),
            child: CircleAvatar(
              backgroundColor: SrColors.white,
                radius: 100,
                backgroundImage: profilePhoto),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(user.spotrightId ?? "", style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15, color: Colors.black),),
              SizedBox(height: 8),
              Text(user.nickname ?? "", style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w300, color: SrColors.gray1),),
            ],
          ),
          Spacer(),
          if(followingController.isMyPage.value) SizedBox(
            width: 108,
            height: 36,
            child: OutlinedButton(
              onPressed: isFollower ? followingController.removeFollower(user.memberId) : followingController.unfollow(user.memberId),
              child: Text(isFollower ? "삭제" : "팔로우 취소", style: SrTypography.body2semi.copy(color: SrColors.primary),),
              style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100)),
                  side: BorderSide(color: SrColors.primary)),
            ),
          )
        ]),
      ),
    );
  }
}
