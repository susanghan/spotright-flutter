import 'package:get/get.dart';
import 'package:spotright/presentation/common/controller/id_validator.dart';

class SignUpState {
  final Map<MessageStatus, String> _nicknameMessageMap = {
    MessageStatus.defaultMessage: "한글 혹은 영문자를 사용해 10자 이내로 입력해 주세요",
    MessageStatus.checkLength: '닉네임은 10자 이내여야 합니다',
    MessageStatus.checkSpecialCharacter: '한글 혹은 영문자만 입력해 주세요',
    MessageStatus.enabled: '사용 가능한 닉네임입니다',
    MessageStatus.empty: '',
  };

  final Map<MessageStatus, String> _passwordMessageMap = {
    MessageStatus.defaultMessage: "영문, 숫자, 특수문자(#\$@!%&*?) 조합으로 입력해주세요",
    MessageStatus.checkLength: '비밀번호는 8~16자여야 합니다',
    MessageStatus.enabled: '사용 가능한 비밀번호입니다',
    MessageStatus.empty: '',
  };

  final IdValidator _idValidator = IdValidator();

  RxString email = "".obs;
  RxBool emailInputEnabled = true.obs;
  RxBool checkedEmail = true.obs;
  RxString id = "".obs;
  RxBool checkedIdDuplication = false.obs;
  RxString nickname = "".obs;
  RxString password = "".obs;
  RxString passwordConfirm = "".obs;
  bool get isPasswordsEqual => password.value == passwordConfirm.value;
  var idMessageStatus = IdMessageStatus.defaultMessage.obs;
  var nicknameMessageStatus = MessageStatus.defaultMessage.obs;
  var passwordMessageStatus = MessageStatus.defaultMessage.obs;
  RxString selectedJoinPath = "INSTAGRAM".obs;

  String get idValidationMessage => _idValidator.idMessageMap[idMessageStatus.value]!;
  String get nicknameValidationMessage =>
      _nicknameMessageMap[nicknameMessageStatus.value]!;
  String get passwordValidationMessage => _passwordMessageMap[passwordMessageStatus]!;
  Rxn<String> birthdate = Rxn('2000-06-15');
  RxString sex = 'NONE'.obs; // 0: 남자, 1: 여자
  RxBool privacyPolicy = false.obs;

  bool get _ctaActive =>
      checkedEmail.value &&
      checkedIdDuplication.value &&
      passwordMessageStatus.value == MessageStatus.enabled &&
          isPasswordsEqual &&
      (nicknameMessageStatus.value == MessageStatus.enabled || nicknameMessageStatus.value == MessageStatus.defaultMessage) &&
      privacyPolicy.value;

  RxBool ctaActive = false.obs;

  void onChangeCtaState() {
    ctaActive.value = _ctaActive;
  }

  void validateIdDuplication(bool checked) {
    checkedIdDuplication.value = checked;
  }

  void validateId(String id) {
    idMessageStatus.value = _idValidator.validate(id);
  }

  void validatePassword() {
    final specialRegex = RegExp(r'[^a-zA-Z0-9#$@!%&*?]');
    if(specialRegex.hasMatch(password.value)) {
      passwordMessageStatus.value = MessageStatus.defaultMessage;
      return;
    }

    final regex = RegExp(r'^(?=.*?[a-zA-Z])(?=.*?[0-9])(?=.*?[#$@!%&*?]).{8,30}$');
    if (regex.hasMatch(password.value)) {
      passwordMessageStatus.value = MessageStatus.enabled;
      return;
    }

    if (password.isEmpty) {
      passwordMessageStatus.value = MessageStatus.defaultMessage;
    } else if (password.value.length < 8 || password.value.length > 30) {
      passwordMessageStatus.value = MessageStatus.checkLength;
    } else {
      passwordMessageStatus.value = MessageStatus.defaultMessage;
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

  void changeBirthdate(String? newBirthdate) {
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
