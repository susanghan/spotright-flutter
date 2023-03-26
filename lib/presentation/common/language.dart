import 'package:get/get.dart';

class Languages extends Translations {

  @override
  Map<String, Map<String, String>> get keys => {
    "ko_KR": {
      // login
      "login_id_hint": "아이디를 입력하세요",
      "login_password_hint": "비밀번호를 입력하세요",
      "login": "로그인",
      "find_id": "아이디 찾기",
      "find_password": "비밀번호 찾기",
      "inform_sign_up": "아직 Spotright에 가입하지 않으셨나요? ",
      "sign_up": "회원가입",
      "failed_to_login": "로그인에 실패했습니다",

      // sign up
      "input_email": "이메일을 입력해주세요",
      "input_sex": "성별을 입력해주세요",
      "setting_language": "언어설정",
    },
    "en_US": {
      // login
      // todo : 아래는 번역 예시이고 올바르게 바꿔주세요.
      "login_id_hint": "ID",
      "login_password_hint": "Password",
      "login": "Login",
      "find_id": "Find id",
      "find_password": "Find password",
      "inform_sign_up": "If you don't have ID for Spotright ",
      "sign_up": "Sign up",
      "failed_to_login": "Failed to login",

      // sign up
      "input_email": "이메일을 입력해주세요",
      "input_sex": "성별을 입력해주세요",
      "setting_language": "Setting language",
    },
  };
}