import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:spotright/data/user/user_response.dart';
import 'package:spotright/presentation/common/colors.dart';
import 'package:spotright/presentation/common/typography.dart';
import 'package:spotright/presentation/component/appbars/report_options.dart';
import 'package:spotright/presentation/component/dialog/report_dialog.dart';
import 'package:spotright/presentation/component/dialog/sr_dialog.dart';
import 'package:spotright/presentation/component/sr_chip/sr_chip.dart';
import 'package:spotright/presentation/page/following/following.dart';
import 'package:spotright/presentation/page/my_page/my_page.dart';

class SrAppBar extends StatefulWidget {
  SrAppBar({
    Key? key,
    this.userName = '',
    this.isMyPage = true,
    this.follow,
    this.unfollow,
    this.isFollowing = false,
    this.block,
    this.report,
    this.shouldRefresh = false,
    this.fetchRegionSpots,
    required this.user,
    this.onCategorySelected,
    this.moveSpotList,
  }) : super(key: key);

  UserResponse user;
  String userName;
  bool isFollowing;
  bool isMyPage;
  Function()? follow;
  Function()? unfollow;
  Function()? block;
  Function(String, String)? report;
  bool shouldRefresh = false;
  Function()? fetchRegionSpots;
  Function(Set<String> selected)? onCategorySelected;
  Function()? moveSpotList;

  @override
  State<SrAppBar> createState() => _SrAppBarState();
}

