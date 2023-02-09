import 'package:get/get.dart';
import '../../../data/user/user_repository.dart';
import '../../../data/user/user_response.dart';

class SearchLocationController extends GetxController{
  UserRepository userRepository = Get.find();

  Rx<UserResponse>? userInfo;

  void initState() {
    userInfo = Rx<UserResponse>(userRepository.userResponse!);
  }
}