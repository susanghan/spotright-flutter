import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotright/presentation/common/colors.dart';
import 'package:spotright/presentation/component/appbars/default_app_bar.dart';
import 'package:spotright/presentation/component/buttons/sr_cta_button.dart';
import 'package:spotright/presentation/component/buttons/sr_rating_buttons.dart';
import 'package:spotright/presentation/component/sr_check_box/sr_check_box.dart';
import 'package:spotright/presentation/component/sr_text_field/sr_text_field.dart';
import '../../component/buttons/sr_dropdown_button.dart';


class AddSpot extends StatefulWidget {
  const AddSpot({Key? key}) : super(key: key);

  @override
  State<AddSpot> createState() => _AddSpotState();
}

String? selectedString;

final List<String> mainCategory = ["식당", "카페", "관광지", "숙소", "쇼핑", "병원", "기타"];
final List<Color> mainCategoryColors = [
  SrColors.restaurant,
  SrColors.cafe,
  SrColors.tour,
  SrColors.accommodation,
  SrColors.shopping,
  SrColors.hospital,
  SrColors.etc
];
final List<String> subCategoryRestaurant = [
  "아시안",
  "패스트푸드",
  "양식",
  "조식",
  "멕시칸",
  "중식",
  "일식",
  "한식",
  "건강식",
  "기타"
];
final List<String> subCategoryAccommodation = [
  "호텔 & 리조트",
  "모텔",
  "펜션&풀빌라",
  "에어비앤비",
  "캠핑&글램핑",
  "게스트하우스",
  "기타"
];

class _AddSpotState extends State<AddSpot> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: const DefaultAppBar(
        title: "장소추가",
        hasBackButton: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ..._InputSpotName(),
                  ..._InputSpotAddress(),
                  ..._SelectSpotCategory(),
                  ..._InputMemo(),
                ],
              ),
            ),
            ..._InputVisitation(),
            ..._InputRating(),
            ..._Pictures(),
            SrCTAButton(
              text: "완료",
              action: () {},
            )
          ],
        ),
      ),
    ));
  }

  List<Widget> _InputSpotName() {
    return [
      Padding(
        padding: EdgeInsets.only(bottom: 4),
        child: const Text.rich(
            TextSpan(style: TextStyle(color: SrColors.black), children: [
          TextSpan(text: "장소명을 입력해주세요."),
          TextSpan(text: "(필수)", style: TextStyle(color: SrColors.primary))
        ])),
      ),
      Padding(padding: EdgeInsets.only(bottom: 16), child: SrTextField()),
    ];
  }

  List<Widget> _InputSpotAddress() {
    return [
      Padding(
        padding: EdgeInsets.only(bottom: 4),
        child: const Text.rich(
            TextSpan(style: TextStyle(color: SrColors.black), children: [
          TextSpan(text: "주소를 입력해주세요."),
          TextSpan(text: "(필수)", style: TextStyle(color: SrColors.primary))
        ])),
      ),
      Padding(
        padding: EdgeInsets.only(bottom: 16),
        child: SrTextField(
            suffixIcon: SvgPicture.asset('assets/address_marker.svg',
                width: 24, height: 24)),
      ),
    ];
  }

  List<Widget> _SelectSpotCategory() {
    return [
      Padding(
          padding: EdgeInsets.only(bottom: 4), child: Text("카테고리를 입력해주세요.")),
      Padding(
        padding: EdgeInsets.only(bottom: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SrDropdownButton(
              hasIcon: true,
              isRequired: true,
              dropdownItems: mainCategory,
              hint: '대분류',
              dropdownIconColors: mainCategoryColors,
              onChanged: (String? value) {},
            ),
            SrDropdownButton(
              hasIcon: false,
              isRequired: false,
              dropdownItems: subCategoryRestaurant,
              hint: '소분류',
              onChanged: (String? value) {},
            ),
          ],
        ),
      )
    ];
  }

  List<Widget> _InputMemo() {
    return [
      Padding(padding: EdgeInsets.only(bottom: 4), child: Text("메모")),
      Padding(
          padding: EdgeInsets.only(bottom: 6),
          child: SrTextField(
            maxLines: 7,
            height: 152,
          )),
      Container(
        margin: EdgeInsets.only(right: 6, bottom: 16),
        child: Text("120/140"),
        alignment: Alignment.centerRight,
      ),
    ];
  }

  List<Widget> _InputVisitation() {
    return [
      const Padding(
        padding: EdgeInsets.only(left: 16, bottom: 12),
        child: Text.rich(
            TextSpan(style: TextStyle(color: SrColors.black), children: [
          TextSpan(text: "방문한 장소인가요?"),
          TextSpan(text: "(필수)", style: TextStyle(color: SrColors.primary))
        ])),
      ),
      Padding(
        padding: EdgeInsets.only(left: 16, bottom: 16, right: 16),
        child: Row(
          children: [
            Flexible(
              child: Row(children: [
                Padding(padding: EdgeInsets.only(right: 12), child: Text("예")),
                SrCheckBox(value: true, onChanged: (checked) {}),
              ]),
            ),
            Flexible(
              child: Row(children: [
                Padding(
                    padding: EdgeInsets.only(right: 12), child: Text("아니오")),
                SrCheckBox(value: true, onChanged: (checked) {}),
              ]),
            ),
          ],
        ),
      )
    ];
  }

  List<Widget> _InputRating() {
    return [
      Padding(
        padding: EdgeInsets.only(left: 16, bottom: 4),
        child: Text("별점"),
      ),
      SrRatingButton(),
    ];

  }

  List<Widget> _Pictures() {
    return [
      Padding(
          padding: EdgeInsets.only(left: 16, bottom: 16), child: Text("사진 첨부")),
      Padding(
        padding: EdgeInsets.only(left: 16, bottom: 40),
        child: Row(
          children: [
            DottedBorder(
              borderType: BorderType.RRect,
              radius: Radius.circular(20),
              dashPattern: [5, 5],
              child: Container(
                width: 92,
                height: 92,
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset("assets/camera.svg"),
                    Text("5/5"),
                  ],
                ),
              ),
            )
          ],
        ),
      )
    ];
  }
}
