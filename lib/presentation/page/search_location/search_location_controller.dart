import 'package:get/get.dart';
import '../../../data/user/user_repository.dart';
import '../../../data/user/user_response.dart';

class SearchLocationController extends GetxController{
  UserRepository userRepository = Get.find();

  Rx<UserResponse>? userInfo;

  void initState() {
    userInfo = Rx<UserResponse>(userRepository.userResponse!);
  }

  var countryState = CountryState.SOUTH_KOREA.obs;

  String get countryImage {
    if(countryState.value == CountryState.SOUTH_KOREA) return 'assets/flag_korea.svg';
    if(countryState.value == CountryState.UNITED_STATES) return 'assets/flag_usa.svg';
    if(countryState.value == CountryState.CANADA) return 'assets/flag_canada.svg';
    return 'assets/flag_korea.svg';
  }

}

enum CountryState{
  CANADA,
  SOUTH_KOREA,
  UNITED_STATES
}

enum QueryTypeState{
  ADDRESS,
  COORDINATE,
  KEYWORD
}