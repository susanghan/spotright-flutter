import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:spotright/data/spot/spot_repository.dart';
import 'package:spotright/data/spot/spot_request.dart';
import 'package:spotright/presentation/common/colors.dart';
import 'package:spotright/presentation/component/dialog/sr_dialog.dart';
import 'package:spotright/presentation/page/detail/detail_controller.dart';
import 'package:spotright/presentation/page/search_location/search_location_controller.dart';

import '../../../data/resources/category.dart';
import '../../../data/resources/enum_country.dart';
import '../../../data/resources/geo.dart';
import 'package:spotright/data/file/file_repository.dart';
import '../../../data/spot/location_request.dart';
import '../../../data/spot/location_response.dart';
import '../../common/typography.dart';
import '../home/home.dart';

class RegisterSpotController extends GetxController {
  SearchLocationController searchLocationController = Get.find();
  DetailController detailController = Get.find();
  final SpotRepository spotRepository = Get.find();
  final FileRepository fileRepository = Get.find();

  PageMode pageMode = PageMode.add;

  void setEditInit() {
    init.value = false;

    spotNameController.text = detailController.spot.value.spotName ?? "";
    provinceController.text = detailController.spot.value.province ?? "";
    cityController.text = detailController.spot.value.city ?? "";
    addressController.text = detailController.spot.value.address ?? "";

    spotnameText.value = spotNameController.text;
    provinceText.value = provinceController.text;
    cityText.value = cityController.text;
    addressText.value = addressController.text;

    setSearchCityList(provinceController.text);

    selectedMainIndex.value = detailController.spot.value.mainCategoryIndex;
    mainIsSelected.value = true;
    selectedMainString.value = detailController.spot.value.mainCategory;

    subCategory.value = SpotCategory.subCategories[detailController.spot.value.mainCategoryIndex + 1]!;

    selectedSubIndex.value = detailController.spot.value.subCategoryIndex;
    subIsSelected.value = selectedSubIndex.value >= 0;
    selectedSubString.value = selectedSubIndex.value >= 0 ? subCategory.value[selectedSubIndex.value] : null;

    isVisited.value = (detailController.spot.value.rating != 0);

    rating.value = detailController.spot.value.rating?.toDouble() ?? 0.0;

    if(detailController.spot.value.spotPhotos != []){
      detailController.spot.value.spotPhotos!.map((e) => imageFilePath.value.add(e.photoUrl ?? '')).toList();
      detailController.spot.value.spotPhotos!.map((e) => spotPhotoIds.value.add(e.memberSpotPhotoId ?? 0)).toList();
    }

    memoController.text = detailController.spot.value.memo ?? "";

  }

  void initState(PageMode _pageMode) {
    pageMode = _pageMode;

    memberSpotId.value = detailController.spot.value.memberSpotId ?? 0;

    //완료 버튼 눌렀을 때 spots의 정보 받기 위함
    spot.value = <LocationResponse>[];
    spot.value = [];

    //처음에 textField 입력하려고 할 시에 강제로 지도로 페이지 이동
    init.value = true;

    spotNameController = TextEditingController();
    provinceController = TextEditingController();
    cityController = TextEditingController();
    addressController = TextEditingController();
    memoController = TextEditingController();

    spotnameText.value = '';
    provinceText.value = '';
    cityText.value = '';
    addressText.value = '';

    spotnameText.value = spotNameController.text;
    provinceText.value = provinceController.text;
    cityText.value = cityController.text;
    addressText.value = addressController.text;


    subCategory.value = [];

    selectedMainIndex.value = -2;
    mainIsSelected.value = false;
    selectedMainString.value = null;

    selectedSubIndex.value = -2;
    subIsSelected.value = false;
    selectedSubString.value = null;

    isVisited.value = false;

    rating.value = 0.0;

    countryState.value = Country.SOUTH_KOREA;

    searchProvinceList.value = [""];
    searchCityMap.value = {
      "": [""]
    };
    searchCityList.value = [""];

    setSearchProvinceList();
    setSearchCityList(provinceController.text);

    imageFilePath.value = [];
    spotPhotoIds.value = [];
    spotDeletedPhotoIds.value = [];


    if (_pageMode == PageMode.edit) {
      setEditInit();
    }

    isEvaluated;
    isCtaActive;
  }
  //**초기
  RxBool init = true.obs;

  //**inputController
  TextEditingController spotNameController = TextEditingController();
  TextEditingController provinceController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController memoController = TextEditingController();

  RxString spotnameText = ''.obs;
  RxString provinceText = ''.obs;
  RxString cityText = ''.obs;
  RxString addressText = ''.obs;

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

  //**사진
  RxList<String> imageFilePath = [''].obs;
  RxInt memberSpotId = 0.obs;
  RxList<int> spotPhotoIds = [0].obs;
  RxList<int> spotDeletedPhotoIds = [0].obs;
  Future<void> uploadSpotPhotos() async {
    imageFilePath.value.removeWhere((element) => element.contains("http"));
    imageFilePath.value != [] ? fileRepository.uploadSpotImages(imageFilePath.value, memberSpotId.value) : null;
  }

