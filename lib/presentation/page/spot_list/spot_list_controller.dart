import 'package:get/get.dart';

class SpotListController extends GetxController {
  RxBool isEditMode = false.obs;

  void changeMode() {
    isEditMode.value = !isEditMode.value;
  }

  // todo 구현해야 함
  void finishEdit() {

  }
}
