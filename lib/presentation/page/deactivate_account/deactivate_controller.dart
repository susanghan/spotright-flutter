import 'package:get/get.dart';
import 'package:spotright/data/user/user_repository.dart';

class DeactivateController extends GetxController {
  UserRepository userRepository = Get.find();

  RxBool ctaActive = false.obs;
  String inputId = "";

  void onChanged(String text) {
    inputId = text;
    ctaActive.value = inputId == userRepository.userResponse!.spotrightId!;
  }

  Future<void> deactivate() async {
    bool res = await userRepository.deactivate(inputId);
    if(res) {
      Get.to("login");
    }
  }
}