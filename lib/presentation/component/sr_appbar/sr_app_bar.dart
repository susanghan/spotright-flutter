import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:spotright/presentation/common/colors.dart';
import 'package:spotright/presentation/component/sr_appbar/sr_app_bar_model.dart';

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
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      height: expended ? 200 : 112,
      decoration: const BoxDecoration(
          color: SrColors.white,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12))),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: SrColors.black,
                  )),
              Text(widget.srAppBarModel.id),
              SvgPicture.asset(
                'assets/search.svg',
                color: SrColors.primary,
                width: 24,
                height: 24,
              )
            ],
          ),
          Padding(padding: EdgeInsets.only(bottom: 24)),
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
    );
  }

  Widget _MiddleComponent(bool extended) {
    if(!extended) return SizedBox.shrink();

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
                decoration: BoxDecoration(
                    color: SrColors.black,
                    borderRadius: BorderRadius.circular(100)),
              ),
              Text(widget.srAppBarModel.userName)
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [Text(widget.srAppBarModel.spots.toString()), Text('장소')],
                  ),
                  Column(
                    children: [Text(widget.srAppBarModel.followers.toString()), Text('팔로워')],
                  ),
                  Column(
                    children: [Text(widget.srAppBarModel.followings.toString()), Text('팔로잉')],
                  )
                ],
              ),
              Padding(padding: EdgeInsets.only(bottom: 8)),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    '마이페이지',
                    style: TextStyle(
                      color: SrColors.darkGray,
                    ),
                  ),
                  style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      backgroundColor: SrColors.gray,
                      minimumSize: Size.fromHeight(24),
                      fixedSize: Size.fromHeight(24),
                      shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(100))),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
