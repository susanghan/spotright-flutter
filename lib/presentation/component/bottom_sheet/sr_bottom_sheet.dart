import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotright/presentation/common/colors.dart';
import 'package:spotright/presentation/component/bottom_sheet/spot_summary.dart';

class SrBottomSheet extends StatelessWidget {
  SrBottomSheet({Key? key}) : super(key: key);

  final List<SpotSummary> spotList = [
    SpotSummary(
      title: "미스터디유커피",
      category: "카페",
      rating: 3,
      address: "인천 연수구 아카데미로 119",
      memo: "아샷추 존맛입니다.",
      photoUrl: "https://picsum.photos/190",
    ),
    SpotSummary(
      title: "미스터디유커피",
      category: "카페",
      rating: 3,
      address: "인천 연수구 아카데미로 119",
      memo: "아샷추 존맛입니다.",
      photoUrl: "https://picsum.photos/190",
    ),
    SpotSummary(
      title: "미스터디유커피",
      category: "카페",
      rating: 3,
      address: "인천 연수구 아카데미로 119",
      memo: "아샷추 존맛입니다.",
      photoUrl: "https://picsum.photos/190",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 16, right: 16, bottom: 50),
      height: spotList.length * 122,
      child: SingleChildScrollView(
        child: Column(
          children: _SpotList()
        ),
      ),
    );
  }

  List<Widget> _SpotList() {
    return spotList
        .map((e) => Container(
              height: 108,
              margin: EdgeInsets.only(bottom: 14),
              decoration: BoxDecoration(
                color: SrColors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 16),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 20, bottom: 4),
                            child: Row(
                              children: [
                                Padding(
                                    padding: EdgeInsets.only(right: 4),
                                    child: Text(e.title)),
                                Padding(
                                    padding: EdgeInsets.only(right: 6),
                                    child: Text(e.category)),
                                ..._Rating(e.rating),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              SvgPicture.asset(
                                "assets/location.svg",
                                color: SrColors.gray1,
                              ),
                              Padding(
                                  padding: EdgeInsets.only(bottom: 4),
                                  child: Text(e.address))
                            ],
                          ),
                          Text(e.memo ?? ""),
                        ]),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 8),
                    width: 76,
                    height: 76,
                    child: CircleAvatar(
                        backgroundColor: SrColors.white,
                        radius: 100,
                        backgroundImage: NetworkImage(e.photoUrl ?? "")),
                  )
                ],
              ),
            ))
        .toList();
  }

  List<Widget> _Rating(rating) {
    List<Widget> children = [];

    for (int i = 0; i < rating; i++) {
      children.add(SvgPicture.asset(
        "assets/star.svg",
        color: SrColors.primary,
      ));
    }

    return children;
  }
}
