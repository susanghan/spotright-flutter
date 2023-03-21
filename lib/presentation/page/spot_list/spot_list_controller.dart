import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:spotright/data/spot/spot_repository.dart';
import 'package:spotright/data/spot/spot_response.dart';
import 'package:spotright/data/user/user_repository.dart';
import 'package:spotright/presentation/common/colors.dart';
import 'package:spotright/presentation/common/typography.dart';
import 'package:spotright/presentation/component/dialog/sr_dialog.dart';
import 'package:spotright/presentation/page/detail/detail.dart';

class SpotListController extends GetxController {
  SpotRepository spotRepository = Get.find();
  UserRepository userRepository = Get.find();
  RxBool isEditMode = false.obs;
  RxSet<String> selectedCategories = <String>{"전체"}.obs;
  final RxList<SpotResponse> _spots = <SpotResponse>[].obs;
  RxList<SpotResponse> get spots => _spots
      .where((spot) => selectedCategories.contains("전체") || selectedCategories.contains(spot.mainCategory))
      .toList().obs;
  int userId = 0;
  RxSet<int> toRemoveSpotIds = <int>{}.obs;
  double topLatitude = 90;
  double topLongitude = -180;
  double bottomLatitude = 0;
  double bottomLongitude = 179.999999;
  RxBool isMyPage = false.obs;
  RxBool isAllSelected = false.obs;

  void changeMode() {
    isEditMode.value = !isEditMode.value;
  }

  Future<bool> pressBack() async {
    if(isEditMode.value) {
      isEditMode.value = false;
    } else {
      Get.back();
    }

    return false;
  }

  void onAllSelected(bool checked) {
    isAllSelected.value = checked;
    if(checked) {
      toRemoveSpotIds.addAll(spots.map((spot) => spot.memberSpotId!));
    } else {
      toRemoveSpotIds.clear();
    }
  }

  Future<void> initState(int userId, double topLatitude, double topLongitude,
      double bottomLatitude, double bottomLongitude) async {
    this.userId = userId;
    this.topLatitude = topLatitude;
    this.topLongitude = topLongitude;
    this.bottomLatitude = bottomLatitude;
    this.bottomLongitude = bottomLongitude;

    isMyPage.value = userRepository.userResponse!.memberId == userId;
    isEditMode.value = false;

    await _fetchSpots();
  }

  Future<void> _fetchSpots() async {
    _spots.value = await spotRepository.getSpotsFromCoordinate(
      userId,
      topLatitude: topLatitude,
      topLongitude: topLongitude,
      bottomLatitude: bottomLatitude,
      bottomLongitude: bottomLongitude,
    );
  }

  Function() moveDetail(SpotResponse spot) => () => Get.to(Detail(userId: userId, memberSpotId: spot.memberSpotId!));

  onCategorySelected(String category, bool isSelected) {
    if(category == "전체" && isSelected) {
      selectedCategories.value = {};
      selectedCategories.add(category);
    } else if (category != "전체" && isSelected){
      selectedCategories.remove("전체");
      selectedCategories.add(category);
    } else {
      selectedCategories.remove(category);
    }
  }

  void onCheckBoxSelected(int spotId, bool isChecked) {
    if(isChecked) {
      toRemoveSpotIds.add(spotId);
    } else {
      toRemoveSpotIds.remove(spotId);
    }
  }

  Future<void> finishEdit() async {
    Get.dialog(
      SrDialog(
        icon: SvgPicture.asset("assets/triangle.svg"),
        title: "정말 삭제하시겠습니까?",
        description: "삭제하면 목록에서 사라집니다",
        actions: [
          TextButton(onPressed: () => Get.back(), child: Text("취소하기", style: SrTypography.body2medium.copy(color: SrColors.white))),
          TextButton(onPressed: () async {
            Get.back();
            await spotRepository.deleteSpots(toRemoveSpotIds.toList());
            await _fetchSpots();
            toRemoveSpotIds.clear();
            changeMode();
          }, child: Text("삭제하기", style: SrTypography.body2medium.copy(color: SrColors.white))),
        ],
      )
    );
  }
}