class _SrAppBarState extends State<SrAppBar> {
  bool expanded = true;
  static const double _topContentSize = 96;
  double topContentSize = _topContentSize;
  double arrowAreaSize = 40;
  Set<String> selected = {"전체"};
  ImageProvider get profilePhoto {
    if(widget.user.memberPhoto?.photoUrl != null) {
      return NetworkImage(widget.user.memberPhoto?.photoUrl! ?? "");      
    }
    return const AssetImage("assets/user_profile_default_small.png");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          _TopContent(expanded),
          _ExpandButton(),
          expanded ? SizedBox.shrink() : _Chips(),
          if (widget.shouldRefresh)
            TextButton(
                onPressed: widget.fetchRegionSpots,
                child: Container(
                  height: 33,
                  width: 183,
                  child: Material(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(14, 8, 15, 8),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                                padding: EdgeInsets.only(right: 8),
                                child: SvgPicture.asset(
                                  "assets/refresh.svg",
                                  width: 16,
                                )),
                            Text(
                              "이 지역에서 검색하기",
                              style: SrTypography.body3medium,
                            ),
                          ]),
                    ),
                  ),
                ))
        ],
      ),
    );
  }

  Widget _TopContent(bool expanded) {
    return AnimatedSize(
      duration: Duration(milliseconds: 500),
      curve: Curves.ease,
      child: Container(
        height: topContentSize,
        padding: EdgeInsets.only(left: 32, right: 32, top: 4),
        decoration: const BoxDecoration(
          color: SrColors.white,
        ),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 63, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    margin: EdgeInsets.only(bottom: 8),
                    child: CircleAvatar(
                        backgroundColor: SrColors.white,
                        radius: 100,
                        backgroundImage: profilePhoto),
                    decoration: BoxDecoration(
                        color: SrColors.black,
                        borderRadius: BorderRadius.circular(100)),
                  ),
                  Text(widget.userName, style: SrTypography.body3semi,)
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: 16, right: 0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: widget.moveSpotList,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [Padding(padding: const EdgeInsets.only(bottom: 4), child: Text(widget.user.memberSpotsCnt.toString(), style: SrTypography.body3semi,)), const Text('장소', style: SrTypography.body4light,)],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(Following(tabIndex: 0, user: widget.user,));
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(padding: const EdgeInsets.only(bottom: 4), child: Text(widget.user.followersCnt.toString(), style: SrTypography.body3semi)),
                              const Text('팔로워', style: SrTypography.body4light,)
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(Following(tabIndex: 1, user: widget.user,));
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(padding: const EdgeInsets.only(bottom: 4), child: Text(widget.user.followingsCnt.toString(), style: SrTypography.body3semi)),
                              const Text('팔로잉',  style: SrTypography.body4light,)
                            ],
                          ),
                        )
                      ],
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 12)),
                    widget.isMyPage ? _MyPage() : _ProfileMenus(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _MyPage() {
    return SizedBox(
      width: double.infinity,
      height: 26,
      child: TextButton(
        onPressed: () {
          Get.to(MyPage());
        },
        style: TextButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 6),
            backgroundColor: SrColors.gray3,
            minimumSize: Size.fromHeight(26),
            fixedSize: Size.fromHeight(26),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100))),
        child: Text(
          '마이페이지',
          style: SrTypography.body4medium.copy(color: SrColors.gray1),
        ),
      ),
    );
  }

  Widget _ProfileMenus() {
    return SizedBox(
      height: 26,
      child: Row(
        children: [
          Expanded(
              child: Padding(
            padding: EdgeInsets.only(right: 7),
            child: OutlinedButton(
              onPressed: widget.isFollowing ? widget.unfollow : widget.follow,
              child: Text(
                widget.isFollowing ? "팔로잉" : "팔로우",
                style: TextStyle(
                    color: widget.isFollowing ? SrColors.primary : SrColors.white),
              ),
              style: OutlinedButton.styleFrom(
                  backgroundColor:
                      widget.isFollowing ? SrColors.white : SrColors.primary,
                  side: BorderSide(
                    color: SrColors.primary,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  )),
            ),
          )),
          GestureDetector(
              onTap: _showReportDialog,
              child: SvgPicture.asset(
                "assets/report.svg",
                color: SrColors.gray2,
                width: 24,
              ))
        ],
      ),
    );
  }

  void _showReportDialog() {
    Get.dialog(SrDialog(
      icon: SvgPicture.asset("assets/triangle.svg"),
      title: "부적절한 사용자",
      description: "사용자를 더이상 보고 싶지 않나요?",
      actions: [
        TextButton(
            onPressed: () {
              Get.back();
              Get.dialog(ReportDialog(
                title: "사용자 신고사유",
                options: ReportOptions.options,
                onFinish: (String type, String reason) async {
                  Get.back();
                  await widget.report?.call(type, reason);
                  Get.dialog(SrDialog(
                    icon: SvgPicture.asset("assets/warning.svg"),
                    title: "신고 완료!",
                    description: "신고처리 완료되었습니다",
                    actions: [
                      TextButton(onPressed: () => Get.back(), child: Text("완료", style: SrTypography.body2medium.copy(color: SrColors.white),))
                    ],
                  ));
                },
              ));
            },
            child: Text(
              "신고하기",
              style: SrTypography.body2semi.copy(color: SrColors.white),
            )),
        TextButton(
            onPressed: () {
              widget.block?.call();
              Get.back();
              _showBlockDialog();
            },
            child: Text("차단하기",
                style: SrTypography.body2semi.copy(color: SrColors.white))),
      ],
    ));
  }

  void _showBlockDialog() {
    Get.dialog(SrDialog(
      icon: SvgPicture.asset(
        "assets/check_large.svg",
        width: 80,
        height: 80,
      ),
      title: "차단이 완료되었습니다",
      description: "마이페이지-차단 사용자 관리에서\n확인할 수 있습니다",
      actions: [
        TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text(
              "완료",
              style: SrTypography.body2semi.copy(color: SrColors.white),
            ))
      ],
    ));
  }

  Widget _ExpandButton() {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: arrowAreaSize,
      decoration: BoxDecoration(
          color: SrColors.white,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15))),
      child: GestureDetector(
        child: SvgPicture.asset(
          expanded ? 'assets/arrow_up.svg' : 'assets/arrow_down.svg',
          color: SrColors.primary,
          width: 20,
          height: 20,
        ),
        onTap: () {
          setState(() {
            expanded = !expanded;
            topContentSize = expanded ? _topContentSize : 0;
          });
        },
      ),
    );
  }

  Widget _Chips() {
    const chipNames = ['전체', '식당', '카페', '관광지', '숙소', '쇼핑', '병원', '기타'];
    const chipColors = [
      SrColors.primary,
      SrColors.restaurant,
      SrColors.cafe,
      SrColors.tour,
      SrColors.accommodation,
      SrColors.shopping,
      SrColors.hospital,
      SrColors.etc
    ];

    return Container(
        width: double.infinity,
        height: 36,
        margin: EdgeInsets.only(top: 8),
        child: ListView(
          padding: EdgeInsets.only(left: 16),
          scrollDirection: Axis.horizontal,
          children: List.generate(8, (int index) {
            return Padding(
                padding: EdgeInsets.only(right: 8),
                child: SrChip(
                    name: chipNames[index],
                    color: chipColors[index],
                    selected: selected.contains(chipNames[index]),
                    onTab: (isSelected) {
                      setState(() {
                        if(isSelected) {
                          selected.add(chipNames[index]);
                        } else {
                          selected.remove(chipNames[index]);
                        }
                        widget.onCategorySelected?.call(selected);
                      });
                    }));
          }),
        ));
  }
}
