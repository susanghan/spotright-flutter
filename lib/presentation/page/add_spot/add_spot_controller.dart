import 'dart:ffi';
import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:spotright/data/spot/location_response.dart';

import '../../../data/resources/category.dart';
import '../../../data/resources/enum_country.dart';
import '../../../data/resources/geo.dart';

class AddSpotController extends GetxController{

  void initState(){
    provinceController = TextEditingController();
    cityController = TextEditingController();

    subCategory.value = [];

    selectedMainIndex.value = 0;
    mainIsSelected.value = false;
    selectedMainString.value = null;

    selectedSubIndex.value = 0;
    subIsSelected.value = false;
    selectedSubString.value = null;

    isVisited.value = false;

    spotName.value = "";
    countryState.value = Country.SOUTH_KOREA;
    province.value = "";
    city.value = "";
    address.value = "";

    searchCityMap.value= {"" : [""]};
    searchCityList.value = [""];

    setSearchProvinceList();
    setSearchCityList(province.value);
  }

  //**inputController
  TextEditingController provinceController = TextEditingController();
  TextEditingController cityController = TextEditingController();

  //**장소
  RxString spotName = "".obs;

  //**주소
  var countryState = Country.SOUTH_KOREA.obs;
  RxList<String> searchProvinceList = [""].obs;
  RxMap<String, List<String>> searchCityMap = {"" : [""]}.obs;
  RxList<String> searchCityList = [""].obs;

  RxString province = "".obs;
  RxString city = "".obs;
  RxString address = "".obs;

  void setSearchProvinceList() {
    if(countryState.value == Country.SOUTH_KOREA) {
      searchProvinceList.value = Geo.SOUTH_KOREA.keys.toList();
      searchCityMap.value = Geo.SOUTH_KOREA;
    }
    if(countryState.value == Country.UNITED_STATES) {
      searchProvinceList.value = Geo.UNITED_STATES.keys.toList();
      searchCityMap.value = Geo.UNITED_STATES;
    }
    if(countryState.value == Country.CANADA) {
      searchProvinceList.value = Geo.CANADA.keys.toList();
      searchCityMap.value = Geo.CANADA;
    }
  }

  void setSearchCityList(String? keyword) {
    searchCityList.value = searchCityMap[keyword]?.toList() ?? [];
  }




  //**선택된 카테고리
  final List<String> mainCategory = Category.mainCategory;
  final List<Color> mainCategoryColors = Category.mainCategoryColors;
  RxList<String> subCategory = [""].obs;

  RxInt selectedMainIndex = 0.obs;
  RxBool mainIsSelected = false.obs;
  Rxn<String> selectedMainString = Rxn<String>();

  RxInt selectedSubIndex = 0.obs;
  RxBool subIsSelected = false.obs;
  Rxn<String> selectedSubString = Rxn<String>();

  //**방문 여부
  RxBool isVisited = false.obs;
}