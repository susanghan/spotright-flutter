import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotright/data/spot/spot_response.dart';
import 'package:spotright/presentation/common/colors.dart';

class SrBottomSheet extends StatelessWidget {
  SrBottomSheet({
    Key? key,
    required this.spots,
  }) : super(key: key);

  List<SpotResponse> spots;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 16, right: 16, bottom: 50),
      height: spots.length * 122,
      child: SingleChildScrollView(
        child: Column(
          children: _SpotList()
        ),
      ),
    );
  }

  List<Widget> _SpotList() {
    return spots
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
                                    child: Text(e.spotName ?? "")),
                                Padding(
                                    padding: EdgeInsets.only(right: 6),
                                    child: Text(e.category.toString())),
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
                                  child: Text(e.fullAddress ?? ""))
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
                        backgroundImage: NetworkImage((e.spotPhotos?.length ?? 0) > 0 ? e.spotPhotos!.first.photoUrl! : "")),
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
