import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:spotright/presentation/common/colors.dart';
import 'package:spotright/presentation/component/sr_appbar/sr_app_bar_model.dart';
import 'package:spotright/presentation/component/sr_chip/sr_chip.dart';
import 'package:spotright/presentation/page/my_page/my_page.dart';

class SrAppBar extends StatefulWidget {
  SrAppBar({Key? key, required this.srAppBarModel}) : super(key: key);

  SrAppBarModel srAppBarModel;

  @override
  State<SrAppBar> createState() => _SrAppBarState();
}

class _SrAppBarState extends State<SrAppBar> {
  bool expended = true;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        padding: EdgeInsets.fromLTRB(20, 16, 20, 0),
        width: double.infinity,
        height: expended ? 144 : 56,
        decoration: const BoxDecoration(
            color: SrColors.white,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12))),
        child: Column(
          children: [
            _MiddleComponent(expended),
            GestureDetector(
              child: SvgPicture.asset(
                expended ? 'assets/arrow_up.svg' : 'assets/arrow_down.svg',
                color: SrColors.primary,
                width: 24,
                height: 24,
              ),
              onTap: () {
                setState(() {
                  expended = !expended;
                });
              },
            )
          ],
        ),
      ),
      expended ? SizedBox.shrink() : _Chips()
    ]);
  }

  Widget _MiddleComponent(bool expended) {
    if (!expended) return SizedBox.shrink();

    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 20, right: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 64,
                height: 64,
                margin: EdgeInsets.only(bottom: 4),
                child: CircleAvatar(
                  radius: 100,
                    backgroundImage: NetworkImage('https://picsum.photos/200')
                ),
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
            padding: EdgeInsets.only(right: 20),
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
    );
  }

  Widget _Chips() {
    return Container(
        width: double.infinity,
        height: 40,
        padding: EdgeInsets.only(left: 20),
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: List.generate(10, (int index) {
            return Padding(
                padding: EdgeInsets.only(right: 8),
                child: SrChip(
                  text: 'tag$index',
                ));
          }),
        ));
  }
}
