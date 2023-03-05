import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:spotright/presentation/common/typography.dart';
import 'package:spotright/presentation/component/appbars/default_app_bar.dart';
import 'package:spotright/presentation/component/buttons/sr_rating_button.dart';
import 'package:spotright/presentation/page/register_spot/register_spot.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../common/colors.dart';
import '../../component/sr_chip/sr_chip_read_only.dart';
import '../register_spot/register_spot_controller.dart';
import 'detail_controller.dart';

//Todo : 수정 클릭시 장소 수정 페이지로 이동
//Todo: SrTextFiled) 본문 행간=글자크기 *1.4 ,글자크기:12, 행간:16.8, 본문 영역: 68*296, 상하 여백: 14, 좌우 여백: 16
//Todo: 이미지 가로,세로 길이 받아서 긴쪽으로 1:1 비율하기

class Detail extends StatefulWidget {
  Detail({Key? key, required this.userId, required this.memberSpotId})
      : super(key: key);

  int userId;
  int memberSpotId;

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  DetailController detailController = Get.find();

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    await detailController.initSpot(widget.userId, widget.memberSpotId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: DefaultAppBar(
                title: detailController.spot.value.spotName ?? "",
                hasBackButton: true,
                actions: [
                  GestureDetector(
                    onTap: () {
                      Get.to(RegisterSpot(pageMode: PageMode.edit));
                    },
                    child: Padding(
                      padding: EdgeInsets.only(right: 20),
                      child: SvgPicture.asset(
                        'assets/edit.svg',
                        color: SrColors.black,
                        width: 24,
                        height: 24,
                      ),
                    ),
                  )
                ]),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _SpotImages(detailController.spot.value.spotPhotos
                          ?.map((spotPhoto) => spotPhoto.photoUrl!)
                          .toList() ??
                      []),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _SpotName(
                            detailController.spot.value.spotName ?? "정보 없음"),
                        // todo : 소분류 정보 추가
                        _SpotChips(
                            detailController.spot.value.mainCategory ?? "",
                            "소분류"),
                        _SpotLocation(
                            detailController.spot.value.fullAddress ?? "정보 없음"),
                        _SearchLocation(),
                        _SpotRating(
                            detailController.spot.value.rating?.toDouble() ??
                                0),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                              vertical: 14, horizontal: 16),
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(15),
                              border: Border.fromBorderSide(
                                  BorderSide(color: SrColors.gray3))),
                          child: Text(detailController.spot.value.memo ?? "",
                              style: SrTypography.body4medium),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )));
  }

  Widget _SpotImages(List<String> list) {
    return Stack(alignment: Alignment.topRight, children: [
      Carousel(list),
      Container(
          margin: EdgeInsets.only(right: 16, top: 12),
          padding: EdgeInsets.symmetric(vertical: 3, horizontal: 6),
          decoration: BoxDecoration(
              color: SrColors.black.withOpacity(0.4),
              borderRadius: BorderRadius.circular(20)),
          child: Text(
            "1/${list.length}",
            //"${detailController.currentCarouselPage}/${list.length}",
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w400, fontSize: 12),
          )),
    ]);
  }

  Widget Carousel(List<String> list) {
    return Stack(alignment: Alignment.bottomRight, children: [
      Container(
        width: double.infinity,
        color: SrColors.gray3,
        child: CarouselSlider.builder(
            itemCount: list.length,
            itemBuilder:
                (BuildContext context, int itemIndex, int pageViewIndex) =>
                    Container(
                        width: double.infinity,
                        child: Image(
                          image: NetworkImage(list[itemIndex]),
                          fit: BoxFit.cover,
                        )),
            options: CarouselOptions(
              height: MediaQuery.of(context).size.width,
              viewportFraction: 1,
              enableInfiniteScroll: false,
            )),
      ),
      GestureDetector(
        onTap: () {
          Uri url = Uri.parse("https://www.google.com/search?q=${detailController.spot.value.spotName}");
          launchUrl(url);
        },
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Text(
            '"${detailController.spot.value.spotName}" 검색하기',
            style: SrTypography.body4bold.copy(
                color: SrColors.gray1, decoration: TextDecoration.underline),
          ),
        ),
      )
    ]);
  }

  Widget _SpotName(String spotName) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Text(spotName,
          style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: SrColors.black)),
    );
  }

  Widget _SpotChips(String mainCategoryName, String subCategoryName) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          SrChipReadOnly(
            categoryKind: CategoryKind.mainCategory,
            categoryName: mainCategoryName,
          ),
          const Padding(padding: EdgeInsets.only(right: 4)),
          SrChipReadOnly(
            categoryKind: CategoryKind.subCategory,
            categoryName: subCategoryName,
          ),
        ],
      ),
    );
  }

  Widget _SpotLocation(String spotLocation) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          SvgPicture.asset(
            'assets/location.svg',
            width: 14,
            height: 14,
            color: SrColors.gray1,
          ),
          const Padding(padding: EdgeInsets.only(right: 4)),
          Text(
            spotLocation,
            style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: SrColors.black),
          ),
          const Padding(padding: EdgeInsets.only(right: 4)),
          SvgPicture.asset(
            'assets/copy.svg',
            width: 12,
            height: 12,
            color: SrColors.gray1,
          ),
        ],
      ),
    );
  }

  Widget _SearchLocation() {
    return GestureDetector(
      onTap: () => Get.back(),
      child: Padding(
          padding: EdgeInsets.only(bottom: 18, left: 18),
          child: Text(
            "지도에서 위치 확인하기",
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w300,
                color: SrColors.gray1,
                decoration: TextDecoration.underline),
          )),
    );
  }

  Widget _SpotRating(double rating) {
    return Visibility(
      visible: rating != 0,
      child: Padding(
        padding: EdgeInsets.only(bottom: 9),
        child: Row(
          children: [
            SvgPicture.asset(
              "assets/check.svg",
              width: 14,
              height: 14,
              color: SrColors.gray1,
            ),
            const Padding(padding: EdgeInsets.only(right: 4)),
            const Text(
              "방문완료",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  color: SrColors.black),
            ),
            const Padding(padding: EdgeInsets.only(right: 4)),
            SrRatingButton(
              ratingMode: RatingMode.readOnly,
              initialRating: rating,
            )
          ],
        ),
      ),
    );
  }
}
