import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:spotright/presentation/common/colors.dart';
import 'package:spotright/presentation/component/sr_appbar/sr_app_bar_model.dart';
import 'package:spotright/presentation/component/sr_chip/sr_chip.dart';
import 'package:spotright/presentation/component/sr_chip/sr_chip_model.dart';
import 'package:spotright/presentation/page/my_page/my_page.dart';

class SrAppBar extends StatefulWidget {
  SrAppBar({Key? key, required this.srAppBarModel}) : super(key: key);

  SrAppBarModel srAppBarModel;

  @override
  State<SrAppBar> createState() => _SrAppBarState();
}

class _SrAppBarState extends State<SrAppBar> {
  bool expended = true;
  static const double _topContentSize = 96;
  double topContentSize = _topContentSize;
  double arrowAreaSize = 40;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          _TopContent(expended),
          _ExpandButton(),
          expended ? SizedBox.shrink() : _Chips()
        ],
      ),
    );
  }

  Widget _TopContent(bool expended) {
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
                        radius: 100,
                        backgroundImage:
                            NetworkImage('https://picsum.photos/200')),
                    decoration: BoxDecoration(
                        color: SrColors.black,
                        borderRadius: BorderRadius.circular(100)),
                  ),
                  Text(widget.srAppBarModel.userName)
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
                          children: [
                            Text(widget.srAppBarModel.spots.toString()),
                            Text('장소')
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(widget.srAppBarModel.followers.toString()),
                            Text('팔로워')
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(widget.srAppBarModel.followings.toString()),
                            Text('팔로잉')
                          ],
                        )
                      ],
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 8)),
                    SizedBox(
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
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _ExpandButton() {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: arrowAreaSize,
      decoration: BoxDecoration(
          color: SrColors.white,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12))
      ),
      child: GestureDetector(
        child: SvgPicture.asset(
          expended ? 'assets/arrow_up.svg' : 'assets/arrow_down.svg',
          color: SrColors.primary,
          width: 24,
          height: 24,
        ),
        onTap: () {
          setState(() {
            expended = !expended;
            topContentSize = expended ? _topContentSize : 0;
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
                    model: SrChipModel(
                        name: chipNames[index],
                        color: chipColors[index],
                        selected: widget.srAppBarModel.selectedChips[index],
                        onTab: (isSelected) {
                          setState(() {
                            widget.srAppBarModel.selectedChips[index] =
                                isSelected;
                          });
                        })));
          }),
        ));
  }
}
