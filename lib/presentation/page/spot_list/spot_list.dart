import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:spotright/data/resources/category.dart';
import 'package:spotright/data/spot/spot_response.dart';
import 'package:spotright/presentation/common/colors.dart';
import 'package:spotright/presentation/common/typography.dart';
import 'package:spotright/presentation/component/appbars/default_app_bar.dart';
import 'package:spotright/presentation/component/buttons/sr_rating_button.dart';
import 'package:spotright/presentation/component/divider/sr_divider.dart';
import 'package:spotright/presentation/component/sr_check_box/sr_check_box.dart';
import 'package:spotright/presentation/component/sr_chip/sr_chips.dart';
import 'package:spotright/presentation/page/spot_list/spot_list_controller.dart';

class SpotList extends StatefulWidget {
  SpotList({
    Key? key,
    required this.userId,
    this.topLatitude = 90,
    this.topLongitude = -180,
    this.bottomLatitude = 0,
    this.bottomLongitude = 179.999999,
  }) : super(key: key);

  int userId;
  double topLatitude;
  double topLongitude;
  double bottomLatitude;
  double bottomLongitude;

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

  final SpotListController _spotListController = Get.put(SpotListController());

  @override
  void initState() {
    super.initState();
    _spotListController.initState(widget.userId, widget.topLatitude,
        widget.topLongitude, widget.bottomLatitude, widget.bottomLongitude);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _spotListController.pressBack,
      child: SafeArea(
          child: Scaffold(
              appBar: DefaultAppBar(
                title: '장소',
                hasBackButton: true,
              ),
              body: _body())),
    );
  }

  Widget _body() {
    return Obx(() =>
        _spotListController.isEditMode.value ? _editBody() : _defaultBody());
  }

  Widget _defaultBody() {
    return Obx(() => Column(
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 16),
          child: SrChips(
            height: 38,
            onCategorySelected: _spotListController.onCategorySelected,
            selectedCategories: _spotListController.selectedCategories,
          ),
        ),
        if(_spotListController.isMyPage.value) Container(
            margin: EdgeInsets.only(right: 16, top: 0, bottom: 12),
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: _spotListController.changeMode,
              child: Text(
                "편집",
                style: SrTypography.body3medium.copy(color: SrColors.gray1),
              ),
            )),
        SrDivider(
          height: 1,
        ),
        Flexible(
          child: ListView(
            children: _spotListController.spots.map((spot) {
              return Column(children: [
                _DefaultItem(spot),
                Divider(
                  height: 2,
                  thickness: 1,
                  color: SrColors.gray3,
                )
              ]);
            }).toList(),
          ),
        )
      ],
    ));
  }

  Widget _DefaultItem(SpotResponse spot) {
    return GestureDetector(
      onTap: _spotListController.moveDetail(spot),
      child: Container(
        color: SrColors.white,
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Row(children: [
          Flexible(
            child: _CommonItem(spot),
          ),
          if (spot.rating != null && spot.rating != 0)
            SrRatingButton(
                initialRating: spot.rating!.toDouble(),
                ratingMode: RatingMode.readOnly)
        ]),
      ),
    );
  }

  Widget _CommonItem(SpotResponse spot) {
    return Container(
        height: 80,
        padding: EdgeInsets.symmetric(vertical: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(right: 12),
                child: SvgPicture.asset("assets/marker.svg",
                    width: 28,
                    color:
                        SpotCategory.mainCategoryColors[spot.mainCategoryIndex])),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Flexible(
                          child: Padding(
                              padding: EdgeInsets.only(right: 4),
                              child: Text(spot.spotName ?? "",
                                  style: SrTypography.body2medium, overflow: TextOverflow.ellipsis,)),
                        ),
                        Text(
                          spot.mainCategory ?? "",
                          style: SrTypography.body4medium
                              .copy(color: SrColors.gray2),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    spot.fullAddress ?? "정보 없음",
                    style: SrTypography.body4medium.copy(color: SrColors.gray1), overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  Widget _editBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Padding(
            padding: EdgeInsets.only(left : 40, right: 16, top: 14, bottom: 8),
            child: SrCheckBox(
              value: _spotListController.isAllSelected.value,
              onChanged: _spotListController.onAllSelected,
              isRectangle: true,
            ),
          ),
          Padding(padding: EdgeInsets.only(top:4),child: Text("전체 선택", style: SrTypography.body3medium.copy(color: SrColors.gray1),)),
          Spacer(),
          Container(
              margin: EdgeInsets.only(right: 16, top: 20, bottom: 12),
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: _spotListController.finishEdit,
                child: Text(
                  "삭제",
                  style: SrTypography.body3medium.copy(color: SrColors.gray1),
                ),
              )),
        ]),
        Divider(
          height: 2,
          thickness: 1,
          color: SrColors.gray3,
        ),
        Flexible(
          child: Padding(
            padding: EdgeInsets.only(left: 24),
            child: ListView(
                children: _spotListController.spots
                    .map((spot) => _EditItem(spot))
                    .toList()),
          ),
        )
      ],
    );
  }

  Widget _EditItem(SpotResponse spot) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(children: [
        Padding(
            padding: EdgeInsets.only(right: 10),
            child: SrCheckBox(
              value: _spotListController.toRemoveSpotIds.contains(spot.memberSpotId),
              onChanged: (bool checked) {
                _spotListController.onCheckBoxSelected(spot.memberSpotId!, checked);
              },
              isRectangle: true,
            )),
        Flexible(
          child: _CommonItem(spot),
        ),
      ]),
    );
  }
}
