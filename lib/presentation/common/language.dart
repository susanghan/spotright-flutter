import 'package:get/get.dart';

class Languages extends Translations {

  @override
  Map<String, Map<String, String>> get keys => {
    'ko_KR': {
      // common
      'finish': '완료',
      'verify': '확인',

      // login
      'login_id_hint': '아이디를 입력하세요',
      'login_password_hint': '비밀번호를 입력하세요',
      'login': '로그인',
      'find_id': '아이디 찾기',
      'find_password': '비밀번호 찾기',
      'inform_sign_up': '아직 Spotright에 가입하지 않으셨나요? ',
      'sign_up': '회원가입',
      'failed_to_login': '로그인에 실패했습니다',

      // sign up
      'input_email': '이메일을 입력해주세요',
      'authenticate': '인증하기',

      'input_id': '아이디를 입력해주세요',
      'input_id_hint': '아이디',
      'verify_duplication': '중복확인',

      'input_password': '비밀번호를 입력해주세요',
      'input_password_hint': '비밀번호',
      'input_password_confirm': '비밀번호를 다시 한 번 입력해주세요',
      'input_nickname': '닉네임을 입력해주세요',
      'input_birthdate': '생년월일은 입력해주세요',
      'input_sex': '성별을 입력해주세요',
      'male': '남자',
      'female': '여자',
      'none': '선택안함',
      'select_join_path': '가입경로를 선택해주세요',
      'instagram': '인스타그램',
      'everytime': '에브리타임',
      'acquaintance': '지인',
      'etc': '기타',
      'sign_up_privacy_policy': '개인정보 수집 및 이용동의(필수)',

      // validation
      'id_default_message': "영문자, 숫자, 특수문자('-', '_')를 사용해 입력해 주세요",
      'id_check_length': '아이디는 6~16자여야 합니다',
      'id_check_duplicate': '중복된 아이디입니다',
      'id_enabled': '사용 가능한 아이디입니다',
      'id_verify_duplication': '중복 검사를 해주세요',

      'nickname_default_message': '한글 혹은 영문자를 사용해 10자 이내로 입력해 주세요',
      'nickname_check_length': '닉네임은 10자 이내여야 합니다',
      'nickname_check_special_character': '한글 혹은 영문자만 입력해 주세요',
      'nickname_enabled': '사용 가능한 닉네임입니다',

      'password_default_message': '영문, 숫자, 특수문자(#\$@!%&*?) 조합으로 입력해주세요',
      'password_check_length': '비밀번호는 8~16자여야 합니다',
      'password_enabled': '사용 가능한 비밀번호입니다',
      'password_confirm_valid': '비밀번호가 일치합니다',
      'password_confirm_invalid': '비밀번호가 일치하지 않습니다',

      'empty': '',

      // map & app bar
      'spot': '장소',
      'follower': '팔로워',
      'following': '팔로잉',
      'my_page': '마이페이지',
      'follow': '팔로우',
      'unfollow': '팔로잉',
      'search_in_this_region': '이 지역에서 검색하기',
      'show_spot_list': '목록보기',

      // dialog
      'no_spots': '검색 결과가 없습니다',
      'search_at_another_location': '다른 지역으로 이동하여 검색해주세요 :)',

      'dialog_report_title': '부적절한 사용자',
      'dialog_reprot_description': '사용자를 더이상 보고 싶지 않나요?',
      'dialog_report': '신고하기',
      'dialog_block': '차단하기',

      'dialog_report_reason': '사용자 신고 사유',
      'dialog_finished_block': '차단이 완료되었습니다',
      'dialog_unblock_information': '마이페이지-차단 사용자 관리에서\w확인할 수 있습니다',

      // report
      'id': '아이디',
      'nickname': '닉네임',
      'profile_photo': '프로필 사진',
      'promotion': '홍보성',
      'harmful_content': '유해한 내용',
      'lewdness': '음란성/선정성',
      'abuse_and_personal_attacks': '욕설/인신공격',
      'false_information': '허위정보',

      // categories
      'all': '전체',
      'cafe': '카페',
      'tour': '관광지',
      'accommodation': '숙소',
      'shopping': '쇼핑',
      'hospital': '병원',

      // my page
      'setting_language': '언어설정',
    },

    // todo : 아래는 번역 예시이고 올바르게 바꿔주세요.
    'en_US': {
      // login
      'login_id_hint': 'ID',
      'login_password_hint': 'Password',
      'login': 'Login',
      'find_id': 'Find id',
      'find_password': 'Find password',
      'inform_sign_up': "If you don't have ID for Spotright ",
      'sign_up': 'Sign up',
      'failed_to_login': 'Failed to login',

      // sign up
      'input_email': '이메일을 입력해주세요',
      'input_sex': '성별을 입력해주세요',
      'setting_language': 'Setting language',
    },
  };
}