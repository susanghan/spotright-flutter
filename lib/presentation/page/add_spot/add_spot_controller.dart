import 'dart:ffi';
import 'dart:ui';

import 'package:get/get.dart';

import '../../../data/resources/category.dart';

class AddSpotController extends GetxController{

  //_SelectSpotCategory
  final List<String> mainCategory = Category.mainCategory;
  final List<Color> mainCategoryColors = Category.mainCategoryColors;
  RxList<String> subCategory = [""].obs;

  RxInt selectedMainIndex = 0.obs;
  RxBool mainIsSelected = false.obs;
  Rxn<String> selectedMainString = Rxn<String>();

  RxInt selectedSubIndex = 0.obs;
  RxBool subIsSelected = false.obs;
  Rxn<String> selectedSubString = Rxn<String>();

  //_InputVisitation
  RxBool isVisited = false.obs;


}