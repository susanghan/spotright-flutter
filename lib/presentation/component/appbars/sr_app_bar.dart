import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:spotright/presentation/common/colors.dart';
import 'package:spotright/presentation/common/typography.dart';
import 'package:spotright/presentation/component/dialog/sr_dialog.dart';
import 'package:spotright/presentation/component/sr_chip/sr_chip.dart';
import 'package:spotright/presentation/page/following/following.dart';
import 'package:spotright/presentation/page/my_page/my_page.dart';

class SrAppBar extends StatefulWidget {
  SrAppBar({
    Key? key,
    this.userName = '',
    this.spots = 0,
    this.followers = 0,
    this.followings = 0,
    this.isMyPage = true,
    this.follow,
    this.unfollow,
    this.isFollow = false,
    this.block
  }) : super(key: key);

  String userName;
  int spots;
  int followers;
  int followings;
  bool isFollow;
  bool isMyPage;
  Function()? follow;
  Function()? unfollow;
  Function()? block;
  List<bool> selectedChips = [
    true,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];

  @override
  State<SrAppBar> createState() => _SrAppBarState();
}

class _SrAppBarState extends State<SrAppBar> {
  bool expanded = true;
  static const double _topContentSize = 96;
  double topContentSize = _topContentSize;
  double arrowAreaSize = 40;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          _TopContent(expanded),
          _ExpandButton(),
          expanded ? SizedBox.shrink() : _Chips()
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
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: const BoxDecoration(
          color: SrColors.white,
        ),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(20, 8, 40, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    margin: EdgeInsets.only(bottom: 4),
                    child: CircleAvatar(
                        backgroundColor: SrColors.white,
                        radius: 100,
                        backgroundImage:
                            NetworkImage('https://picsum.photos/200')),
                    decoration: BoxDecoration(
                        color: SrColors.black,
                        borderRadius: BorderRadius.circular(100)),
                  ),
                  Text(widget.userName)
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: 16, right: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [Text(widget.spots.toString()), Text('장소')],
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(Following(tabIndex: 0));
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(widget.followers.toString()),
                              Text('팔로워')
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(Following(tabIndex: 1));
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(widget.followings.toString()),
                              Text('팔로잉')
                            ],
                          ),
                        )
                      ],
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 8)),
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
        child: Text(
          '마이페이지',
          style: TextStyle(
            color: SrColors.gray1,
          ),
        ),
        style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            backgroundColor: SrColors.gray3,
            minimumSize: Size.fromHeight(24),
            fixedSize: Size.fromHeight(24),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100))),
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
            padding: EdgeInsets.only(right: 8),
            child: OutlinedButton(
              onPressed: widget.isFollow ? widget.unfollow : widget.follow,
              child: Text(
                widget.isFollow ? "팔로잉" : "팔로우",
                style: TextStyle(
                    color: widget.isFollow ? SrColors.primary : SrColors.white),
              ),
              style: OutlinedButton.styleFrom(
                  backgroundColor:
                      widget.isFollow ? SrColors.white : SrColors.primary,
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
            onPressed: () {},
            child: Text(
              "신고하기",
              style: SrTypography.body2semi
                  .copy(color: SrColors.white),
            )),
        TextButton(
            onPressed: () {
              widget.block?.call();
              Get.back();
              _showBlockDialog();
            },
            child: Text("차단하기",
                style: SrTypography.body2semi
                    .copy(color: SrColors.white))),
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
          width: 24,
          height: 24,
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
        height: 40,
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.only(left: 20),
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: List.generate(8, (int index) {
            return Padding(
                padding: EdgeInsets.only(right: 8),
                child: SrChip(
                    name: chipNames[index],
                    color: chipColors[index],
                    selected: widget.selectedChips[index],
                    onTab: (isSelected) {
                      setState(() {
                        widget.selectedChips[index] = isSelected;
                      });
                    }));
          }),
        ));
  }
}
