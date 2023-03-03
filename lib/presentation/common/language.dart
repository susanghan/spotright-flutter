import 'package:get/get.dart';

class Languages extends Translations {

  @override
  Map<String, Map<String, String>> get keys => {
    "ko_KR": {
      // sign up
      "input_email": "이메일을 입력해주세요.",
      "input_sex": "성별을 입력해주세요.",
      "settingLanguage": "언어설정",
    },
    "en_US": {
      // sign up
      "input_email": "이메일을 입력해주세요.",
      "input_sex": "성별을 입력해주세요.",
      "settingLanguage": "Setting language",
    },
  };
}