import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotright/presentation/common/colors.dart';
import 'package:spotright/presentation/component/appbars/default_app_bar.dart';
import 'package:spotright/presentation/component/sr_chip/sr_chip.dart';

class SpotList extends StatefulWidget {
  const SpotList({Key? key}) : super(key: key);

  @override
  State<SpotList> createState() => _SpotListState();
}

class _SpotListState extends State<SpotList> {
  List<String> chipNames = ['전체', '식당', '카페', '관광지', '숙소', '쇼핑', '병원', '기타'];
  List<Color> chipColors = [
    SrColors.primary,
    SrColors.restaurant,
    SrColors.cafe,
    SrColors.tour,
    SrColors.accommodation,
    SrColors.shopping,
    SrColors.hospital,
    SrColors.etc
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: DefaultAppBar(
        title: '장소',
        hasBackButton: true,
      ),
      body: Column(
        children: [
          _chips(),
          Container(
              margin: EdgeInsets.only(right: 16, top: 10, bottom: 4),
              alignment: Alignment.centerRight,
              child: Text("편집")),
          Divider(
            height: 2,
            thickness: 1,
            color: SrColors.gray3,
          ),
          Flexible(
            child: ListView(
              children: List.generate(10, (int index) {
                return Column(children: [
                  Container(
                      height: 72,
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.only(right: 8),
                              child: SvgPicture.asset(
                                "assets/marker.svg",
                                width: 26,
                              )),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                overflow: TextOverflow.ellipsis,
                                  text: TextSpan(
                                      style: TextStyle(color: SrColors.black),
                                      children: [
                                    TextSpan(text: "미스터디유커피"),
                                    TextSpan(
                                        text: "카페",
                                        style: TextStyle(color: SrColors.gray2))
                                  ])),
                              Text("인천 연수구 아카데미로 119"),
                            ],
                          ),
                          Spacer(),
                          Row(
                            children: [
                              SvgPicture.asset(
                                "assets/star.svg",
                                width: 16,
                              ),
                              Padding(padding: EdgeInsets.only(right: 2)),
                              SvgPicture.asset(
                                "assets/star.svg",
                                width: 16,
                              ),
                              Padding(padding: EdgeInsets.only(right: 2)),
                              SvgPicture.asset(
                                "assets/star.svg",
                                width: 16,
                              ),
                            ],
                          )
                        ],
                      )),
                  Divider(
                    height: 2,
                    thickness: 1,
                    color: SrColors.gray3,
                  )
                ]);
              }),
            ),
          )
        ],
      ),
    ));
  }

  Widget _chips() {
    return Container(
      padding: EdgeInsets.only(left: 16),
      height: 40,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: List.generate(8, (int index) {
          return Padding(
              padding: EdgeInsets.only(right: 8),
              child: SrChip(
                  name: chipNames[index],
                  color: chipColors[index],
                  selected: true,
                  onTab: (isSelected) {}));
        }),
      ),
    );
  }
}
