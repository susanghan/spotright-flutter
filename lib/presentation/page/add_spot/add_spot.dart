import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotright/presentation/common/colors.dart';
import 'package:spotright/presentation/component/appbars/default_app_bar.dart';
import 'package:spotright/presentation/component/buttons/sr_cta_button.dart';
import 'package:spotright/presentation/component/sr_text_field/sr_text_field.dart';

import '../../component/sr_dropdown_box/sr_dropdown_box.dart';
import '../../component/sr_dropdown_box/sr_dropdown_button.dart';

class AddSpot extends StatefulWidget {
  const AddSpot({Key? key}) : super(key: key);

  @override
  State<AddSpot> createState() => _AddSpotState();
}

final List<String> mainCategory = ["식당", "카페",  "관광지", "숙소", "쇼핑", "병원", "기타"];
final List<Color> mainCategoryColors = [SrColors.restaurant, SrColors.cafe,  SrColors.tour, SrColors.accommodation, SrColors.shopping, SrColors.hospital, SrColors.etc];
final List<String> subCategoryRestaurant = ["아시안", "패스트푸드", "양식", "조식", "멕시칸", "중식", "일식", "한식", "건강식", "기타"];
final List<String> subCategoryAccommodation = ["호텔 & 리조트", "모텔", "펜션&풀빌라", "에어비앤비", "캠핑&글램핑", "게스트하우스", "기타"];

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
                const Text.rich(
                    TextSpan(
                      style : TextStyle(color: SrColors.black),
                      children: [
                        TextSpan(text: "장소명을 입력해주세요."),
                        TextSpan(text: "(필수)", style: TextStyle(color: SrColors.primary))
                      ]
                )),
                SrTextField(),
                const Text.rich(
                  TextSpan(
                    style: TextStyle(color: SrColors.black),
                    children: [
                      TextSpan(text: "주소를 입력해주세요."),
                      TextSpan(text: "(필수)", style: TextStyle(color: SrColors.primary))
                    ]
                )),
                SrTextField(suffixIcon: SvgPicture.asset('assets/address_marker.svg', width: 24, height: 24)),
                Text("카테고리를 입력해주세요."),
                SrDropdownButton(dropdownItems: mainCategory, hint: '대분류', dropdownIconSize : 11, dropdownIconColors: mainCategoryColors, onChanged: (String? value) {  }, ),
                Text("메모"),
                SrTextField(),
                Text("120/140"),
                const Text.rich(
                    TextSpan(
                        style: TextStyle(color: SrColors.black),
                        children: [
                          TextSpan(text: "방문한 장소인가요?"),
                          TextSpan(text: "(필수)", style: TextStyle(color: SrColors.primary))
                        ]
                    )),
                Text("별점"),
                Text("사진 첨부"),
                SrCTAButton(
                  text: "완료",
                  action: () {  },)
              ],
            ),
          ),
        ));
  }
}
