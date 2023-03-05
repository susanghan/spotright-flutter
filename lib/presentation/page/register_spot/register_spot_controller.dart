import 'dart:ffi';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:spotright/data/spot/spot_repository.dart';
import 'package:spotright/data/spot/spot_request.dart';
import 'package:spotright/presentation/page/search_location/search_location_controller.dart';

import '../../../data/resources/category.dart';
import '../../../data/resources/enum_country.dart';
import '../../../data/resources/geo.dart';

class RegisterSpotController extends GetxController {
  SearchLocationController searchLocationController = Get.find();
  final SpotRepository spotRepository = Get.find();

  PageMode pageMode = PageMode.add;

  void initState(PageMode _pageMode) {
    pageMode = _pageMode;

    provinceController = TextEditingController();
    cityController = TextEditingController();
    spotNameController = TextEditingController();
    addressController = TextEditingController();
    memoController = TextEditingController();

    subCategory.value = [];

    selectedMainIndex.value = 0;
    mainIsSelected.value = false;
    selectedMainString.value = null;

    selectedSubIndex.value = 0;
    subIsSelected.value = false;
    selectedSubString.value = null;

    isVisited.value = false;

    countryState.value = Country.SOUTH_KOREA;

    searchProvinceList.value = [""];
    searchCityMap.value = {
      "": [""]
    };
    searchCityList.value = [""];

    setSearchProvinceList();
    setSearchCityList(provinceController.text);


    isCtaActive.value = false;
  }

  //**inputController
  TextEditingController spotNameController = TextEditingController();
  TextEditingController provinceController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController memoController = TextEditingController();

  //**주소
  var countryState = Country.SOUTH_KOREA.obs;
  RxList<String> searchProvinceList = [""].obs;
  RxMap<String, List<String>> searchCityMap = {
    "": [""]
  }.obs;
  RxList<String> searchCityList = [""].obs;


  void setSearchProvinceList() {
    if (countryState.value == Country.SOUTH_KOREA) {
      searchProvinceList.value = Geo.SOUTH_KOREA.keys.toList();
      searchCityMap.value = Geo.SOUTH_KOREA;
    }
    if (countryState.value == Country.UNITED_STATES) {
      searchProvinceList.value = Geo.UNITED_STATES.keys.toList();
      searchCityMap.value = Geo.UNITED_STATES;
    }
    if (countryState.value == Country.CANADA) {
      searchProvinceList.value = Geo.CANADA.keys.toList();
      searchCityMap.value = Geo.CANADA;
    }
  }

  void setSearchCityList(String? keyword) {
    searchCityList.value = searchCityMap[keyword]?.toList() ?? [];
  }

  //**선택된 카테고리
  final List<String> mainCategory = SpotCategory.mainCategory;
  final List<Color> mainCategoryColors = SpotCategory.mainCategoryColors;
  RxList<String> subCategory = [""].obs;

  RxInt selectedMainIndex = 0.obs;
  RxBool mainIsSelected = false.obs;
  Rxn<String> selectedMainString = Rxn<String>();

  RxInt selectedSubIndex = 0.obs;
  RxBool subIsSelected = false.obs;
  Rxn<String> selectedSubString = Rxn<String>();

  //**방문 여부
  RxBool isVisited = false.obs;

  //**별점
  RxDouble rating = 0.0.obs;

  //**완료 버튼
  RxBool isCtaActive = false.obs;

  bool get _isCtaActive => ((spotNameController.text.length>= 3) &&
      provinceController.text.isNotEmpty &&
  cityController.text.isNotEmpty &&
  addressController.text.isNotEmpty &&
  mainIsSelected.value);

  void onChangeCtaState() {
    isCtaActive.value = _isCtaActive;
  }


  int encodeCategory() {
    String mainCode = "0";
    String subCode = "00";
    int totalCode = 000;

    mainCode = ((selectedMainIndex.value += 7) % 7).toString();

    if (mainCode != "0") {
      if (selectedSubString.value == null) {
        subCode = "00";
        totalCode = int.parse(mainCode + subCode);
      } else {
        subCode = ((selectedSubIndex.value + subCategory.length * 2 + 2) %
                (subCategory.length * 2))
            .toString();
        if (subCode.length < 2) {
          subCode = "0$subCode";
        }
        totalCode = int.parse(mainCode + subCode);
      }
    } else {
      totalCode = 0;
    }
    return totalCode;
  }

  Future<void> submitAction() async {
    if (isVisited.value == false) {
      rating.value = 0.0;
    }

    print("아이ㅓ머야${isCtaActive.value}");

    encodeCategory();

    SpotRequest req = SpotRequest(
      address: addressController.text,
      category: 100,
      city: cityController.text,
      country: describeEnum(countryState.value).toString(),
      latitude: searchLocationController.markerPosition.value.latitude,
      longitude: searchLocationController.markerPosition.value.longitude,
      memo: memoController.text,
      province: provinceController.text,
      rating: "${rating.value.round()}",
      spotName: spotNameController.text
    );

    print("address ${addressController.text.runtimeType}");
    print("category ${encodeCategory().runtimeType}");
    print("city ${cityController.text.runtimeType}");
    print("country ${describeEnum(countryState.value).toString().runtimeType}");
    print("latitude ${searchLocationController.markerPosition.value.latitude.runtimeType}");
    print("longitude ${searchLocationController.markerPosition.value.longitude.runtimeType}");
    print("memo ${memoController.text.runtimeType}");
    print("province ${provinceController.text.runtimeType}");
    print("rating ${rating.value.round().toString().runtimeType}");
    print("spotName ${spotNameController.text.runtimeType}");

    await spotRepository.saveSpot(req);
  }
}

enum PageMode {
  add,
  edit
}