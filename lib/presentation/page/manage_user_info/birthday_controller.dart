import 'package:get/get.dart';

class BirthdayController extends GetxController {
  RxString birthdate = "2000-01-01".obs;

  void onBirthdateChanged(String date) {
    birthdate.value = date;
  }
}
