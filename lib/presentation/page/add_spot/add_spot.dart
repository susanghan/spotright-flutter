import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:spotright/presentation/common/colors.dart';
import 'package:spotright/presentation/component/appbars/default_app_bar.dart';
import 'package:spotright/presentation/component/buttons/sr_attach_picture.dart';
import 'package:spotright/presentation/component/buttons/sr_cta_button.dart';
import 'package:spotright/presentation/component/buttons/sr_rating_button.dart';
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
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 36),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ..._InputSpotName(),
                  ..._InputSpotAddress(),
                  ..._SelectSpotCategory(),
                  ..._InputMemo(),
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
          ],
        ),
      ),
    ));
  }

  Widget _TextFieldLabel(String text, bool isRequired){
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text.rich(TextSpan(children: <TextSpan>[
        TextSpan(text: text, style: const TextStyle(color: SrColors.black, fontSize: 15, fontWeight: FontWeight.w500)),
        TextSpan(text: isRequired ? " (필수)" : null, style: const TextStyle(color: SrColors.primary, fontSize: 15, fontWeight: FontWeight.w300,))
      ])),
    );
  }

  List<Widget> _InputSpotName() {
    return [
      _TextFieldLabel("장소명을 입력해 주세요.", true),
      Padding(padding: const EdgeInsets.only(bottom: 0), child: SrTextField()),
    ];
  } 

  List<Widget> _InputSpotAddress() {
    return [
      _TextFieldLabel("주소를 입력해 주세요.", true),
      Padding(
        padding: EdgeInsets.only(bottom: 16),
        child: SrTextField(
            suffixIcon: SvgPicture.asset('assets/address_marker.svg')),
      ),
    ];
  }

  List<Widget> _SelectSpotCategory() {
    return [
      _TextFieldLabel("카테고리를 입력해 주세요.", false),
      Padding(
        padding: EdgeInsets.only(bottom: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex : 1,
              child: SrDropdownButton(
                hasIcon: true,
                isRequired: true,
                dropdownItems: mainCategory,
                hint: '대분류',
                dropdownIconColors: mainCategoryColors,
                onChanged: (String? value) {},
              ),
            ),
            const SizedBox(width: 6,),
            Flexible(
              flex: 1,
              child: SrDropdownButton(
                hasIcon: false,
                isRequired: false,
                dropdownItems: subCategoryRestaurant,
                hint: '소분류',
                onChanged: (String? value) {},
              ),
            ),
          ],
        ),
      )
    ];
  }

  List<Widget> _InputMemo() {
    return [
      _TextFieldLabel("메모", false),
      Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: SrTextField(
            maxLines: 5,
            height: 137,
          )),
      Container(
        margin: const EdgeInsets.only(bottom: 16),
        child: Text("120/140"),
        alignment: Alignment.centerRight,
      ),
    ];
  }

  //Todo: 여기는 라디오 버튼 쪽이라 그냥 안 건드렸어! _TextFieldLabel로 바꾼 거 빼구~,,여기 간격 넘 안 맞아서 그것도 안 해 뒀어,,,ㅠ
  List<Widget> _InputVisitation() {
    return [
      _TextFieldLabel("방문한 장소인가요?", true),
      Padding(
        padding: const EdgeInsets.only(top: 8,left: 16, bottom: 16, right: 16),
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
      _TextFieldLabel("별점", true),
      Container(
        padding: const EdgeInsets.only(top: 8, bottom: 30),
        alignment: Alignment.center,
        child: SrRatingButton(),
      ),
    ];
  }

  List<Widget> _Pictures() {
    return [
      _TextFieldLabel("사진 첨부", false),
      const Padding(padding: EdgeInsets.only(bottom: 8)),
      SrAttachPiture(),
      const Padding(padding: EdgeInsets.only(bottom: 40)),
    ];
  }
}
