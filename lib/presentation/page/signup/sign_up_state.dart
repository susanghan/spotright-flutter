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
    MessageStatus.checkDuplicate: '한글 혹은 영문자만 입력해 주세요.',
    MessageStatus.enabled: '사용 가능한 닉네임입니다.',
    MessageStatus.empty: '',
  };

  var ctaActive = false.obs;
  var idMessageStatus = MessageStatus.defaultMessage.obs;
  var nicknameMessageStatus = MessageStatus.defaultMessage.obs;
  String get idValidationMessage => _idMessageMap[idMessageStatus.value]!;
  String get nicknameValidationMessage => _nicknameMessageMap[nicknameMessageStatus.value]!;
  RxInt sex = 0.obs;
  RxBool privacyPolicy = false.obs;

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
}

enum MessageStatus {
  defaultMessage,
  checkLength,
  checkSpecialCharacter,
  checkDuplicate,
  enabled,
  empty
}
