import 'package:get/get.dart';
import 'package:spotright/data/user/user_repository.dart';
import 'package:spotright/data/user/user_response.dart';

class BirthdayController extends GetxController {
  UserRepository userRepository = Get.find();
  UserResponse user = UserResponse(memberId: 0);
  Rxn<String> birthdate = Rxn('2000-06-15');
  RxBool ctaActive = false.obs;

  Future<void> initState() async {
    user = userRepository.userResponse!;
    birthdate.value = user.birthdate!;
  }

  void onBirthdateChanged(String? date) {
    birthdate.value = date;
    ctaActive.value = (birthdate.value != user.birthdate);
  }

  Future<void> changeBirthdate() async {
    Get.back();
    await userRepository.updateBirthDate(birthdate.value);
    userRepository.fetchMyInfo();
  }
}
