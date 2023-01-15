import 'package:get/get.dart';

class Languages extends Translations {

  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': {
      "input_sex": "sex"
    },
    'ko_KR': {
      "input_sex": "성별을 입력해주세요."
    },
  };
}