  //**완료 버튼
  bool get isCtaActive => (spotnameText.value.isNotEmpty && provinceText.value.isNotEmpty && cityText.value.isNotEmpty && addressText.value.isNotEmpty && mainIsSelected.value && isEvaluated);
  bool get isEvaluated => !isVisited.value ? true : rating.value > 0 ? true : false;

  int encodeCategory() {
    String mainCode = "0";
    String subCode = "00";
    int resultCode = 000;

    mainCode = ((selectedMainIndex.value + mainCategory.length + 1) % mainCategory.length).toString();

   if(mainCode != "0"){
     if(subCategory.isEmpty){
       return resultCode = int.parse("${mainCode}00");
     }
     else if(selectedSubString.value == "기타"){
       return resultCode = int.parse("${mainCode}01");
     }
     else{
       subCode = ((selectedSubIndex.value + (subCategory.length * 2) + 2) % (subCategory.length * 2)).toString();
       if(subCode.length < 2) {
         subCode = "0$subCode";
       }
       return resultCode = int.parse(mainCode + subCode);
     }
   }
   return resultCode = 0;


  }

  RxList<LocationResponse> spot = <LocationResponse>[].obs;

  Future<void> searchSpot(String _searchQuery) async {
    LocationRequest req = LocationRequest(
        country: describeEnum(countryState.value).toString(),
        queryType: "ADDRESS",
        searchQuery: _searchQuery);

    spot.value = await spotRepository.searchSpot(req);
  }

  Future<void> checkLatLngExist() async {
    spot.isEmpty ? {await searchSpot(provinceController.text + cityController.text), Fluttertoast.showToast(msg: "입력한 주소가 정확하지 않습니다")} : spot[0].latitude != null ? null : {await searchSpot(provinceController.text + cityController.text), Fluttertoast.showToast(msg: "입력한 주소가 정확하지 않습니다")};
  }

  Future<void> addSpot() async {

    if (isVisited.value == false) {
      rating.value = 0.0;
    }

    await searchSpot(provinceController.text + cityController.text + addressController.text);

    await checkLatLngExist();

    int totalCode = encodeCategory();

    //사진 제외 스팟 정보 넣기
    SpotRequest req = SpotRequest(
        address: addressController.text,
        category: totalCode,
        city: cityController.text,
        country: describeEnum(countryState.value).toString(),
        //latitude: searchLocationController.markerPosition.value.latitude,
        //longitude: searchLocationController.markerPosition.value.longitude,
        latitude: spot.isNotEmpty ? spot[0].latitude : searchLocationController.markerPosition.value.latitude,
        longitude: spot.isNotEmpty ? spot[0].longitude : searchLocationController.markerPosition.value.longitude,
        memo: memoController.text,
        province: provinceController.text,
        rating: "${rating.value.round()}",
        spotName: spotNameController.text);

    var res = await spotRepository.saveSpot(req);

    if(res.statusCode == 200 || res.statusCode == 201){
      memberSpotId.value = res.spotResponse?.memberSpotId ?? 0;
      uploadSpotPhotos();
      Get.back(result: LatLng(res.spotResponse?.latitude ?? searchLocationController.markerPosition.value.latitude, res.spotResponse?.longitude ?? searchLocationController.markerPosition.value.longitude));
    }
    else{
      checkRegisterError(res.statusCode, res.responseCode, res.responseMessage);
    }

  }

  Future<void> checkRegisterError(int statusCode, String? responseCode, String? responseMessage ) async {
    Get.dialog(SrDialog(
      icon: SvgPicture.asset("assets/warning.svg"),
      title: "스팟 저장 오류",
      description: responseMessage ?? "입력 내용을 다시 한 번 확인해 주세요",
      actions: [
        TextButton(onPressed: () => Get.back(), child: Text("완료", style: SrTypography.body2medium.copy(color: SrColors.white),))
      ],
    ));
  }



  Future<void> editSpot() async {
    if (isVisited.value == false) {
      rating.value = 0.0;
    }

    int totalCode = encodeCategory();

   await searchSpot(provinceController.text + cityController.text + addressController.text);

   await checkLatLngExist();


    //사진 제외 스팟 정보 넣기
    SpotRequest req = SpotRequest(
        memberSpotId: memberSpotId.value,
        address: addressController.text,
        category: totalCode,
        city: cityController.text,
        country: describeEnum(countryState.value).toString(),
        deleteSpotPhotoIds: spotDeletedPhotoIds,
        //latitude: searchLocationController.markerPosition.value.latitude,
        //longitude: searchLocationController.markerPosition.value.longitude,
        latitude: spot.isNotEmpty ? spot[0].latitude : searchLocationController.markerPosition.value.latitude,
        longitude: spot.isNotEmpty ? spot[0].longitude : searchLocationController.markerPosition.value.longitude,
        memo: memoController.text,
        province: provinceController.text,
        rating: "${rating.value.round()}",
        spotName: spotNameController.text);

    var res = await spotRepository.updateSpot(req);

    if(res.statusCode == 200 || res.statusCode == 201){
      uploadSpotPhotos();
      Get.back();
    }
    else{
      checkRegisterError(res.statusCode, res.responseCode, res.responseMessage);
    }

  }
}

enum PageMode { add, edit }
