import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:spotright/data/resources/category.dart';
import 'package:spotright/presentation/common/colors.dart';
import 'package:spotright/presentation/component/appbars/default_app_bar.dart';
import 'package:spotright/presentation/component/buttons/sr_attach_picture.dart';
import 'package:spotright/presentation/component/buttons/sr_cta_button.dart';
import 'package:spotright/presentation/component/buttons/sr_rating_button.dart';
import 'package:spotright/presentation/component/sr_check_box/sr_check_box.dart';
import 'package:spotright/presentation/component/sr_text_field/sr_text_field.dart';
import 'package:spotright/presentation/page/add_spot/add_spot_controller.dart';
import 'package:spotright/presentation/page/search_location/search_location.dart';
import '../../component/buttons/sr_dropdown_button.dart';

class AddSpot extends StatefulWidget {
  const AddSpot({Key? key}) : super(key: key);

  @override
  State<AddSpot> createState() => _AddSpotState();
}

AddSpotController addSpotController = Get.find();

final List<String> mainCategory = addSpotController.mainCategory;
final List<Color> mainCategoryColors = addSpotController.mainCategoryColors;
//List<String> subCategory = [];

class _AddSpotState extends State<AddSpot> {
  @override
  void initState() {
    addSpotController.subCategory.value = [];

    addSpotController.mainIsSelected.value = false;
    addSpotController.selectedMainString.value = null;

    addSpotController.subIsSelected.value = false;
    addSpotController.selectedSubString.value = null;
  }

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
                  ..._SearchLocation(),
                  ..._SpotLabel(),
                  ..._InputSpotName(),
                  ..._InputSpotProvince(),
                  ..._InputSpotCity(),
                  ..._InputSpotAddress(),
                  ..._SelectSpotCategory(),
                  ..._InputVisitation(),
                  ..._InputRating(),
                  ..._Pictures(),
                  ..._InputMemo(),
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

  Widget _TextFieldLabel(String text, bool isRequired) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text.rich(TextSpan(children: <TextSpan>[
        TextSpan(
            text: text,
            style: const TextStyle(
                color: SrColors.black,
                fontSize: 15,
                fontWeight: FontWeight.w500)),
        TextSpan(
            text: isRequired ? " *" : null,
            style: const TextStyle(
              color: SrColors.primary,
              fontSize: 15,
              fontWeight: FontWeight.w300,
            ))
      ])),
    );
  }

  List<Widget> _SearchLocation() {
    return [
      Padding(
        padding: EdgeInsets.fromLTRB(16, 0, 16, 12),
        child: SizedBox(
          width: double.infinity,
          height: 38,
          child: MaterialButton(
            elevation: 3,
            highlightElevation: 0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            onPressed: () {
              Get.to(SearchLocation());
            },
            color: SrColors.primary,
            splashColor: SrColors.primary,
            highlightColor: SrColors.primary,
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              SvgPicture.asset(
                "assets/marker.svg",
                width: 14,
                height: 14,
                color: SrColors.white,
              ),
              const SizedBox(
                width: 8,
              ),
              const Text(
                "지도에서 위치를 검색하세요",
                style: TextStyle(
                    color: SrColors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 14),
              ),
            ]),
          ),
        ),
      )
    ];
  }

  List<Widget> _SpotLabel() {
    return [
      Padding(
        padding: const EdgeInsets.only(bottom: 16, right: 16),
        child: Row(mainAxisAlignment: MainAxisAlignment.end, children: const [
          Text.rich(TextSpan(children: <TextSpan>[
            TextSpan(
                text: "* ",
                style: TextStyle(
                  color: SrColors.primary,
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                )),
            TextSpan(
                text: "는 필수입력 사항입니다",
                style: TextStyle(
                    color: SrColors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w300)),
          ])),
        ]),
      )
    ];
  }

  List<Widget> _InputSpotName() {
    return [
      _TextFieldLabel("장소명을 입력해 주세요", true),
      Padding(padding: const EdgeInsets.only(bottom: 16), child: SrTextField()),
    ];
  }

  List<Widget> _InputSpotProvince() {
    return [
      _TextFieldLabel("시/도를 입력해주세요", true),
      Padding(
        padding: EdgeInsets.only(bottom: 16),
        child: SrTextField(),
      ),
    ];
  }

  List<Widget> _InputSpotCity() {
    return [
      _TextFieldLabel("시/군/구를 입력해주세요", true),
      Padding(
        padding: EdgeInsets.only(bottom: 16),
        child: SrTextField(),
      ),
    ];
  }

  List<Widget> _InputSpotAddress() {
    return [
      _TextFieldLabel("상세주소를 입력해주세요", true),
      Padding(
        padding: EdgeInsets.only(bottom: 16),
        child: SrTextField(),
      ),
    ];
  }

  List<Widget> _SelectSpotCategory() {
    return [
      _TextFieldLabel(
        "카테고리를 입력해 주세요",
        false,
      ),
      Padding(
        padding: EdgeInsets.only(bottom: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 1,
              child: Obx(
                () => SrDropdownButton(
                    hasIcon: true,
                    isRequired: true,
                    dropdownItems: mainCategory,
                    hint: '대분류',
                    dropdownIconColors: mainCategoryColors,
                    onChanged: (value) {
                      addSpotController.mainIsSelected.value = true;
                      addSpotController.selectedMainString.value = value;
                      addSpotController.selectedMainIndex.value = Category.mainCategory.indexOf(value!) + 1;

                      addSpotController.subCategory.value = Category.subCategories[addSpotController.selectedMainIndex.value]!;

                      },
                    isSelected: addSpotController.mainIsSelected.value,
                    selectedString: addSpotController.selectedMainString.value),
              ),
            ),
            const SizedBox(
              width: 6,
            ),
            Flexible(
              flex: 1,
              child: Obx(
                    () => SrDropdownButton(
                    hasIcon: false,
                    isRequired: false,
                    dropdownItems: addSpotController.subCategory.value,
                    hint: '소분류',
                    onChanged: (value) {
                      addSpotController.subIsSelected.value = true;
                      addSpotController.selectedSubString.value = value;
                    },
                    isSelected: addSpotController.subIsSelected.value,
                    selectedString: addSpotController.selectedSubString.value),
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
        padding: const EdgeInsets.only(top: 8, left: 16, bottom: 16, right: 16),
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
        padding: const EdgeInsets.only(top: 4, bottom: 16),
        alignment: Alignment.center,
        child: SrRatingButton(
          ratingMode: RatingMode.interactive,
        ),
      ),
    ];
  }

  List<Widget> _Pictures() {
    return [
      _TextFieldLabel("사진 첨부", false),
      Padding(
          padding: EdgeInsets.only(top: 8, bottom: 16),
          child: SrAttachPiture()),
    ];
  }
}
