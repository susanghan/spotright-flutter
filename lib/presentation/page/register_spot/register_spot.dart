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
import 'package:spotright/presentation/page/register_spot/register_spot_controller.dart';
import 'package:spotright/presentation/page/search_location/search_location.dart';
import '../../component/buttons/sr_dropdown_button.dart';
import '../../component/sr_recommend_textfield/sr_recommend_text_field.dart';

class RegisterSpot extends StatefulWidget {
  RegisterSpot({Key? key, required this.pageMode}) : super(key: key);

  PageMode pageMode;

  @override
  State<RegisterSpot> createState() => _RegisterSpotState();
}

RegisterSpotController registerSpotController = Get.find();

final List<String> mainCategory = registerSpotController.mainCategory;
final List<Color> mainCategoryColors = registerSpotController.mainCategoryColors;
const InputBorder gray2Border = OutlineInputBorder(borderRadius:BorderRadius.all(Radius.circular(22)),borderSide: BorderSide(width: 1, color: SrColors.gray2));


class _RegisterSpotState extends State<RegisterSpot> {
  @override
  void initState() {
    registerSpotController.initState(widget.pageMode);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
      appBar: DefaultAppBar(
          title:  widget.pageMode==PageMode.add ? "장소 추가" : "장소 수정",
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
                    ..._SubmitButton()
                  ],
                ),
              ),
            ],
          ),
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
              registerSpotController.init.value = false;
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
      Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Focus(
          onFocusChange: (focus) {
            registerSpotController.init.value ? Get.to(SearchLocation()) : null;
            registerSpotController.init.value = false;
          },
          child: SrTextField(
            hint: "장소명",
            controller: registerSpotController.spotNameController,
            textInputAction: TextInputAction.next,
            onChanged: (text){
              registerSpotController.spotnameText.value = text;
            },
          ),
        ),
      ),
    ];
  }

  List<Widget> _InputSpotProvince() {
    return [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _TextFieldLabel("시/도를 입력해주세요", true),
          Padding(
            padding: EdgeInsets.only(bottom: 16),
            child: Obx(() => SrRecommendTextField(
                  hint:"도/시",
                  enabled: !registerSpotController.init.value || registerSpotController.spotnameText.value.isNotEmpty,
                  inputController: registerSpotController.provinceController,
                  searchList: registerSpotController.searchProvinceList.value,
                  onChanged: (text) {
                    registerSpotController.provinceText.value = text;
                    registerSpotController.setSearchCityList(
                        registerSpotController.provinceController.text);
                  },
                  onDropdownPressed: () {
                    registerSpotController.setSearchCityList(
                        registerSpotController.provinceController.text);
                  },
                  focusOut: () {
                    registerSpotController.setSearchCityList(
                        registerSpotController.provinceController.text);
                  },
                )),
          ),
        ],
      )
    ];
  }

  List<Widget> _InputSpotCity() {
    return [
      _TextFieldLabel("시/군/구를 입력해주세요", true),
      Padding(
        padding: EdgeInsets.only(bottom: 16),
        child: Obx(() => SrRecommendTextField(
              hint: "시/군/구",
              enabled: registerSpotController.provinceText.value.isNotEmpty,
              inputController: registerSpotController.cityController,
              searchList: registerSpotController.searchCityList.value,
              onChanged: (text) {
                registerSpotController.cityText.value = text;
              },
              onDropdownPressed: () {},
              focusOut: () {},
            )),
      ),
    ];
  }

  List<Widget> _InputSpotAddress() {
    return [
      _TextFieldLabel("상세주소를 입력해주세요", true),
      Padding(
        padding: EdgeInsets.only(bottom: 16),
        child: Obx(()=>SrTextField(
          hint: "상세주소",
          enabled: registerSpotController.cityText.value.isNotEmpty,
          controller: registerSpotController.addressController,
          textInputAction: TextInputAction.next,
          onChanged: (text) {
            registerSpotController.addressText.value = text;
          },
        ),)
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
                      registerSpotController.mainIsSelected.value = true;
                      registerSpotController.selectedMainString.value = value;
                      registerSpotController.selectedMainIndex.value =
                          SpotCategory.mainCategory.indexOf(value!);
                      registerSpotController.subIsSelected.value = false;
                      registerSpotController.selectedSubIndex.value = -2;
                      registerSpotController.selectedSubString.value = null;
                      registerSpotController.subCategory.value =
                          SpotCategory.subCategories[
                              registerSpotController.selectedMainIndex.value + 1]!;

                    },

                    isSelected: registerSpotController.mainIsSelected.value,
                    selectedString: registerSpotController.selectedMainString.value),
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
                    dropdownItems: registerSpotController.subCategory.value,
                    hint: registerSpotController.subCategory.isNotEmpty || !registerSpotController.mainIsSelected.value ? '소분류' : '선택 사항 없음',
                    onChanged: (value) {
                      registerSpotController.subIsSelected.value = true;
                      registerSpotController.selectedSubString.value = value;
                      //Todo : 선택 없음과 기타는 코드가 앞임을 주의!! 따로 함수 만들어서 하든가 하기
                      registerSpotController.selectedSubIndex.value =
                          registerSpotController.subCategory.value.indexOf(value!);
                    },
                    isSelected: registerSpotController.subIsSelected.value,
                    selectedString: registerSpotController.selectedSubString.value),
              ),
            ),
          ],
        ),
      )
    ];
  }

  List<Widget> _InputVisitation() {
    return [
      _TextFieldLabel("방문한 장소인가요?", true),
      Padding(
        padding: const EdgeInsets.only(top: 8, left: 16, bottom: 17, right: 16),
        child: Row(
          children: [
            Flexible(
              child: GestureDetector(
                onTap: () {
                  registerSpotController.isVisited.value = true;
                },
                child: Obx(() => Row(children: [
                      const Padding(
                          padding: EdgeInsets.only(right: 8), child: Text("예")),
                      SrCheckBox(
                          value: registerSpotController.isVisited.value,
                          onChanged: (checked) {
                            registerSpotController.isVisited.value = true;
                          }),
                    ])),
              ),
            ),
            Flexible(
              child: GestureDetector(
                onTap: () {
                  registerSpotController.isVisited.value = false;
                },
                child: Obx(() => Row(children: [
                      const Padding(
                          padding: EdgeInsets.only(right: 8),
                          child: Text("아니오")),
                      SrCheckBox(
                          value: !registerSpotController.isVisited.value,
                          onChanged: (checked) {
                            registerSpotController.isVisited.value = false;
                          }),
                    ])),
              ),
            ),
          ],
        ),
      )
    ];
  }

  List<Widget> _InputRating() {
    return [
      Obx(() => Visibility(
          visible: registerSpotController.isVisited.value,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _TextFieldLabel("별점", true),
              Container(
                padding: const EdgeInsets.only(top: 4, bottom: 16),
                alignment: Alignment.center,
                child: SrRatingButton(
                  ratingMode: RatingMode.interactive,
                  initialRating: registerSpotController.rating.value,
                  onRating: (rating) {
                    registerSpotController.rating.value = rating;
                  },
                ),
              ),
            ],
          )))
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

  List<Widget> _InputMemo() {
    return [
      _TextFieldLabel("메모", false),
      Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: SrTextField(
            controller: registerSpotController.memoController,
            maxLength: 140,
            maxLines: 6,
            height: 137,
          )),
    ];
  }

  List<Widget> _SubmitButton() {
    return [Padding(padding: EdgeInsets.only(bottom: 36), child: Obx(()=>SrCTAButton(
      text: "완료",
      isEnabled: registerSpotController.isCtaActive,
      action: () => widget.pageMode == PageMode.add ? registerSpotController.addSpot() : registerSpotController.editSpot(),
    )),)

    ];
  }
}
