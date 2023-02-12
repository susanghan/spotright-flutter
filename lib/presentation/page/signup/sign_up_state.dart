import 'package:get/get.dart';

class SignUpState {
  final Map<MessageStatus, String> _idMessageMap = {
    MessageStatus.defaultMessage: "영문자, 숫자, 특수문자('-', '_')를 사용해 입력해 주세요.",
    MessageStatus.checkLength: '아이디는 6~16자여야 합니다.',
    MessageStatus.checkDuplicate: '중복된 아이디입니다.',
    MessageStatus.enabled: '사용 가능한 아이디입니다.',
    MessageStatus.empty: '',
  };

  final Map<MessageStatus, String> _nicknameMessageMap = {
    MessageStatus.defaultMessage: "한글 혹은 영문자를 사용해 10자 이내로 입력해 주세요.",
    MessageStatus.checkLength: '닉네임은 10자 이내여야 합니다.',
    MessageStatus.checkSpecialCharacter: '한글 혹은 영문자만 입력해 주세요.',
    MessageStatus.enabled: '사용 가능한 닉네임입니다.',
    MessageStatus.empty: '',
  };

  RxString email = "".obs;
  RxBool checkedEmail = true.obs;
  RxString id = "".obs;
  RxBool checkedIdDuplication = false.obs;
  var idMessageStatus = MessageStatus.defaultMessage.obs;
  var nicknameMessageStatus = MessageStatus.defaultMessage.obs;

  String get idValidationMessage => _idMessageMap[idMessageStatus.value]!;

  String get nicknameValidationMessage =>
      _nicknameMessageMap[nicknameMessageStatus.value]!;
  RxString birthdate = "2000-01-01".obs;
  RxInt sex = 0.obs;
  RxBool privacyPolicy = false.obs;

  bool get _ctaActive =>
      checkedEmail.value &&
      checkedIdDuplication.value &&
      (nicknameMessageStatus.value == MessageStatus.enabled) &&
      privacyPolicy.value;

  RxBool ctaActive = false.obs;

  void onChangeCtaState() {
    print("onChange CTA ${checkedEmail.value} ${checkedIdDuplication.value} ${nicknameMessageStatus.value} ${privacyPolicy.value}");

    ctaActive.value = _ctaActive;
  }

  void validateIdDuplication(bool checked) {
    checkedIdDuplication.value = checked;
  }

  void validateId(String id) {
    final regex = RegExp(r'^([0-9a-zA-Z-_]{6,16})$');
    if (regex.hasMatch(id)) {
      idMessageStatus.value = MessageStatus.empty;
      return;
    }

    if (id.isEmpty) {
      idMessageStatus.value = MessageStatus.defaultMessage;
    } else if (id.length < 6 || id.length > 16) {
      idMessageStatus.value = MessageStatus.checkLength;
    } else {
      idMessageStatus.value = MessageStatus.defaultMessage;
    }
  }

  void validateNickname(String nickname) {
    final regex = RegExp(r'^([a-zA-Zㄱ-ㅎ가-힣]{1,10})$');
    if (regex.hasMatch(nickname)) {
      nicknameMessageStatus.value = MessageStatus.enabled;
      return;
    }

    if (nickname.isEmpty) {
      nicknameMessageStatus.value = MessageStatus.defaultMessage;
    } else if (nickname.length > 10) {
      nicknameMessageStatus.value = MessageStatus.checkLength;
    } else {
      nicknameMessageStatus.value = MessageStatus.defaultMessage;
    }
  }

  void changeBirthdate(String newBirthdate) {
    birthdate.value = newBirthdate;
  }
}

enum MessageStatus {
  defaultMessage,
  checkLength,
  checkSpecialCharacter,
  checkDuplicate,
  enabled,
  empty
}
