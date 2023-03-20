import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotright/data/spot/spot_response.dart';
import 'package:spotright/presentation/common/colors.dart';
import 'package:spotright/presentation/common/typography.dart';

class SrBottomSheet extends StatelessWidget {
  SrBottomSheet({Key? key, required this.spots, this.moveDetail})
      : super(key: key);

  final Function(SpotResponse spot)? moveDetail;

  List<SpotResponse> spots;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 16, right: 16, bottom: 50),
      height: spots.length * 122,
      child: SingleChildScrollView(
        child: Column(children: _SpotList()),
      ),
    );
  }

  List<Widget> _SpotList() {
    return spots
        .map((e) => GestureDetector(
              onTap: () {
                moveDetail?.call(e);
              },
              child: Container(
                height: 108,
                margin: EdgeInsets.only(bottom: 14),
                decoration: BoxDecoration(
                  color: SrColors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 14),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 2, top: 18, bottom: 10),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.only(right: 4),
                                        child: Text(
                                          e.spotName ?? "",
                                          style: SrTypography.body2semi,
                                          overflow: TextOverflow.ellipsis,
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(right: 10),
                                        child: Text(
                                          e.mainCategory ?? "",
                                          style: SrTypography.body4medium
                                              .copy(color: SrColors.gray2),
                                        )),
                                    ..._Rating(e.rating),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(bottom: 10),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(right: 4),
                                      child: SvgPicture.asset(
                                        "assets/location.svg",
                                        color: SrColors.gray1,
                                      ),
                                    ),
                                    Flexible(
                                      child: Padding(
                                          padding: EdgeInsets.only(bottom: 2, right: 4),
                                          child: Text(
                                            e.fullAddress ?? "",
                                            style: SrTypography.body4medium
                                                .copy(color: SrColors.gray1),
                                            overflow: TextOverflow.ellipsis,
                                          )),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.only(left: 2),
                                  child: Text(
                                    e.memo ?? "",
                                    style: SrTypography.body4medium
                                        .copy(color: SrColors.gray2),
                                    overflow: TextOverflow.ellipsis,
                                  )),
                            ]),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 16,),
                      width: 76,
                      height: 76,
                      child: CircleAvatar(
                          backgroundColor: SrColors.white,
                          radius: 100,
                          backgroundImage: NetworkImage(
                              (e.spotPhotos?.length ?? 0) > 0
                                  ? e.spotPhotos!.first.photoUrl!
                                  : "")),
                    )
                  ],
                ),
              ),
            ))
        .toList();
  }

  List<Widget> _Rating(rating) {
    List<Widget> children = [];

    for (int i = 0; i < rating; i++) {
      children.add(Padding(
        padding: EdgeInsets.only(bottom: 3),
        child: SvgPicture.asset(
          "assets/star.svg",
          color: SrColors.primary,
        ),
      ));
    }

    return children;
  }
}
